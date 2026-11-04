// Paints the office's levels 1, 2 and 3 and the mini office with sample
// data to PNGs, to look at:
//
//     OFFICE_RENDER=<dir> flutter test test/office/office_render_test.dart
//
// Skipped without OFFICE_RENDER. Text in Segoe UI, from Windows' fonts.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:baocode/chat/chat_models.dart';
import 'package:baocode/office/office_characters.dart';
import 'package:baocode/office/office_model.dart';
import 'package:baocode/office/office_painter.dart';
import 'package:baocode/office/office_sprites.dart';
import 'package:baocode/workspace/companies.dart';
import 'package:baocode/workspace/workspace.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final out = Platform.environment['OFFICE_RENDER'];

  testWidgets('renders the levels and the mini office', skip: out == null, (
    tester,
  ) async {
    await tester.runAsync(() async {
      final font = File(r'C:\Windows\Fonts\segoeui.ttf').readAsBytesSync();
      final bold = File(r'C:\Windows\Fonts\segoeuib.ttf').readAsBytesSync();
      for (final family in ['FlutterTest', 'Roboto', 'Segoe UI']) {
        await (FontLoader(family)
              ..addFont(Future.value(ByteData.sublistView(font)))
              ..addFont(Future.value(ByteData.sublistView(bold))))
            .load();
      }
      final sprites = await OfficeSprites.load();

      // As in the user's companies.json.
      const lunar = Company('LUNAR', '/lu', color: 0xffba68c8, icon: 'moon');
      const promov = Company('PROMOV', '/p', color: 0xffffd54f, icon: 'work');
      const stark = Company('STARK', '/s', color: 0xfff06292, icon: 'rocket');
      const hub = Project('hub-lunar', '/lu/hub-lunar');
      const hermanitos = Project('Hermanitos', '/lu/hermanitos');
      const shopp = Project('RM Shopp (Ecommerce)', '/lu/rm-shopp');
      const lovely = Project('admin-lovely', '/lu/admin-lovely');
      const biquini = Project('RM Biquini (Ecommerce)', '/lu/rm-biquini');
      const dashboard = Project('dashboard', '/p/dashboard');
      const voice = Project('AI-Voice', '/p/ai-voice');
      const starkOs = Project('stark-os', '/s/stark-os');
      final idle = [
        const Project('lunar-site', '/lu/site'),
        const Project('lunar-crm', '/lu/crm'),
        const Project('promobot', '/p/promobot'),
        const Project('conectazap', '/p/conectazap'),
        const Project('agent-ia', '/p/agent-ia'),
        const Project('promov-central', '/p/promov-central'),
        const Project('sentinela', '/p/sentinela'),
        const Project('stark-api', '/s/api'),
        const Project('stark-app', '/s/app'),
        for (var i = 0; i < 12; i++) Project('notas-$i', '/n/$i'),
      ];

      OfficeThread thread(
        Project project,
        String title,
        ThreadStatus status, {
        String kernel = 'claude-code',
        ChatItem? current,
        List<TeamMember> team = const [],
      }) => OfficeThread(
        project: project,
        title: title,
        status: status,
        kernel: kernel,
        current: current,
        team: team,
        active: true,
      );

      ToolCallItem tool(ToolKind kind, String target) =>
          ToolCallItem(kind: kind, target: target, status: ToolStatus.running);
      TeamMember member(String id, String label, [ToolCallItem? t]) =>
          TeamMember(id: id, label: label, tool: t);

      final threads = [
        thread(
          hub,
          'Material comercial',
          ThreadStatus.running,
          current: tool(ToolKind.edit, 'lib/sidebar.dart'),
        ),
        thread(
          hub,
          'Copy da landing',
          ThreadStatus.needsInput,
          kernel: 'codex',
        ),
        thread(hermanitos, 'Cardápio novo', ThreadStatus.running),
        thread(shopp, 'Checkout Pix', ThreadStatus.unread),
        thread(
          lovely,
          'Migrar banco',
          ThreadStatus.running,
          kernel: 'codex',
          current: tool(ToolKind.command, 'npm run migrate'),
        ),
        thread(
          biquini,
          'Auditoria de SEO',
          ThreadStatus.running,
          current: const AgentItem(description: 'auditar páginas'),
          team: [
            member('t1', 'ler produtos', tool(ToolKind.read, 'products.ts')),
            member('t2', 'checar meta tags'),
          ],
        ),
        thread(
          biquini,
          'Fotos do catálogo',
          ThreadStatus.running,
          kernel: 'codex',
          current: tool(ToolKind.search, 'banner'),
        ),
        thread(biquini, 'Frete grátis', ThreadStatus.unread),
        thread(
          dashboard,
          'Demanda do Matheus no relatório',
          ThreadStatus.running,
          current: tool(ToolKind.read, 'lib/workspace.dart'),
        ),
        thread(
          dashboard,
          'Correções de segurança P1',
          ThreadStatus.needsInput,
          kernel: 'codex',
        ),
        thread(
          voice,
          'Estudo do Dograh para AI-Voice',
          ThreadStatus.running,
          current: const AgentItem(description: 'comparar provedores'),
          team: [member('v1', 'pesquisar preços'), member('v2', 'ler docs')],
        ),
        thread(
          starkOs,
          'Kernel scheduler',
          ThreadStatus.running,
          kernel: 'codex',
          current: tool(ToolKind.command, 'cargo test'),
        ),
      ];
      final office = buildCampus(
        companies: const [lunar, promov, stark],
        companyOf: (p) => p.path.startsWith('/lu')
            ? lunar
            : p.path.startsWith('/p')
            ? promov
            : p.path.startsWith('/s')
            ? stark
            : null,
        projects: [
          hub,
          hermanitos,
          shopp,
          lovely,
          biquini,
          dashboard,
          voice,
          starkOs,
          ...idle,
        ],
        threads: threads,
        noCompany: 'Sem empresa',
      );

      // All in and sat.
      final scenes = OfficeScenes()..sync(office);
      for (var i = 0; i < 12 * 30; i++) {
        scenes.update(1 / 30);
      }
      scenes.sync(office);

      // A window of the app's at 125 %, the sidebar hidden.
      const ratio = 1.25;
      const space = Size(1600, 860);
      Future<void> paint(
        CampusGeometry geometry,
        int scale,
        String name, {
        bool iconsOnly = false,
      }) async {
        final recorder = ui.PictureRecorder();
        final size = geometry.size * (scale / ratio);
        final canvas = ui.Canvas(recorder)..scale(ratio);
        CampusPainter(
          geometry: geometry,
          scale: scale,
          pixelRatio: ratio,
          sprites: sprites,
          scenes: scenes,
          iconsOnly: iconsOnly,
          font: const TextStyle(fontFamily: 'Segoe UI'),
          colors: (
            text: const Color(0xffffffff),
            muted: const Color(0xff8e8e93),
            border: const Color(0xff3a3a3c),
            room: const Color(0xff2c2c2e),
            building: const Color(0xff1c1c1e),
            waiting: const Color(0xffffcc00),
            sky: const Color(0xff0b1830),
            ground: const Color(0xff1f3a1c),
            lit: const Color(0xff4a4a3a),
          ),
        ).paint(canvas, size);
        final image = await recorder.endRecording().toImage(
          (size.width * ratio).ceil(),
          (size.height * ratio).ceil(),
        );
        final png = await image.toByteData(format: ui.ImageByteFormat.png);
        File('$out/$name').writeAsBytesSync(png!.buffer.asUint8List());
      }

      Future<void> fit<T>(
        CampusGeometry Function(T, double) make,
        List<T> options,
        int max,
        String name, {
        Size within = space,
        bool iconsOnly = false,
      }) async {
        final fit = fitGeometry(
          make,
          options,
          within,
          max: (max * ratio).floor(),
          pixelRatio: ratio,
        );
        await paint(fit.geometry, fit.scale, name, iconsOnly: iconsOnly);
      }

      await fit(
        ((int, int) o, _) =>
            CampusGeometry.of(office, columns: o.$1, perRow: o.$2),
        campusOptions(office.buildings.length),
        5,
        'office_themes_level1.png',
      );
      for (final (i, building) in office.buildings.take(2).indexed) {
        await fit(
          ((int, int) o, unit) => CampusGeometry.building(
            building,
            columns: o.$1,
            cardColumns: o.$2,
            unit: unit,
            counts: {for (final p in building.dim) p: p.name.length % 4},
          ),
          buildingColumns(building),
          8,
          i == 0 ? 'office_v4_level2_lunar.png' : 'office_v4_level2.png',
        );
      }
      final lunarBuilding = office.buildings.first;
      final room = lunarBuilding.rooms.firstWhere((r) => r.project == biquini);
      await fit(
        (_, _) => CampusGeometry.room(lunarBuilding, room),
        const [0],
        8,
        'office_v4_level3.png',
      );
      for (final (name, building) in [
        ('lunar', lunarBuilding),
        ('promov', office.buildings[1]),
        ('stark', office.buildings[2]),
      ]) {
        await fit(
          (_, _) => CampusGeometry.room(building, building.rooms.first),
          const [0],
          8,
          'office_themes_level3_$name.png',
        );
      }
      final hubRoom = lunarBuilding.rooms.firstWhere((r) => r.project == hub);
      await fit(
        (_, _) => CampusGeometry.room(lunarBuilding, hubRoom),
        const [0],
        3,
        'office_v4_mini.png',
        within: const Size(280, 240),
        iconsOnly: true,
      );
    });
  });
}
