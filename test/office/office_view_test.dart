import 'package:baocode/l10n/l10n.dart';
import 'package:baocode/office/office_painter.dart';
import 'package:baocode/office/office_view.dart';
import 'package:baocode/theme/app_theme.dart';
import 'package:baocode/theme/codicons.dart';
import 'package:baocode/workspace/workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('a building clicked fills the view; Esc and "‹" go back up', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final opened = <AgentThread>[];
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(),
        localizationsDelegates: const [AppLocalizations.delegate],
        home: Scaffold(
          body: OfficeView(
            workspace: Workspace.mock(),
            onOpenAgent: opened.add,
            onClose: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    CampusPainter painter() =>
        tester
                .widget<CustomPaint>(
                  find.byWidgetPredicate(
                    (w) => w is CustomPaint && w.painter is CampusPainter,
                  ),
                )
                .painter!
            as CampusPainter;
    Offset onScreen(Offset at) =>
        tester.getTopLeft(
          find.byWidgetPredicate(
            (w) => w is CustomPaint && w.painter is CampusPainter,
          ),
        ) +
        at * painter().scale.toDouble();

    // The mock's projects are in no company: one building.
    expect(find.text('No company'), findsNothing);
    expect(painter().geometry.labeled, isFalse);
    await tester.tapAt(
      onScreen(painter().geometry.buildings.single.sign.center),
    );
    await tester.pumpAndSettle();
    expect(painter().geometry.labeled, isTrue);
    expect(find.text('No company'), findsOneWidget);
    expect(find.byIcon(Codicons.chevronLeft), findsOneWidget);

    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    expect(painter().geometry.labeled, isFalse);
    expect(find.byIcon(Codicons.chevronLeft), findsNothing);

    // Down to a room, then "‹" twice back to the campus.
    await tester.tapAt(
      onScreen(painter().geometry.buildings.single.sign.center),
    );
    await tester.pumpAndSettle();
    final room = painter().geometry.buildings.single.rooms.first;
    await tester.tapAt(onScreen(room.rect.topLeft + const Offset(2, 2)));
    await tester.pumpAndSettle();
    expect(find.text(room.room.project.name), findsWidgets);
    expect(painter().geometry.buildings.single.rooms, hasLength(1));
    await tester.tap(find.byIcon(Codicons.chevronLeft));
    await tester.pumpAndSettle();
    expect(
      painter().geometry.buildings.single.rooms.length,
      greaterThanOrEqualTo(1),
    );
    await tester.tap(find.byIcon(Codicons.chevronLeft));
    await tester.pumpAndSettle();
    expect(find.byIcon(Codicons.chevronLeft), findsNothing);
    expect(opened, isEmpty);
  });
}
