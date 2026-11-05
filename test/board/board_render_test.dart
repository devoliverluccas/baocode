// Pumps the board's three views with sample data, writing each to a PNG
// to look at when BOARD_RENDER is set:
//
//     BOARD_RENDER=<dir> flutter test test/board/board_render_test.dart
//
// BOARD_RENDER_PREFIX, if set, in place of `board` in their names.
// Text in Segoe UI, from Windows' fonts, then.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:baocode/board/board_data.dart';
import 'package:baocode/board/board_page.dart';
import 'package:baocode/l10n/l10n.dart';
import 'package:baocode/theme/app_theme.dart';
import 'package:baocode/workspace/workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'board_fixtures.dart';

void main() {
  final out = Platform.environment['BOARD_RENDER'];
  // The files' names start so: board_kanban.png.
  final prefix = Platform.environment['BOARD_RENDER_PREFIX'] ?? 'board';

  testWidgets('renders each view', (tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    if (out != null) {
      await tester.runAsync(() async {
        final font = File(r'C:\Windows\Fonts\segoeui.ttf').readAsBytesSync();
        final bold = File(r'C:\Windows\Fonts\segoeuib.ttf').readAsBytesSync();
        for (final family in ['FlutterTest', 'Roboto', 'Segoe UI']) {
          await (FontLoader(family)
                ..addFont(Future.value(ByteData.sublistView(font)))
                ..addFont(Future.value(ByteData.sublistView(bold))))
              .load();
        }
        // The icons: Material's, from the SDK, and the codicons.
        // flutter_tester is in bin/cache/artifacts/engine/<platform>.
        final artifacts = File(Platform.resolvedExecutable)
            .parent
            .parent
            .parent;
        for (final (family, path) in [
          (
            'MaterialIcons',
            '${artifacts.path}/material_fonts/materialicons-regular.otf',
          ),
          ('codicon', 'assets/codicons/codicon.ttf'),
        ]) {
          await (FontLoader(family)..addFont(
                Future.value(
                  ByteData.sublistView(File(path).readAsBytesSync()),
                ),
              ))
              .load();
        }
      });
    }
    final workspace = Workspace.mock();
    final threads = boardFixtures();
    final boundary = GlobalKey();
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(),
        locale: const Locale('pt'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: RepaintBoundary(
          key: boundary,
          child: Scaffold(
            backgroundColor: AppColors.background,
            body: BoardPage(
              workspace: workspace,
              threads: threads,
              onOpenAgent: (_) {},
              onClose: () {},
              island: AppColors.conversationSurface,
            ),
          ),
        ),
      ),
    );
    for (final view in BoardView.values) {
      workspace.boardView = view.name;
      // The loaders run on: no settling.
      await tester.pump(const Duration(milliseconds: 300));
      expect(tester.takeException(), isNull);
      expect(find.text('Quadro'), findsWidgets);
      if (out == null) continue;
      await tester.runAsync(() async {
        final render =
            boundary.currentContext!.findRenderObject()!
                as RenderRepaintBoundary;
        final image = await render.toImage();
        final png = await image.toByteData(format: ui.ImageByteFormat.png);
        File('$out/${prefix}_${view.name}.png')
            .writeAsBytesSync(png!.buffer.asUint8List());
      });
    }
  });
}
