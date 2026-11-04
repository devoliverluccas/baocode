import 'dart:math' as math;

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
      tool: tool,
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

  test('a free desk at a PC, none when all are taken', () {
    final taken = {for (final seat in layout.desks.skip(1)) seat.tile};
    expect(
      layout.freeSeat(taken, math.Random(1))?.tile,
      layout.desks.first.tile,
    );
    expect(layout.freeSeat({...taken, layout.desks.first.tile}), isNull);
  });

  test('in by the door, to the desk, about the room by status, out', () {
    final scene = RoomScene(random: math.Random(1));
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

    scene.sync([agent('a', tool: ToolKind.grep)]);
    run(scene);
    expect(layout.spots[OfficeActivity.reading]!.map((s) => s.tile), [
      character.tile,
      isNot(character.tile),
    ]);
    expect(character.frame, inInclusiveRange(5, 6));

    scene.sync([agent('a', status: ThreadStatus.idle)]);
    run(scene);
    expect(layout.sofa.map((s) => s.tile), contains(character.tile));
    expect(character.sitting, isTrue);

    scene.sync([]);
    expect(character.leaving, isTrue);
    run(scene);
    expect(scene.characters, isEmpty);
  });

  test('a team at the desks nearest its lead, then the table, then +N; '
      'out when done', () {
    TeamMember member(String id) => TeamMember(id: id, label: id);
    final scene = RoomScene(random: math.Random(1));
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
    // Two desks free of four: sat at them, the third round the table.
    final tiles = {for (final c in scene.characters) c.tile};
    expect(tiles, hasLength(5));
    expect(members.where((c) => c.sitting), hasLength(2));
    expect(layout.table.map((s) => s.tile), contains(members.last.tile));

    scene.sync([
      agent('a', tool: ToolKind.agent, team: [team[1]]),
      agent('b'),
    ]);
    expect(members[0].leaving, isTrue);
    expect(members[1].leaving, isFalse);
    run(scene);
    expect(scene.characters.where((c) => c.isMember).single, members[1]);
    expect(lead.teamOverflow, 0);

    scene.sync([agent('b')]);
    run(scene);
    expect(scene.characters.map((c) => c.agent.title), ['b']);
  });

  test('each to its own desk; motion turned down, there at once', () {
    final scene = RoomScene(random: math.Random(2));
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
