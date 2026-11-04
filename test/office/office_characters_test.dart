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

  test('an intern beside its boss while a subagent runs', () {
    final scene = RoomScene();
    scene.sync([agent('a', tool: ToolKind.agent)]);
    run(scene);
    final [boss, intern] = scene.characters;
    expect(intern.isIntern, isTrue);
    expect(intern.tile, layout.besides(boss.desk!).tile);
    expect(boss.sitting, isTrue);

    scene.sync([agent('a')]);
    expect(intern.leaving, isTrue);
    run(scene);
    expect(scene.characters, [boss]);
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
