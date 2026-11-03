import 'dart:async';

import 'package:flutter/foundation.dart' show visibleForTesting;

import '../agent_kernel.dart';
import 'codex_process_transport.dart';
import 'codex_transport.dart';

/// Codex's sessions on this machine (`~/.codex/sessions`), as its app
/// server lists them: the rollouts there are mostly zstd, which it reads
/// and the app does not.
class CodexCatalog implements SessionCatalog {
  const CodexCatalog();

  /// The most listed, newest first.
  static const _most = 500;

  @override
  Future<List<ProjectRecord>> projects() async =>
      projectsOf(await _threads(const {}));

  @override
  Future<List<SessionRecord>> sessionsIn(String cwd) async => [
    for (final thread in await _threads({'cwd': cwd})) ?sessionOf(thread),
  ];

  @override
  Future<void> delete(String id) =>
      _talk((request) => request('thread/delete', {'threadId': id}));

  Future<List<Map<String, Object?>>> _threads(Map<String, Object?> filter) =>
      _talk((request) async {
        final threads = <Map<String, Object?>>[];
        String? cursor;
        do {
          final page = await request('thread/list', {
            ...filter,
            'limit': 100,
            'sortKey': 'updated_at',
            'cursor': ?cursor,
            // What its state database has, no rollout read to repair it.
            'useStateDbOnly': true,
          });
          for (final thread in page['data'] as List? ?? const []) {
            threads.add((thread as Map).cast<String, Object?>());
          }
          cursor = page['nextCursor'] as String?;
        } while (cursor != null && threads.length < _most);
        return threads;
      });

  /// Runs [body] against a server of its own, ended after.
  static Future<T> _talk<T>(
    Future<T> Function(
      Future<Map<String, Object?>> Function(String, Map<String, Object?>),
    )
    body,
  ) async {
    final transport = CodexProcessTransport();
    final pending = <Object?, Completer<Map<String, Object?>>>{};
    var ids = 0;
    final subscription = transport.messages.listen((message) {
      if (message['method'] == codexExited) {
        for (final response in pending.values) {
          response.completeError(
            StateError('${(message['params'] as Map)['message']}'),
          );
        }
        pending.clear();
        return;
      }
      if (message['method'] != null) return;
      final response = pending.remove(message['id']);
      if (message['error'] case final Map error) {
        response?.completeError(StateError('${error['message']}'));
      } else {
        response?.complete(
          (message['result'] as Map?)?.cast<String, Object?>() ?? const {},
        );
      }
    });
    Future<Map<String, Object?>> request(
      String method,
      Map<String, Object?> params,
    ) {
      final response = pending[++ids] = Completer();
      transport.write({'id': ids, 'method': method, 'params': params});
      return response.future;
    }

    try {
      await request('initialize', {
        'clientInfo': {
          'name': 'baocode',
          'title': 'BaoCode',
          'version': '1.0.0',
        },
      });
      transport.write({'method': 'initialized'});
      return await body(request).timeout(const Duration(seconds: 30));
    } finally {
      await subscription.cancel();
      transport.close();
    }
  }

  /// [threads] (`thread/list`'s) by their folder, newest first.
  @visibleForTesting
  static List<ProjectRecord> projectsOf(List<Map<String, Object?>> threads) {
    final byCwd = <String, List<SessionRecord>>{};
    for (final thread in threads) {
      if (sessionOf(thread) case final session?) {
        (byCwd[session.cwd] ??= []).add(session);
      }
    }
    return [
      for (final MapEntry(:key, :value) in byCwd.entries)
        ProjectRecord(
          path: key,
          sessions: value..sort((a, b) => b.updatedAt.compareTo(a.updatedAt)),
        ),
    ]..sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
  }

  /// A thread as listed; none for a subagent's, or one kept nowhere.
  @visibleForTesting
  static SessionRecord? sessionOf(Map<String, Object?> thread) {
    if (thread
        case {
          'id': final String id,
          'cwd': final String cwd,
          'updatedAt': final int updatedAt,
        }
        when thread['parentThreadId'] == null && thread['ephemeral'] != true) {
      final name = thread['name'] as String?;
      return SessionRecord(
        id: id,
        title: name == null || name.isEmpty
            ? (thread['preview'] as String? ?? '')
            : name,
        updatedAt: DateTime.fromMillisecondsSinceEpoch(updatedAt * 1000),
        cwd: cwd,
        path: thread['path'] as String?,
      );
    }
    return null;
  }
}
