import 'dart:async';
import 'dart:convert';

import 'package:baocode/chat/chat_models.dart';
import 'package:baocode/kernel/agent_kernel.dart';
import 'package:baocode/kernel/codex/codex_catalog.dart';
import 'package:baocode/kernel/codex/codex_kernel.dart';
import 'package:baocode/kernel/codex/codex_process_transport.dart';
import 'package:baocode/kernel/codex/codex_transport.dart';
import 'package:baocode/kernel/kernel_event.dart';
import 'package:baocode/kernel/kernel_types.dart';
import 'package:baocode/kernel/mock/mock_kernels.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('frames a message per line, whatever the chunks', () async {
    final bytes = utf8.encode(
      '{"id":1,"result":{"text":"olá"}}\n'
      'WARN not protocol\n'
      '\n'
      '[1,2]\n'
      '{"method":"turn/started","params":{}}\r\n',
    );
    // Split mid-line and mid-character (the "á").
    final split = bytes.indexOf(0xA1);
    final messages = await CodexProcessTransport.frame(
      Stream.fromIterable([
        bytes.sublist(0, 10),
        bytes.sublist(10, split),
        bytes.sublist(split),
      ]),
    ).toList();
    expect(messages, [
      {
        'id': 1,
        'result': {'text': 'olá'},
      },
      {'method': 'turn/started', 'params': <String, Object?>{}},
    ]);
  });

  test('lists threads by folder, newest first, subagents left out', () {
    Map<String, Object?> thread(
      String id,
      String cwd,
      int updatedAt, {
      String? name,
      String? parent,
    }) => {
      'id': id,
      'cwd': cwd,
      'updatedAt': updatedAt,
      'preview': 'first message of $id',
      'name': name,
      'parentThreadId': parent,
      'ephemeral': false,
      'path': 'C:\\Users\\u\\.codex\\sessions\\$id.jsonl.zst',
    };
    final projects = CodexCatalog.projectsOf([
      thread('a', r'C:\work\app', 100),
      thread('b', r'C:\work\lib', 300, name: 'Named'),
      thread('c', r'C:\work\app', 200),
      thread('d', r'C:\work\app', 400, parent: 'a'),
      {'id': 'broken'},
    ]);
    expect(projects.map((p) => p.path), [r'C:\work\lib', r'C:\work\app']);
    expect(projects.last.sessions.map((s) => s.id), ['c', 'a']);
    final named = projects.first.sessions.single;
    expect(named.title, 'Named');
    expect(projects.last.sessions.last.title, 'first message of a');
    expect(named.updatedAt, DateTime.fromMillisecondsSinceEpoch(300000));
  });

  test('starts in full access, and goes on with a kept thread', () async {
    final server = _Server();
    final kernel = CodexKernel(
      MockKernels.codex,
      server,
      context: KernelContext(
        cwd: r'C:\work\app',
        resume: SessionRecord(
          id: 'th',
          title: 'kept',
          updatedAt: DateTime(2026),
          cwd: r'C:\work\app',
        ),
      ),
    );
    final events = <KernelEvent>[];
    kernel.events.listen(events.add);
    expect(kernel.loadingHistory, isTrue);
    await pumpEventQueue();
    expect(kernel.loadingHistory, isFalse);
    expect(kernel.sessionId, 'th');
    final shown = [
      for (final event in events)
        if (event case ItemUpserted(:final item) || ItemCompleted(:final item?))
          item,
    ];
    expect((shown.first as UserMessageItem).text, 'hi');
    expect((shown.last as AssistantTextItem).text, 'hello');

    kernel.send(const KernelTurn(id: 't1', text: 'more'));
    await pumpEventQueue();
    final resume = server.sent('thread/resume');
    expect(resume['threadId'], 'th');
    expect(resume['approvalPolicy'], 'never');
    expect(resume['sandbox'], 'danger-full-access');
    expect(server.sent('turn/start')['sandboxPolicy'], {
      'type': 'dangerFullAccess',
    });

    // Back to before the first turn: the server is told which.
    expect(await kernel.rewind(itemId: 'u1', index: 0, turns: 2), isTrue);
    expect(server.sent('thread/revert')['beforeTurnId'], 'turn0');

    // The server gone: the turn ends, saying why.
    server.push({
      'method': codexExited,
      'params': {'message': 'Codex stopped', 'detail': 'boom'},
    });
    expect(events.whereType<TurnEnded>(), hasLength(1));
    kernel.dispose();
  });
}

class _Server implements CodexTransport {
  final StreamController<Map<String, Object?>> _out =
      StreamController.broadcast(sync: true);
  final List<Map<String, Object?>> written = [];

  Map<Object?, Object?> sent(String method) =>
      written.lastWhere((m) => m['method'] == method)['params'] as Map;

  @override
  Stream<Map<String, Object?>> get messages => _out.stream;

  void push(Map<String, Object?> message) => _out.add(message);

  @override
  void write(Map<String, Object?> message) {
    written.add(message);
    if (message['id'] == null || message['method'] == null) return;
    final result = switch (message['method']) {
      'thread/read' => {
        'thread': {
          'id': 'th',
          'turns': [
            {
              'id': 'turn0',
              'items': [
                {
                  'type': 'userMessage',
                  'id': 'u1',
                  'content': [
                    {'type': 'text', 'text': 'hi'},
                  ],
                },
                {'type': 'agentMessage', 'id': 'm1', 'text': 'hello'},
              ],
            },
          ],
        },
      },
      'turn/start' => {
        'turn': {'id': 'turn1'},
      },
      _ => <String, Object?>{},
    };
    push({'id': message['id'], 'result': result});
  }

  @override
  void close() => _out.close();
}
