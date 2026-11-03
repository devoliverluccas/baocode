import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bao_remote/local.dart' show AppPaths, ClaudeEnvironment;
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:path/path.dart' as p;

import '../../network/network_proxy_io.dart';
import 'codex_transport.dart';

/// What the agent this app may run under leaves in its environment (see
/// agent_terminal.dart's): Codex is not a child session of it.
final _childSession = RegExp(
  r'^(CLAUDECODE|AI_AGENT|CLAUDE_PID|CLAUDE_EFFORT|CLAUDE_CODE_\w+)$',
  caseSensitive: false,
);

/// `codex app-server` as a child process, over its stdin and stdout. It
/// starts on the first message written, and again on the next after it
/// ended ([codexExited] tells the kernel so).
class CodexProcessTransport implements CodexTransport {
  CodexProcessTransport({this.cwd});

  /// Where it runs: the project's folder, when it is there.
  final String? cwd;

  final StreamController<Map<String, Object?>> _messages =
      StreamController.broadcast();
  Future<Process?>? _process;
  bool _closed = false;

  /// The last lines it printed on stderr, to say why it ended.
  final List<String> _stderr = [];

  @override
  Stream<Map<String, Object?>> get messages => _messages.stream;

  /// The Codex CLI on this machine, as a terminal would find it: on the
  /// PATH, else where npm puts it; null when there is none.
  static String? locate([Map<String, String>? environment]) {
    final env = environment ?? Platform.environment;
    final home = AppPaths.home(env);
    final windows = Platform.isWindows;
    final dirs = [
      ...?env['PATH']?.split(windows ? ';' : ':'),
      if (windows) p.join(env['APPDATA'] ?? home, 'npm'),
      if (!windows) ...[
        '$home/.local/bin',
        '/opt/homebrew/bin',
        '/usr/local/bin',
      ],
    ];
    for (final dir in dirs) {
      if (dir.isEmpty) continue;
      for (final name in windows ? ['codex.exe', 'codex.cmd'] : ['codex']) {
        final path = p.join(dir, name);
        if (File(path).existsSync()) return path;
      }
    }
    return null;
  }

  /// Messages, one JSON object per line, out of what it prints: lines that
  /// are not one (a warning, a blank) are dropped; bytes that are not
  /// UTF-8 take the replacement character rather than end the stream.
  @visibleForTesting
  static Stream<Map<String, Object?>> frame(Stream<List<int>> bytes) => bytes
      .transform(const Utf8Decoder(allowMalformed: true))
      .transform(const LineSplitter())
      .expand((line) {
        if (line.trim().isEmpty) return const <Map<String, Object?>>[];
        try {
          final decoded = jsonDecode(line);
          return [if (decoded is Map<String, Object?>) decoded];
        } on FormatException {
          return const <Map<String, Object?>>[];
        }
      });

  Future<Process?> _start() async {
    final env = {
      ...Platform.environment,
      ...await ClaudeEnvironment.of(),
      // The proxy as it is now: Clash may have been turned on since.
      ...await NetworkProxy.instance.environment(),
    }..removeWhere((name, _) => _childSession.hasMatch(name));
    final executable = locate(env);
    try {
      if (executable == null) throw const ProcessException('codex', []);
      final process = await Process.start(
        executable,
        const ['app-server'],
        workingDirectory: switch (cwd) {
          final cwd? when Directory(cwd).existsSync() => cwd,
          _ => null,
        },
        environment: env,
        includeParentEnvironment: false,
        // An npm shim is a `.cmd`, which only the shell can run.
        runInShell: p.extension(executable).toLowerCase() == '.cmd',
      );
      frame(process.stdout).listen(_messages.add, onDone: () => _ended(null));
      process.stderr
          .transform(const Utf8Decoder(allowMalformed: true))
          .transform(const LineSplitter())
          .listen((line) {
            _stderr.add(line);
            if (_stderr.length > 30) _stderr.removeAt(0);
          });
      return process;
    } on ProcessException catch (error) {
      _ended(
        executable == null
            ? 'Codex is not installed (npm install -g @openai/codex)'
            : 'Codex could not start: ${error.message}',
      );
      return null;
    }
  }

  void _ended(String? why) {
    _process = null;
    if (_closed) return;
    _messages.add({
      'method': codexExited,
      'params': {
        'message': why ?? 'Codex stopped',
        'detail': _stderr.join('\n'),
      },
    });
  }

  @override
  void write(Map<String, Object?> message) {
    if (_closed) return;
    final line = jsonEncode(message);
    // In order: each waits on the same start.
    unawaited(
      (_process ??= _start()).then((process) {
        try {
          process?.stdin.writeln(line);
        } on StateError {
          // Closed under us: [codexExited] follows.
        }
      }),
    );
  }

  @override
  void close() {
    if (_closed) return;
    _closed = true;
    unawaited(
      _process?.then((process) async {
        if (process == null) return;
        unawaited(process.stdin.close().catchError((_) {}));
        // The npm shim is node, with Codex under it: all of it goes.
        if (Platform.isWindows) {
          try {
            await Process.run('taskkill', [
              '/pid',
              '${process.pid}',
              '/T',
              '/F',
            ]);
          } on ProcessException {
            process.kill();
          }
        } else {
          process.kill();
        }
      }),
    );
    unawaited(_messages.close());
  }
}
