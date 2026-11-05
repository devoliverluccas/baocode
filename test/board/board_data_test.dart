import 'package:baocode/board/board_data.dart';
import 'package:baocode/workspace/workspace.dart';
import 'package:flutter_test/flutter_test.dart';

import 'board_fixtures.dart';

void main() {
  test('a conversation goes in its column', () {
    expect(columnOf(ThreadStatus.running), BoardColumn.working);
    expect(columnOf(ThreadStatus.needsInput), BoardColumn.needsYou);
    expect(columnOf(ThreadStatus.unread), BoardColumn.done);
    expect(columnOf(ThreadStatus.idle, active: true), BoardColumn.active);
    expect(columnOf(ThreadStatus.idle), BoardColumn.idle);
    expect(
      columnOf(ThreadStatus.running, active: true, archived: true),
      BoardColumn.archived,
    );
  });

  test('filtered by text and company, pinned first then latest', () {
    final all = boardFixtures();
    final sorted = filterThreads(all);
    expect(sorted.first.title, 'Demanda do Matheus no relatório');
    expect(sorted[1].title, 'Boot no ARM');
    expect(sorted[2].title, 'Material comercial');

    expect(filterThreads(all, query: 'CHECKOUT').map((t) => t.title), [
      'Checkout Pix',
    ]);
    // By project too.
    expect(filterThreads(all, query: 'stark-os'), hasLength(3));
    expect(filterThreads(all, companies: {'LUNAR'}), hasLength(4));
    expect(filterThreads(all, companies: {''}), hasLength(2));
    expect(filterThreads(all, companies: {'PROMOV', 'STARK'}), hasLength(9));
  });

  test('grouped by column, company and project', () {
    final all = boardFixtures();
    final data = BoardData(
      filterThreads(all),
      companies: companiesOf(all, [stark, lunar]),
    );
    expect(data.companies.map((c) => c.name), ['STARK', 'LUNAR', 'PROMOV']);
    expect(
      {
        for (final MapEntry(:key, :value) in data.byColumn.entries)
          key: value.length,
      },
      {
        BoardColumn.working: 3,
        BoardColumn.needsYou: 2,
        BoardColumn.done: 2,
        BoardColumn.active: 3,
        BoardColumn.idle: 3,
        BoardColumn.archived: 2,
      },
    );
    expect(data.byCompany.map((g) => g.$1?.name), [
      'STARK',
      'LUNAR',
      'PROMOV',
      null,
    ]);
    expect(data.byProject.first.$1.name, 'dashboard');
    expect(data.byProject, hasLength(6));
  });

  test('dropped on a column, made what it is', () {
    final calls = <String>[];
    final actions = BoardActions(
      open: (_) {},
      setActive: (t, v) => calls.add('active $v ${t.length}'),
      archive: (t, v) => calls.add('archive $v ${t.length}'),
      pin: (t, v) => calls.add('pin $v'),
    );
    final archived = boardFixtures().where((t) => t.archived).toList();
    actions.moveTo(archived, BoardColumn.active);
    actions.moveTo(archived, BoardColumn.archived);
    actions.moveTo(archived, BoardColumn.working);
    expect(calls, ['archive false 2', 'active true 2', 'archive true 2']);
    expect(BoardColumn.values.where((c) => c.droppable), [
      BoardColumn.active,
      BoardColumn.idle,
      BoardColumn.archived,
    ]);
  });
}
