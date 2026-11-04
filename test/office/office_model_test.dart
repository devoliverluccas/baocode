import 'package:baocode/chat/chat_models.dart';
import 'package:baocode/l10n/l10n.dart';
import 'package:baocode/office/office_characters.dart';
import 'package:baocode/office/office_model.dart';
import 'package:baocode/office/office_painter.dart';
import 'package:baocode/workspace/companies.dart';
import 'package:baocode/workspace/workspace.dart';

import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

void main() {
  const promov = Company('PROMOV', '/p', color: 0xff00ff00);
  const lutech = Company('LUTECH', '/l');
  const hidden = Company('Old', '/o', hidden: true);
  const site = Project('site', '/site');
  const api = Project('api', '/api');
  const crm = Project('crm', '/crm');
  const lone = Project('lone', '/lone');
  const legacy = Project('legacy', '/legacy');
  final of = {site: promov, api: promov, crm: lutech, legacy: hidden};

  OfficeThread thread(
    Project project,
    String title, {
    ThreadStatus status = ThreadStatus.running,
    bool active = false,
    ChatItem? current,
  }) => OfficeThread(
    project: project,
    title: title,
    status: status,
    active: active,
    current: current,
  );

  OfficeCampus campus(List<OfficeThread> threads) => buildCampus(
    companies: [lutech, hidden, promov],
    companyOf: (project) => of[project],
    projects: [site, api, crm, lone, legacy],
    threads: threads,
    noCompany: 'Sem empresa',
  );

  test('buildings in the companies\' order, hidden ones left out, '
      'those in none last', () {
    final buildings = campus([thread(site, 'a')]).buildings;
    expect(buildings.map((b) => b.name), ['LUTECH', 'PROMOV', 'Sem empresa']);
    expect(buildings[1].color, 0xff00ff00);
    expect(buildings.last.company, isNull);
    expect(buildings.last.dim, [lone]);
  });

  test('no building for no company when every project is in one', () {
    final buildings = buildCampus(
      companies: [promov],
      companyOf: (_) => promov,
      projects: [site],
      threads: const [],
      noCompany: 'Sem empresa',
    ).buildings;
    expect(buildings.map((b) => b.name), ['PROMOV']);
  });

  test('a room only for a project in the Ativas, the rest dim', () {
    final promovs = campus([
      thread(site, 'idle, not active', status: ThreadStatus.idle),
      thread(api, 'kept active', status: ThreadStatus.idle, active: true),
    ]).buildings[1];
    expect(promovs.rooms.map((r) => r.project), [api]);
    expect(promovs.dim, [site]);
  });

  test('4 characters a room, then +N; the waiting first, "❗" kept', () {
    final room = campus([
      for (var i = 0; i < 5; i++) thread(site, 'run $i'),
      thread(site, 'asks', status: ThreadStatus.needsInput),
    ]).buildings[1].rooms.single;
    expect(room.visible, hasLength(4));
    expect(room.overflow, 2);
    expect(room.visible.first.title, 'asks');
    expect(room.waiting, isTrue);
  });

  test('nothing in the Ativas: no one in, every project dim', () {
    final office = campus([thread(site, 'idle', status: ThreadStatus.idle)]);
    expect(office.agents, isEmpty);
    expect(office.buildings.expand((b) => b.rooms), isEmpty);
    expect(office.buildings.expand((b) => b.dim), [crm, site, api, lone]);
    expect((office.working, office.waiting, office.done), (0, 0, 0));
  });

  test("a hidden company's projects show nowhere, busy or not", () {
    final office = campus([
      thread(legacy, 'asks', status: ThreadStatus.needsInput),
    ]);
    expect(office.agents, isEmpty);
    expect(office.buildings.expand((b) => b.dim), isNot(contains(legacy)));
    expect(office.waiting, 0);
  });

  test('the reception counts', () {
    final office = campus([
      thread(site, 'a'),
      thread(crm, 'b'),
      thread(api, 'c', status: ThreadStatus.needsInput),
      thread(lone, 'd', status: ThreadStatus.unread),
    ]);
    expect((office.working, office.waiting, office.done), (2, 1, 1));
  });

  test('status and tool to activity', () {
    expect(
      activityOf(ThreadStatus.needsInput, ToolKind.edit),
      OfficeActivity.waving,
    );
    expect(
      activityOf(ThreadStatus.running, ToolKind.read),
      OfficeActivity.reading,
    );
    expect(
      activityOf(ThreadStatus.running, ToolKind.grep),
      OfficeActivity.reading,
    );
    expect(
      activityOf(ThreadStatus.running, ToolKind.edit),
      OfficeActivity.typing,
    );
    expect(
      activityOf(ThreadStatus.running, ToolKind.command),
      OfficeActivity.server,
    );
    expect(
      activityOf(ThreadStatus.running, ToolKind.web),
      OfficeActivity.window,
    );
    expect(
      activityOf(ThreadStatus.running, ToolKind.agent),
      OfficeActivity.intern,
    );
    expect(activityOf(ThreadStatus.running, null), OfficeActivity.typing);
    expect(activityOf(ThreadStatus.unread, null), OfficeActivity.done);
    expect(activityOf(ThreadStatus.idle, null), OfficeActivity.coffee);
  });

  test('a bubble says what the turn runs, short', () {
    final l10n = englishLocalizations;
    String? say(ThreadStatus status, [ChatItem? current]) =>
        activityText(status, current, l10n);
    ToolCallItem call(ToolKind kind, String target, {String? label}) =>
        ToolCallItem(
          kind: kind,
          target: target,
          label: label,
          status: ToolStatus.running,
        );
    expect(say(ThreadStatus.idle), isNull);
    expect(say(ThreadStatus.needsInput), l10n.officeNeedsYou);
    expect(say(ThreadStatus.unread), l10n.officeDoneOpen);
    expect(say(ThreadStatus.running), l10n.officeThinking);
    expect(
      say(ThreadStatus.running, call(ToolKind.read, 'lib/workspace.dart')),
      '${l10n.toolReading.toLowerCase()} workspace.dart',
    );
    expect(
      say(ThreadStatus.running, call(ToolKind.other, 'x', label: 'Workflow')),
      l10n.officeWorkflow('x'),
    );
    expect(
      say(
        ThreadStatus.running,
        const AgentItem(id: 'a', description: 'review'),
      ),
      l10n.officeDelegating('review'),
    );
    final long = say(ThreadStatus.running, call(ToolKind.command, 'x' * 60))!;
    expect(long, hasLength(28));
    expect(long, endsWith('…'));
  });

  test('a look and a desk of its own, the same for the same one', () {
    final a = OfficeAgent(thread(site, 'a'));
    expect(OfficeAgent(thread(api, 'a')).hash, a.hash);
    final looks = {
      for (var i = 0; i < 40; i++)
        (
          OfficeAgent(thread(site, 'agent $i')).sprite,
          OfficeAgent(thread(site, 'agent $i')).hue,
        ),
    };
    expect(looks.length, greaterThan(20));
  });

  test('the campus paints, its characters where taps find them', () {
    final office = campus([
      for (var i = 0; i < 6; i++) thread(site, 'run $i'),
      thread(crm, 'asks', status: ThreadStatus.needsInput),
    ]);
    final geometry = CampusGeometry.of(office);
    final (agent, at) = geometry.buildings[0].rooms.single.agents.single;
    expect(agent.title, 'asks');
    expect(geometry.agentAt(at.center), same(agent));
    // Columns from the top left: every building's top on the same line.
    expect(
      {for (final b in geometry.buildings) b.rect.top},
      {CampusGeometry.gap},
    );
    expect(geometry.buildings.first.rect.left, CampusGeometry.gap);
    const grey = Color(0xff808080);
    final recorder = PictureRecorder();
    CampusPainter(
      geometry: geometry,
      scale: 2,
      colors: (
        text: grey,
        muted: grey,
        border: grey,
        room: grey,
        building: grey,
        waiting: grey,
        sky: grey,
        ground: grey,
        lit: grey,
      ),
      pixelRatio: 1.25,
    ).paint(Canvas(recorder), geometry.size * 2 / 1.25);
    recorder.endRecording().dispose();
  });

  test('level 3: who the scene has no desk for, in rows under it', () {
    final office = campus([for (var i = 0; i < 6; i++) thread(site, 'r$i')]);
    final building = office.buildings.firstWhere((b) => b.name == 'PROMOV');
    final room = building.rooms.single;
    final geometry = CampusGeometry.room(building, room);
    final box = geometry.buildings.single.rooms.single;
    expect(box.agents, hasLength(6));
    expect(box.beyond.map((a) => a.$1.title), ['r4', 'r5']);
    final under = box.beyond.first.$2;
    expect(under.top, greaterThan(box.rect.top + CampusGeometry.roomHeight));
    expect(box.rect.contains(under.center), isTrue);
    final scenes = OfficeScenes()..sync(office, still: true);
    expect(scenes.find(geometry, under.center)?.$1.title, 'r4');
  });
}
