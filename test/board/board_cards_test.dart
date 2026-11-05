import 'package:baocode/board/board_cards_view.dart';
import 'package:baocode/board/board_data.dart';
import 'package:baocode/l10n/l10n.dart';
import 'package:baocode/theme/app_theme.dart';
import 'package:baocode/workspace/workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'board_fixtures.dart';

void main() {
  test('projects waiting on the user go first, newest first', () {
    final projects = projectsOf(boardFixtures());
    final waiting = [
      for (final (p, ts) in projects)
        if (ts.any((t) => t.column == BoardColumn.needsYou)) p.name,
    ];
    expect(projects.take(waiting.length).map((p) => p.$1.name), waiting);
    for (final (_, ts) in projects) {
      for (var i = 1; i < ts.length; i++) {
        expect(ts[i - 1].updatedAt.isAfter(ts[i].updatedAt), isTrue);
      }
    }
  });

  testWidgets('a card per project; its heading shows all; rows open', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final opened = <String>[];
    final created = <Project>[];
    final threads = boardFixtures();
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(),
        locale: const Locale('pt'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: Scaffold(
          body: BoardCardsView(
            data: BoardData(
              filterThreads(threads),
              companies: [lunar, promov, stark],
            ),
            actions: BoardActions(
              open: (t) => opened.add(t.title),
              setActive: (_, _) {},
              archive: (_, _) {},
              pin: (_, _) {},
              create: created.add,
            ),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 300));
    expect(tester.takeException(), isNull);
    expect(find.byType(ProjectCard), findsNWidgets(6));
    expect(find.text('Sem empresa'), findsOneWidget);

    // stark-os: 3 chats, one archived: hidden until shown.
    expect(find.text('Driver de rede antigo'), findsNothing);
    await tester.tap(find.text('stark-os'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Driver de rede antigo'), findsOneWidget);
    expect(find.text('Mostrar menos'), findsOneWidget);

    await tester.tap(find.text('Checkout Pix'));
    expect(opened, ['Checkout Pix']);

    await tester.tap(find.text('Novo chat').first);
    expect(created, hasLength(1));
  });
}
