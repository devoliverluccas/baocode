import 'package:baocode/board/board_data.dart';
import 'package:baocode/board/board_kanban_view.dart';
import 'package:baocode/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'board_fixtures.dart';

void main() {
  /// The actions called, as `archive Frete grátis true`.
  late List<String> calls;

  Future<void> pump(WidgetTester tester) async {
    calls = [];
    String names(List<BoardThread> threads) =>
        threads.map((t) => t.title).join(',');
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('pt'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: Scaffold(
          body: BoardKanbanView(
            data: BoardData(
              filterThreads(boardFixtures()),
              companies: const [lunar, promov, stark],
            ),
            actions: BoardActions(
              open: (t) => calls.add('open ${t.title}'),
              setActive: (t, on) => calls.add('active ${names(t)} $on'),
              archive: (t, on) => calls.add('archive ${names(t)} $on'),
              pin: (t, on) => calls.add('pin ${names(t)} $on'),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  Finder column(BoardColumn c) =>
      find.byKey(ValueKey('board-column-${c.name}'));

  /// Drags [title]'s card over [to], then drops it unless [drop] is false.
  Future<TestGesture> drag(
    WidgetTester tester,
    String title,
    Finder to, {
    bool drop = true,
  }) async {
    final gesture = await tester.startGesture(
      tester.getCenter(find.text(title)),
    );
    await gesture.moveBy(const Offset(30, 0));
    await tester.pump();
    await gesture.moveTo(tester.getCenter(to));
    await tester.pump();
    if (drop) {
      await gesture.up();
      await tester.pump();
    }
    return gesture;
  }

  testWidgets('a card dropped on Arquivadas is archived', (tester) async {
    await pump(tester);
    await drag(tester, 'Frete grátis', column(BoardColumn.archived));
    expect(calls, ['archive Frete grátis true']);
  });

  testWidgets('dragged out of Arquivadas, it is unarchived and made active', (
    tester,
  ) async {
    await pump(tester);
    expect(find.text('Lista de compras'), findsNothing);
    await tester.tap(column(BoardColumn.archived));
    await tester.pump();
    await drag(tester, 'Lista de compras', column(BoardColumn.active));
    expect(calls, [
      'archive Lista de compras false',
      'active Lista de compras true',
    ]);
  });

  testWidgets('Trabalhando takes no card, and says so', (tester) async {
    await pump(tester);
    final gesture = await drag(
      tester,
      'Frete grátis',
      column(BoardColumn.working),
      drop: false,
    );
    expect(find.text('Não dá para soltar aqui'), findsOneWidget);
    await gesture.up();
    await tester.pump();
    expect(calls, isEmpty);
  });

  testWidgets('a click with no drag opens the chat', (tester) async {
    await pump(tester);
    await tester.tap(find.text('Checkout Pix'));
    await tester.pump();
    expect(calls, ['open Checkout Pix']);
  });

  testWidgets('lanes split the board by company, each folding', (tester) async {
    await pump(tester);
    await tester.tap(find.text('Faixas por empresa'));
    await tester.pump();
    for (final name in ['LUNAR', 'PROMOV', 'STARK', 'Sem empresa']) {
      expect(find.text(name), findsOneWidget);
    }
    expect(find.text('Ideias soltas'), findsOneWidget);
    await tester.tap(find.text('Sem empresa'));
    await tester.pump();
    expect(find.text('Ideias soltas'), findsNothing);
    await drag(
      tester,
      'Frete grátis',
      find.byKey(const ValueKey('board-lane-cell-LUNAR-archived')),
    );
    expect(calls, ['archive Frete grátis true']);
  });
}
