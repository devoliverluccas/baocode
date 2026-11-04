import 'dart:typed_data';

import 'package:baocode/chat/chat_models.dart';
import 'package:baocode/office/office_characters.dart';
import 'package:baocode/office/office_layout.dart';
import 'package:baocode/office/office_model.dart';
import 'package:baocode/office/office_sprites.dart';
import 'package:baocode/workspace/workspace.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final layout = OfficeLayout.room;
  const site = Project('site', '/site');

  OfficeAgent agent(
    String title, {
    ThreadStatus status = ThreadStatus.running,
    ToolKind? tool,
    List<TeamMember> team = const [],
  }) => OfficeAgent(
    OfficeThread(
      project: site,
      title: title,
      status: status,
      current: tool == null
          ? null
          : tool == ToolKind.agent
          ? const AgentItem(description: 'sub')
          : ToolCallItem(kind: tool, target: 'x', status: ToolStatus.running),
      team: team,
    ),
  );

  /// [seconds] of the scene going on, in frames of a 30th.
  void run(RoomScene scene, [double seconds = 10]) {
    for (var i = 0; i < seconds * 30; i++) {
      scene.update(1 / 30);
    }
  }

  test('paths go by floor, a tile at a time, the shortest way', () {
    final path = layout.findPath(layout.door, (col: 0, row: 4));
    var at = layout.door;
    for (final step in path) {
      expect((step.col - at.col).abs() + (step.row - at.row).abs(), 1);
      expect(layout.isWalkable(step), isTrue);
      at = step;
    }
    expect(at, (col: 0, row: 4));
    // Down to the walkway, across it, down the aisle, along the chairs.
    expect(path, hasLength(1 + 4 + 3 + 3));
    expect(layout.findPath(layout.door, (col: 1, row: 2)), isEmpty);
    expect(layout.findPath(layout.door, layout.door), isEmpty);
  });

  test('the same desk for the same one, the next free if taken', () {
    expect(layout.deskFor(5, {}), layout.desks[1]);
    expect(layout.deskFor(5, {layout.desks[1].tile}), layout.desks[2]);
    expect(layout.deskFor(0, {for (final d in layout.desks) d.tile}), isNull);
  });

  test('in by the door, sat at its PC whatever it does, out', () {
    final scene = RoomScene();
    scene.sync([agent('a')]);
    final character = scene.characters.single;
    expect(character.tile, layout.door);
    expect(character.walking, isTrue);

    run(scene);
    expect(character.walking, isFalse);
    expect(character.sitting, isTrue);
    expect(character.tile, character.desk!.tile);
    expect(character.facing, OfficeFacing.up);
    expect(character.frame, inInclusiveRange(3, 4));

    scene.sync([agent('a', status: ThreadStatus.needsInput)]);
    run(scene);
    expect(character.sitting, isFalse);
    expect(character.tile, character.desk!.tile);
    expect(character.facing, OfficeFacing.down);

    for (final tool in [ToolKind.grep, ToolKind.command, ToolKind.web]) {
      scene.sync([agent('a', tool: tool)]);
      run(scene);
      expect(character.tile, character.desk!.tile);
      expect(character.sitting, isTrue);
      expect(character.facing, OfficeFacing.up);
    }
    scene.sync([agent('a', tool: ToolKind.grep)]);
    expect(character.frame, inInclusiveRange(5, 6));

    for (final status in [ThreadStatus.idle, ThreadStatus.unread]) {
      scene.sync([agent('a', status: status)]);
      run(scene);
      expect(character.tile, character.desk!.tile);
      expect(character.sitting, isTrue);
    }
    expect(character.status, ThreadStatus.unread);

    scene.sync([]);
    expect(character.leaving, isTrue);
    run(scene);
    expect(scene.characters, isEmpty);
  });

  test('a team sat at the desks nearest its lead, then +N; a ✓ a while '
      'when done, then out', () {
    TeamMember member(String id) => TeamMember(id: id, label: id);
    final scene = RoomScene();
    final team = [for (final id in 'pqrs'.split('')) member(id)];
    scene.sync([agent('a', tool: ToolKind.agent, team: team), agent('b')]);
    run(scene);
    final [lead, ...members] = scene.characters
        .where((c) => c.agent.title == 'a')
        .toList();
    expect(lead.sitting, isTrue);
    expect(members.map((c) => c.member!.id), ['p', 'q', 'r']);
    expect(members.map((c) => c.isMember), everyElement(isTrue));
    expect(lead.teamOverflow, 1);
    // Two desks free in the front row: sat at them, the third behind.
    final tiles = {for (final c in scene.characters) c.tile};
    expect(tiles, hasLength(5));
    expect(members.map((c) => c.sitting), everyElement(isTrue));
    expect(layout.teamDesks.map((s) => s.tile), contains(members.last.tile));

    scene.sync([
      agent('a', tool: ToolKind.agent, team: [team[1]]),
      agent('b'),
    ]);
    // Done: sat on, its ✓ over it, then up and out.
    expect(members[0].done, greaterThan(0));
    expect(members[0].leaving, isFalse);
    run(scene, 1);
    expect(members[0].sitting, isTrue);
    run(scene, 1);
    expect(members[0].leaving, isTrue);
    expect(members[1].done, 0);
    run(scene);
    expect(scene.characters.where((c) => c.isMember).single, members[1]);
    expect(lead.teamOverflow, 0);

    scene.sync([agent('b')]);
    run(scene);
    expect(scene.characters.map((c) => c.agent.title), ['b']);
  });

  test('comes in, and goes, by the matrix effect at the door', () {
    final scene = RoomScene();
    scene.sync([agent('a')]);
    final character = scene.characters.single;
    run(scene, 0.2);
    expect(character.appear, inExclusiveRange(0, 1));
    expect(character.tile, layout.door);
    run(scene);
    expect(character.appear, 1);
    expect(character.sitting, isTrue);

    scene.sync([]);
    for (var i = 0; i < 300 && character.vanish == 0; i++) {
      scene.update(1 / 30);
    }
    expect(character.tile, layout.door);
    expect(character.vanish, inExclusiveRange(0, 1));
    expect(scene.characters, contains(character));
    run(scene);
    expect(scene.characters, isEmpty);
  });

  test("a kernel's shirt: the chest turned, the skin kept", () {
    expect(OfficeKernel.of('claude-code'), OfficeKernel.claude);
    expect(OfficeKernel.of('codex'), OfficeKernel.codex);
    expect(OfficeKernel.of(null), OfficeKernel.other);
    const width = 112;
    final rgba = Uint8List(width * 96 * 4);
    void put(int x, int y, List<int> color) =>
        rgba.setAll((y * width + x) * 4, [...color, 255]);
    const skin = [0xe9, 0xa3, 0x84], blue = [0x11, 0x49, 0x78];
    put(16 + 5, 15, skin);
    put(16 + 5, 20, blue);
    put(16 + 6, 20, skin);
    OfficeSprites.shirt(rgba, width, OfficeKernel.claude);
    List<int> at(int x, int y) =>
        rgba.sublist((y * width + x) * 4, (y * width + x) * 4 + 3);
    expect(at(21, 20)[0], greaterThan(at(21, 20)[2]));
    expect(at(22, 20), skin);
  });

  test('each to its own desk; motion turned down, there at once', () {
    final scene = RoomScene();
    scene.sync([agent('a'), agent('b'), agent('c')], still: true);
    final characters = scene.characters;
    expect(characters.map((c) => c.walking), everyElement(isFalse));
    expect(characters.map((c) => c.tile).toSet(), hasLength(3));
    expect(characters.map((c) => c.tile), everyElement(isIn(_desks(layout))));

    scene.sync([agent('a')], still: true);
    expect(scene.characters, hasLength(1));
  });
}

Iterable<Tile> _desks(OfficeLayout layout) => layout.desks.map((s) => s.tile);
