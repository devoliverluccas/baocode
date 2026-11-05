import 'package:baocode/board/board_data.dart';
import 'package:baocode/board/board_table_view.dart';
import 'package:baocode/l10n/l10n.dart';
import 'package:baocode/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'board_fixtures.dart';

void main() {
  test('sorts by status, needs you first, then the latest', () {
    final rows = sortBoardThreads(boardFixtures(), BoardTableSort.status);
    expect(rows.first.title, startsWith('Copy da landing'));
    expect(rows[1].title, 'Correções de segurança P1');
    expect(rows.last.column, BoardColumn.archived);
  });

  test('sorts by changes, the most first descending, none last', () {
    final rows = sortBoardThreads(
      boardFixtures(),
      BoardTableSort.diff,
      ascending: false,
    );
    expect(rows.first.title, 'Checkout Pix');
    expect(rows.last.diff, isNull);
  });

  testWidgets('a header click sorts by it, again reverses', (tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final threads = boardFixtures();
    final pinned = <BoardThread>[];
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(),
        locale: const Locale('pt'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: Scaffold(
          body: BoardTableView(
            data: BoardData(threads),
            actions: BoardActions(
              open: (_) {},
              setActive: (_, _) {},
              archive: (_, _) {},
              pin: (list, _) => pinned.addAll(list),
            ),
          ),
        ),
      ),
    );
    double y(String title) => tester.getTopLeft(find.text(title)).dy;
    // By default: needs you first.
    expect(y('Correções de segurança P1'), lessThan(y('Ideias soltas')));

    await tester.tap(find.text('Conversa'));
    await tester.pump();
    expect(y('Boot no ARM'), lessThan(y('Worker travando no Redis')));

    await tester.tap(find.text('Conversa'));
    await tester.pump();
    expect(y('Worker travando no Redis'), lessThan(y('Boot no ARM')));

    // Selected all, the bar pins them.
    await tester.tap(find.byTooltip('Selecionar todas'));
    await tester.pump();
    expect(find.text('15 selecionadas'), findsOneWidget);
    await tester.tap(find.text('Fixar'));
    expect(pinned, isNotEmpty);
    expect(pinned.any((t) => t.archived), isFalse);
  });
}
