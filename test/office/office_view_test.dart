import 'package:baocode/l10n/l10n.dart';
import 'package:baocode/office/office_painter.dart';
import 'package:baocode/office/office_view.dart';
import 'package:baocode/theme/app_theme.dart';
import 'package:baocode/theme/codicons.dart';
import 'package:baocode/workspace/workspace.dart';
import 'package:flutter/gestures.dart';
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
    expect(find.text('Floor No company'), findsNothing);
    expect(painter().geometry.labeled, isFalse);
    // Anchored at the top left, not centered.
    expect(painter().geometry.buildings.single.rect.top, CampusGeometry.gap);
    await tester.tapAt(
      onScreen(painter().geometry.buildings.single.sign.center),
    );
    await tester.pumpAndSettle();
    expect(painter().geometry.labeled, isTrue);
    expect(find.text('Floor No company'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);

    // Nothing clicked since: Esc still goes up.
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    expect(painter().geometry.labeled, isFalse);
    expect(find.text('Back'), findsNothing);

    // A room clicked on the campus: straight into it.
    final first = painter().geometry.buildings.single.rooms.first;
    await tester.tapAt(onScreen(first.rect.topLeft + const Offset(2, 2)));
    await tester.pumpAndSettle();
    expect(painter().geometry.buildings.single.rooms, hasLength(1));
    expect(find.text('Room ${first.room.project.name}'), findsOneWidget);

    // "›" to the building's next room, Backspace up to the building.
    await tester.tap(find.byIcon(Codicons.chevronRight));
    await tester.pumpAndSettle();
    expect(find.text('Room ${first.room.project.name}'), findsNothing);
    await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
    await tester.pumpAndSettle();
    expect(painter().geometry.buildings.single.rooms.length, greaterThan(1));

    // The breadcrumb's first segment: back to the campus.
    await tester.tap(find.text('Office'));
    await tester.pumpAndSettle();
    expect(find.text('Back'), findsNothing);
    expect(opened, isEmpty);
  });

  testWidgets('the wheel zooms about the pointer, a click still finds its '
      'room; a double click on nothing fits it again', (tester) async {
    tester.view.physicalSize = const Size(400, 500);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(),
        localizationsDelegates: const [AppLocalizations.delegate],
        home: Scaffold(
          body: OfficeView(
            workspace: Workspace.mock(),
            onOpenAgent: (_) {},
            onClose: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final canvas = find.byWidgetPredicate(
      (w) => w is CustomPaint && w.painter is CampusPainter,
    );
    CampusPainter painter() =>
        tester.widget<CustomPaint>(canvas).painter! as CampusPainter;
    Offset onScreen(Offset at) =>
        tester.getTopLeft(canvas) + at * painter().scale.toDouble();

    final fit = painter().scale;
    final room = painter().geometry.buildings.single.rooms.first;
    final about = onScreen(room.rect.center);
    tester.binding.handlePointerEvent(
      PointerScrollEvent(position: about, scrollDelta: const Offset(0, -50)),
    );
    await tester.pumpAndSettle();
    expect(painter().scale, fit + 1);
    // Zoomed about the pointer: the room's middle still under it.
    final moved = onScreen(
      painter().geometry.buildings.single.rooms.first.rect.center,
    );
    expect((moved - about).distance, lessThan(painter().scale * 1.0));

    // A drag moves it; a click on the room still goes into it.
    await tester.dragFrom(about, const Offset(-40, -30));
    await tester.pumpAndSettle();
    final first = painter().geometry.buildings.single.rooms.first;
    expect(tester.getTopLeft(canvas).dx, lessThan(0));
    await tester.tapAt(onScreen(first.rect.topLeft + const Offset(40, 60)));
    await tester.pumpAndSettle();
    expect(find.text('Room ${first.room.project.name}'), findsOneWidget);

    // There, as it fits; zoomed, a double click on its floor puts it back.
    final room3 = painter().scale;
    final floor = onScreen(
      painter().geometry.buildings.single.rooms.single.rect.topLeft +
          const Offset(70, 40),
    );
    tester.binding.handlePointerEvent(
      PointerScrollEvent(position: floor, scrollDelta: const Offset(0, -50)),
    );
    await tester.pumpAndSettle();
    expect(painter().scale, room3 + 1);
    await tester.tapAt(floor);
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tapAt(floor);
    await tester.pumpAndSettle();
    expect(painter().scale, room3);
  });
}
