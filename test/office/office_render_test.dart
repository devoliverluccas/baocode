// Paints the office's levels 1 and 3 with sample data to PNGs, to look at:
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
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final out = Platform.environment['OFFICE_RENDER'];

  testWidgets('renders levels 1 and 3', skip: out == null, (tester) async {
    await tester.runAsync(() async {
      final font = File(r'C:\Windows\Fonts\segoeui.ttf').readAsBytesSync();
      for (final family in ['FlutterTest', 'Roboto', 'Segoe UI']) {
        await (FontLoader(
          family,
        )..addFont(Future.value(ByteData.sublistView(font)))).load();
      }
      final sprites = await OfficeSprites.load();

      const promov = Company('PROMOV', '/p', color: 0xff34c759);
      const lutech = Company('LUTECH', '/l', color: 0xff0a84ff);
      const sentinela = Project('sentinela', '/p/sentinela');
      const dashboard = Project('dashboard', '/p/dashboard');
      const agentIa = Project('agent-ia', '/l/agent-ia');
      const loose = Project('notas', '/n');

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

      const editing = ToolCallItem(
        kind: ToolKind.edit,
        target: 'lib/sidebar.dart',
        status: ToolStatus.running,
      );
      const testing = ToolCallItem(
        kind: ToolKind.command,
        target: 'flutter test',
        status: ToolStatus.running,
      );
      const reading = ToolCallItem(
        kind: ToolKind.read,
        target: 'lib/workspace.dart',
        status: ToolStatus.running,
      );
      TeamMember member(String id, String label, [ToolCallItem? tool]) =>
          TeamMember(id: id, label: label, tool: tool);
      final t1 = member('t1', 'auditar repos');
      final t2 = member('t2', 'ler testes', reading);
      final t3 = member('t3', 'revisar PR');
      final u1 = member('u1', 'checar deploy');

      List<OfficeThread> threads(List<TeamMember> team, List<TeamMember> u) => [
        thread(
          sentinela,
          'auditoria',
          ThreadStatus.running,
          current: const AgentItem(description: 'auditar repos'),
          team: team,
        ),
        thread(
          sentinela,
          'deploy prod',
          ThreadStatus.needsInput,
          kernel: 'codex',
        ),
        thread(sentinela, 'corrigir login', ThreadStatus.unread, team: u),
        thread(
          sentinela,
          'refatorar sidebar',
          ThreadStatus.running,
          kernel: 'codex',
          current: editing,
        ),
        thread(dashboard, 'planejar', ThreadStatus.idle, kernel: 'codex'),
        thread(
          dashboard,
          'rodar testes',
          ThreadStatus.running,
          current: testing,
        ),
        thread(agentIa, 'webhook', ThreadStatus.running, kernel: 'other'),
        thread(loose, 'ideias', ThreadStatus.unread),
      ];
      OfficeCampus campus(List<TeamMember> team, List<TeamMember> u) =>
          buildCampus(
            companies: const [promov, lutech],
            companyOf: (p) => p.path.startsWith('/p')
                ? promov
                : p.path.startsWith('/l')
                ? lutech
                : null,
            projects: const [sentinela, dashboard, agentIa, loose],
            threads: threads(team, u),
            noCompany: 'Sem empresa',
          );

      final scenes = OfficeScenes();
      void run(OfficeCampus office, double seconds) {
        scenes.sync(office);
        for (var i = 0; i < seconds * 30; i++) {
          scenes.update(1 / 30);
        }
      }

      // All in and sat; then t1 done (a ✓, then out), t3 coming in, u1
      // done just now.
      run(campus([t1, t2], [u1]), 12);
      run(campus([t2, t3], [u1]), 1.9);
      run(campus([t2, t3], []), 0.3);
      final office = campus([t2, t3], []);
      scenes.sync(office);

      Future<void> paint(
        CampusGeometry geometry,
        int scale,
        String name,
      ) async {
        const sky = Color(0xff0b1830);
        final recorder = ui.PictureRecorder();
        final size = geometry.size * scale.toDouble();
        CampusPainter(
          geometry: geometry,
          scale: scale,
          sprites: sprites,
          scenes: scenes,
          colors: (
            text: const Color(0xffffffff),
            muted: const Color(0xff8e8e93),
            border: const Color(0xff3a3a3c),
            room: const Color(0xff2c2c2e),
            building: const Color(0xff1c1c1e),
            waiting: const Color(0xffffcc00),
            sky: sky,
            ground: const Color(0xff1f3a1c),
            lit: const Color(0xff4a4a3a),
          ),
        ).paint(ui.Canvas(recorder), size);
        final image = await recorder.endRecording().toImage(
          size.width.ceil(),
          size.height.ceil(),
        );
        final png = await image.toByteData(format: ui.ImageByteFormat.png);
        File('$out/$name').writeAsBytesSync(png!.buffer.asUint8List());
      }

      await paint(CampusGeometry.of(office), 4, 'office_v3_level1.png');
      final building = office.buildings.first;
      await paint(
        CampusGeometry.room(building, building.rooms.first),
        7,
        'office_v3_level3.png',
      );
      // The scene of the room painted: who is where.
      for (final c in scenes[sentinela]!.characters) {
        // ignore: avoid_print
        print(
          '${c.member?.id ?? c.agent.title} ${c.tile} sit=${c.sitting} '
          'walk=${c.walking} done=${c.done} leaving=${c.leaving}',
        );
      }
      // Every sheet in every kernel's shirt, front and back, its badge.
      final recorder = ui.PictureRecorder();
      final canvas = ui.Canvas(recorder)..scale(6);
      for (final (k, kernel) in OfficeKernel.values.indexed) {
        for (var i = 0; i < OfficeAgent.sprites; i++) {
          for (final (f, facing) in [
            OfficeFacing.down,
            OfficeFacing.up,
          ].indexed) {
            final at = Offset((i * 2 + f) * 20.0, k * 34.0);
            sprites.drawCharacter(
              canvas,
              i,
              at & const Size(16, 32),
              kernel: kernel,
              facing: facing,
              frame: 1,
            );
            OfficeSprites.drawKernel(canvas, kernel, at + const Offset(11, 3));
          }
        }
      }
      final image = await recorder.endRecording().toImage(1440, 612);
      final png = await image.toByteData(format: ui.ImageByteFormat.png);
      File('$out/office_v3_sheets.png')
          .writeAsBytesSync(png!.buffer.asUint8List());
    });
  });
}
