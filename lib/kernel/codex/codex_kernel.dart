import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../chat/chat_models.dart';
import '../agent_kernel.dart';
import '../kernel_event.dart';
import '../kernel_types.dart';
import 'codex_transport.dart';

/// Adapts `codex app-server` to [AgentKernel]. Codex keeps no background
/// commands and cannot put files back, so it does not declare
/// [RunsBackgroundTasks] or [RevertsChanges]: those parts of the UI are not
/// shown for it.
class CodexKernel
    with KernelEventSource
    implements
        AgentKernel,
        SelectsModel,
        SelectsMode,
        ProvidesCommands,
        ReportsContext,
        RewindsConversation,
        LoadsHistory,
        AcceptsImages {
  CodexKernel(
    this.descriptor,
    this._transport, {
    KernelContext context = const KernelContext(),
  }) : _context = context {
    _subscription = _transport.messages.listen(_receive);
    if (context.resume case final session?) {
      _threadId = session.id;
      _loadingHistory = true;
      unawaited(_readHistory());
    }
  }

  final KernelContext _context;

  @override
  final KernelDescriptor descriptor;
  final CodexTransport _transport;
  late final StreamSubscription<Map<String, Object?>> _subscription;

  @override
  /// The server's own ([_listModels]); until it says, its default.
  late final LocalChoice model = LocalChoice(
    [],
    onChanged: (_) => emitInfoChanged(),
  );

  @override
  late final KernelChoiceSource mode = LocalChoice(
    _modes,
    onChanged: (_) => emitInfoChanged(),
  );

  @override
  KernelHealth get health => KernelHealth.ready;

  @override
  String? get sessionId => _threadId;

  @override
  Future<void> get stopped => Future.value();

  @override
  void prepare() => unawaited(_connect().catchError((_) {}));

  @override
  bool get loadingHistory => _loadingHistory;
  bool _loadingHistory = false;

  // ponytail: the whole conversation read at once (`thread/read`); page it
  // with `thread/turns/list` if long ones read slowly.
  @override
  bool get hasEarlierHistory => false;

  @override
  bool get loadingEarlier => false;

  @override
  Future<void> loadEarlier() => Future.value();

  @override
  void release() {}

  @override
  void restart() {}

  /// Modes are its approval and sandbox policies: by default full access,
  /// nothing asked, as Claude Code's bypassPermissions.
  static const _modes = [
    KernelOption(
      'full',
      'Full access',
      Icons.lock_open_rounded,
      'Edit and run anything, without asking',
    ),
    KernelOption(
      'agent',
      'Agent',
      Icons.all_inclusive_rounded,
      'Edit the workspace, ask before commands',
    ),
    KernelOption(
      'ask',
      'Ask',
      Icons.chat_bubble_outline_rounded,
      'Read-only: answer questions',
    ),
  ];

  @override
  final List<KernelCommand> commands = const [
    KernelCommand(
      'review',
      'Review uncommitted changes',
      Icons.rate_review_outlined,
    ),
    KernelCommand(
      'compact',
      'Summarize the conversation',
      Icons.compress_rounded,
    ),
    KernelCommand(
      'init',
      'Write an AGENTS.md for this project',
      Icons.description_outlined,
    ),
    KernelCommand('diff', 'Show the git diff', Icons.difference_outlined),
    KernelCommand('new', 'Start a new chat', Icons.add_comment_outlined),
  ];

  @override
  int get contextWindow => 272000;

  int _requests = 0;
  final Map<Object, Completer<Map<String, Object?>>> _responses = {};

  /// Initialized; again once the server ended.
  Future<void>? _connected;

  /// Whether the server has the thread loaded, to start turns in.
  bool _threadLoaded = false;
  String? _threadId;

  /// The server's turns of the thread, in order: to rewind to one.
  final List<String> _turnIds = [];

  /// Whether history is being shown, not done now: no change to review.
  bool _replaying = false;

  /// Ours, and the server's for the same turn once it says.
  String? _turn;
  String? _serverTurn;

  /// When [_turn] began, to time it.
  DateTime? _turnStarted;
  final Set<String> _sentTurns = {};

  final Map<String, int> _textLength = {};
  final Map<String, StringBuffer> _reasoning = {};
  final Map<String, Stopwatch> _reasoningClock = {};

  /// The part of each summary streaming in.
  final Map<String, int> _reasoningPart = {};
  final Map<String, DateTime> _startedAt = {};

  /// Commands started and not completed yet, as they started.
  final Map<String, Map<String, Object?>> _commands = {};

  /// Pending approvals: our request id → the server's JSON-RPC id.
  final Map<String, Object?> _approvals = {};

  /// The approval policy, sandbox mode (a thread's) and sandbox policy (a
  /// turn's) of [mode].
  (String, String, Map<String, Object?>) get _policy => switch (mode.selected) {
    'ask' => ('never', 'read-only', {'type': 'readOnly'}),
    'agent' => ('on-request', 'workspace-write', {'type': 'workspaceWrite'}),
    _ => ('never', 'danger-full-access', {'type': 'dangerFullAccess'}),
  };

  // --- Commands -------------------------------------------------------------

  Future<Map<String, Object?>> _request(
    String method,
    Map<String, Object?> params,
  ) {
    final id = ++_requests;
    final response = Completer<Map<String, Object?>>();
    _responses[id] = response;
    _transport.write({'id': id, 'method': method, 'params': params});
    return response.future;
  }

  @override
  void send(KernelTurn turn) {
    if (!_sentTurns.add(turn.id)) return;
    _turn = turn.id;
    _turnStarted = DateTime.now();
    emit(TurnStarted(nextSeq, turn.id));
    emit(
      ItemUpserted(
        nextSeq,
        turn.id,
        UserMessageItem(text: turn.text, images: turn.images),
      ),
    );
    unawaited(_start(turn));
  }

  Future<void> _connect() => _connected ??= _open().then(
    (_) {},
    onError: (Object error) {
      _connected = null;
      throw error;
    },
  );

  Future<void> _open() async {
    await _request('initialize', {
      'clientInfo': {'name': 'baocode', 'title': 'BaoCode', 'version': '1.0.0'},
    });
    _transport.write({'method': 'initialized'});
    unawaited(_listModels());
  }

  Future<void> _listModels() async {
    try {
      final listed = await _request('model/list', {});
      final models = [
        for (final raw in listed['data'] as List? ?? const [])
          if (raw case {'id': final String id} when raw['hidden'] != true)
            KernelOption(
              id,
              raw['displayName'] as String? ?? id,
              Icons.bolt_rounded,
              raw['description'] as String? ?? '',
            ),
      ];
      if (models.isEmpty) return;
      model.options = models;
      emitInfoChanged();
    } on Object {
      // Its default model, unnamed.
    }
  }

  /// The conversation it goes on with, as the server kept it.
  Future<void> _readHistory() async {
    try {
      await _connect();
      final read = await _request('thread/read', {
        'threadId': _threadId,
        'includeTurns': true,
      });
      _replaying = true;
      for (final raw in (read['thread'] as Map?)?['turns'] as List? ?? []) {
        final turn = raw as Map;
        _turnIds.add(turn['id'] as String);
        for (final item in turn['items'] as List? ?? const []) {
          _replayItem((item as Map).cast<String, Object?>());
        }
      }
    } on Object catch (error) {
      emit(
        ItemUpserted(
          nextSeq,
          'history-error',
          NoticeItem(NoticeKind.error, 'Could not read this session: $error'),
        ),
      );
    } finally {
      _replaying = false;
      _loadingHistory = false;
      emitInfoChanged();
    }
  }

  void _replayItem(Map<String, Object?> item) {
    if (item['type'] != 'userMessage') return _itemCompleted(item);
    emit(
      ItemUpserted(
        nextSeq,
        item['id'] as String,
        UserMessageItem(
          text: [
            for (final input in item['content'] as List? ?? const [])
              if (input case {'type': 'text', 'text': final String text}) text,
          ].join('\n\n'),
        ),
      ),
    );
  }

  Future<void> _start(KernelTurn turn) async {
    try {
      await _connect();
      final (approval, sandbox, sandboxPolicy) = _policy;
      if (!_threadLoaded) {
        final thread = {
          'model': ?model.selected,
          'cwd': ?_context.cwd,
          'approvalPolicy': approval,
          'sandbox': sandbox,
        };
        final started = _threadId == null
            ? await _request('thread/start', thread)
            : await _request('thread/resume', {
                'threadId': _threadId,
                ...thread,
                'excludeTurns': true,
              });
        _threadLoaded = true;
        if (_threadId == null) {
          _threadId = (started['thread'] as Map)['id'] as String;
          emitInfoChanged();
        }
      }
      final started = await _request('turn/start', {
        'threadId': _threadId,
        'input': [
          {'type': 'text', 'text': turn.text},
          for (final note in turn.notes) {'type': 'text', 'text': note},
        ],
        'model': ?model.selected,
        'approvalPolicy': approval,
        'sandboxPolicy': sandboxPolicy,
      });
      final id = (started['turn'] as Map)['id'] as String;
      _turnIds.add(id);
      _serverTurn ??= id;
      // Stopped before the server knew the turn: stop it there too.
      if (_turn != turn.id) _interrupt();
    } on Object catch (error) {
      if (_turn != turn.id) return;
      emit(
        ItemUpserted(
          nextSeq,
          'error:${turn.id}',
          NoticeItem(NoticeKind.error, '$error'),
        ),
      );
      _endTurn(turn.id, interrupted: true);
    }
  }

  void _interrupt() {
    final serverTurn = _serverTurn;
    if (serverTurn == null || _threadId == null) return;
    unawaited(
      _request('turn/interrupt', {'threadId': _threadId, 'turnId': serverTurn}),
    );
  }

  @override
  void answer(String requestId, InteractionAnswer answer) {
    if (!_approvals.containsKey(requestId)) return;
    final rpcId = _approvals.remove(requestId);
    emit(InteractionResolved(nextSeq, requestId));
    final decision = switch (answer) {
      ApprovalAnswer(decision: ApprovalDecision.allowOnce) => 'accept',
      ApprovalAnswer(decision: ApprovalDecision.allowAlways) =>
        'acceptForSession',
      _ => 'decline',
    };
    _transport.write({
      'id': rpcId,
      'result': {'decision': decision},
    });
  }

  @override
  void cancel() {
    final turn = _turn;
    if (turn == null) return;
    _interrupt();
    _endTurn(turn, interrupted: true);
  }

  @override
  Future<bool> rewind({
    required String itemId,
    required int index,
    required int turns,
    String? lastSeen,
  }) async {
    if (turns > 0 && _threadId != null) {
      // The conversation is the server's: gone there first, from the turn
      // of that message on.
      if (turns > _turnIds.length) return false;
      final from = _turnIds.length - turns;
      try {
        await _connect();
        await _request('thread/revert', {
          'threadId': _threadId,
          'beforeTurnId': _turnIds[from],
        });
      } on Object {
        return false;
      }
      _turnIds.removeRange(from, _turnIds.length);
    }
    emit(Rewound(nextSeq, itemId: itemId, index: index));
    return true;
  }

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    _transport.close();
    closeEvents();
  }

  // --- Translation ------------------------------------------------------------

  void _receive(Map<String, Object?> message) {
    final method = message['method'] as String?;
    final params = (message['params'] as Map?)?.cast<String, Object?>();
    if (method == null) {
      final response = _responses.remove(message['id']);
      if (message['error'] case final Map error) {
        response?.completeError(_RpcError('${error['message']}'));
        return;
      }
      final result = (message['result'] as Map?)?.cast<String, Object?>();
      response?.complete(result ?? const {});
      return;
    }
    if (message.containsKey('id')) {
      _serverRequest(message['id'], method, params ?? const {});
      return;
    }
    switch (method) {
      case codexExited:
        _exited('${params!['message']}', params['detail'] as String?);
      case 'thread/name/updated':
        if (params!['threadName'] case final String name) {
          emit(SessionRenamed(nextSeq, name));
        }
      case 'turn/started':
        _serverTurn = (params!['turn'] as Map)['id'] as String;
      case 'turn/completed':
        final turn = params!['turn'] as Map;
        if (turn['id'] != _serverTurn) return;
        _serverTurn = null;
        if (_turn case final ours?) {
          _endTurn(ours, interrupted: turn['status'] == 'interrupted');
        }
      case 'item/started':
        _itemStarted((params!['item'] as Map).cast<String, Object?>());
      case 'item/completed':
        _itemCompleted((params!['item'] as Map).cast<String, Object?>());
      case 'item/reasoning/summaryTextDelta':
        final id = params!['itemId'] as String;
        final buffer = _reasoning[id];
        if (buffer == null) return;
        // Each part of the summary (its own bold title and text) apart from
        // the one before.
        final part = params['summaryIndex'] as int?;
        final separate =
            part != null && buffer.isNotEmpty && part != _reasoningPart[id];
        if (part != null) _reasoningPart[id] = part;
        final delta = '${separate ? '\n\n' : ''}${params['delta'] as String}';
        final offset = buffer.length;
        buffer.write(delta);
        emit(TextDelta(nextSeq, id, offset, delta, tokens: buffer.length));
      case 'item/agentMessage/delta':
        final id = params!['itemId'] as String;
        final offset = _textLength[id];
        if (offset == null) return;
        final delta = params['delta'] as String;
        _textLength[id] = offset + delta.length;
        emit(TextDelta(nextSeq, id, offset, delta));
      case 'thread/tokenUsage/updated':
        final usage = params!['tokenUsage'] as Map;
        emit(
          UsageReported(
            nextSeq,
            ContextUsage(
              window: usage['modelContextWindow'] as int? ?? contextWindow,
              // The last request's, which is what the context holds; the
              // total adds up every request, and never drops on compacting.
              used: (usage['last'] as Map)['totalTokens'] as int,
            ),
          ),
        );
    }
  }

  void _serverRequest(
    Object? rpcId,
    String method,
    Map<String, Object?> params,
  ) {
    final (title, preview) = switch (method) {
      'item/commandExecution/requestApproval' => (
        'Run command',
        CommandPreview('${params['command']}') as ApprovalPreview?,
      ),
      'item/fileChange/requestApproval' => ('Apply changes', null),
      _ => (null, null),
    };
    if (title == null) {
      // Not one it answers: said so, for the server not to wait on it.
      _transport.write({
        'id': rpcId,
        'error': {'code': -32601, 'message': 'Not supported: $method'},
      });
      return;
    }
    final id = 'approval:$rpcId';
    _approvals[id] = rpcId;
    emit(
      InteractionRequested(
        nextSeq,
        ApprovalRequest(
          id: id,
          title: title,
          toolName: method.split('/')[1],
          reason: params['reason'] as String?,
          preview: preview,
          alwaysAllowLabel: 'Approve for this session',
        ),
      ),
    );
  }

  /// The server ended: what waited on it fails, a turn under way ends, and
  /// the next message starts it again, going on with the thread.
  void _exited(String message, String? detail) {
    _connected = null;
    _threadLoaded = false;
    _serverTurn = null;
    for (final response in _responses.values) {
      response.completeError(_RpcError(message));
    }
    _responses.clear();
    if (_turn case final turn?) {
      emit(
        ItemUpserted(
          nextSeq,
          'error:$turn',
          NoticeItem(
            NoticeKind.error,
            [
              message,
              if (detail case final detail? when detail.isNotEmpty) detail,
            ].join('\n\n'),
          ),
        ),
      );
      _endTurn(turn, interrupted: true);
    }
  }

  void _itemStarted(Map<String, Object?> item) {
    final id = item['id'] as String;
    switch (item['type']) {
      case 'reasoning':
        _reasoning[id] = StringBuffer();
        _reasoningClock[id] = Stopwatch()..start();
        emit(
          ItemUpserted(
            nextSeq,
            id,
            ThinkingItem(text: '', tokens: 0, startedAt: DateTime.now()),
            streaming: true,
          ),
        );
      case 'agentMessage':
        _textLength[id] = 0;
        emit(
          ItemUpserted(
            nextSeq,
            id,
            const AssistantTextItem(''),
            streaming: true,
          ),
        );
      case 'commandExecution':
        _startedAt[id] = DateTime.now();
        _commands[id] = item;
        emit(ItemUpserted(nextSeq, id, _commandItem(item)));
    }
  }

  void _itemCompleted(Map<String, Object?> item) {
    final id = item['id'] as String;
    switch (item['type']) {
      case 'reasoning':
        final buffer = _reasoning.remove(id);
        final clock = _reasoningClock.remove(id)?..stop();
        _reasoningPart.remove(id);
        final text =
            buffer?.toString() ??
            (item['summary'] as List<Object?>? ?? const []).join('\n\n');
        emit(
          ItemCompleted(
            nextSeq,
            id,
            item: ThinkingItem(
              text: text,
              tokens: text.length,
              seconds: math.max(
                1,
                ((clock?.elapsedMilliseconds ?? 0) / 1000).round(),
              ),
            ),
          ),
        );
      case 'agentMessage':
        _textLength.remove(id);
        emit(
          ItemCompleted(
            nextSeq,
            id,
            item: AssistantTextItem(item['text'] as String),
          ),
        );
      case 'commandExecution':
        emit(ItemUpserted(nextSeq, id, _commandItem(item)));
        _startedAt.remove(id);
        _commands.remove(id);
      case 'fileChange':
        final changes = item['changes'] as List<Object?>;
        for (final (index, raw) in changes.indexed) {
          final change = raw as Map;
          _fileChange(
            '$id:$index',
            change['path'] as String,
            change['diff'] as String,
            kind: (change['kind'] as Map?)?['type'] as String?,
          );
        }
    }
  }

  /// A command as the history shows it: reads and searches as tool rows,
  /// anything else as a terminal.
  ChatItem _commandItem(Map<String, Object?> item) {
    final actions = [
      for (final action in item['commandActions'] as List<Object?>? ?? const [])
        (action as Map).cast<String, Object?>(),
    ];
    final output = item['aggregatedOutput'] as String?;
    final done = item['status'] == 'completed' || item['status'] == 'failed';
    if (actions.isNotEmpty && actions.every((a) => a['type'] == 'read')) {
      final path = actions.first['path'] as String;
      return ToolCallItem(
        kind: ToolKind.read,
        target: path.split('/').last,
        path: path,
      );
    }
    if (actions.isNotEmpty && actions.every((a) => a['type'] == 'search')) {
      final matches = [
        for (final line in (output ?? '').split('\n'))
          if (line.isNotEmpty) line.split(':').take(2).join(':'),
      ];
      return ToolCallItem(
        kind: ToolKind.grep,
        target: actions.first['query'] as String? ?? '',
        detail: done ? '${matches.length} results' : null,
        results: matches,
      );
    }
    return TerminalItem(
      command: item['command'] as String,
      output: output ?? '',
      status: !done
          ? CommandStatus.running
          : item['exitCode'] == 0
          ? CommandStatus.succeeded
          : CommandStatus.failed,
      startedAt: _startedAt[item['id']],
    );
  }

  /// A unified diff as a diff card and a pending change. A file added or
  /// deleted ([kind]) has its whole text for a diff.
  void _fileChange(String id, String path, String diff, {String? kind}) {
    final lines = <DiffLine>[];
    var added = 0;
    var removed = 0;
    var oldLine = 1;
    var newLine = 1;
    final hunk = RegExp(r'^@@ -(\d+)(?:,\d+)? \+(\d+)(?:,\d+)? @@');
    for (final line in diff.split('\n')) {
      if (hunk.firstMatch(line) case final match?) {
        oldLine = int.parse(match.group(1)!);
        newLine = int.parse(match.group(2)!);
        continue;
      }
      if (line.isEmpty) continue;
      final text = line.substring(1);
      switch (line[0]) {
        case '+':
          lines.add(DiffLine(DiffLineType.added, newLine++, text));
          added++;
        case '-':
          lines.add(DiffLine(DiffLineType.removed, oldLine++, text));
          removed++;
        default:
          lines.add(DiffLine(DiffLineType.context, newLine++, text));
          oldLine++;
      }
    }
    final slash = path.lastIndexOf('/');
    emit(
      ItemUpserted(
        nextSeq,
        id,
        CodeDiffItem(
          fileName: path.substring(slash + 1),
          directory: slash < 0 ? '' : path.substring(0, slash),
          lines: lines,
        ),
      ),
    );
    if (_replaying) return;
    emit(
      FileEdited(
        nextSeq,
        FileChange(path: path, added: added, removed: removed),
        original: switch (kind) {
          'add' => const OriginalText(null),
          'delete' => OriginalText(diff),
          _ => OriginalByPatch(diff),
        },
      ),
    );
  }

  void _endTurn(String turn, {required bool interrupted}) {
    _turn = null;
    for (final id in [..._reasoning.keys]) {
      _itemCompleted({'type': 'reasoning', 'id': id});
    }
    for (final id in [..._textLength.keys]) {
      _textLength.remove(id);
      emit(ItemCompleted(nextSeq, id));
    }
    // A command stopped with its turn: it will not report its end.
    for (final item in [..._commands.values]) {
      _itemCompleted({...item, 'status': 'failed'});
    }
    for (final id in _approvals.keys) {
      emit(InteractionResolved(nextSeq, id));
    }
    _approvals.clear();
    emit(
      TurnEnded(
        nextSeq,
        turn,
        interrupted: interrupted,
        worked: switch (_turnStarted) {
          final started? => DateTime.now().difference(started),
          null => null,
        },
      ),
    );
  }
}

/// What the server answered a request with when it failed, or its ending.
class _RpcError implements Exception {
  const _RpcError(this.message);

  final String message;

  @override
  String toString() => message;
}
