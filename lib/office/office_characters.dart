import 'dart:math' as math;

import 'package:flutter/painting.dart';

import '../chat/chat_models.dart' show ChatItem;
import '../workspace/workspace.dart';
import 'office_layout.dart';
import 'office_model.dart';
import 'office_painter.dart';
import 'office_sprites.dart';

/// What a character does where it gets to.
enum _Pose { sit, stand }

/// A character of a room, as Pixel Agents' characters.ts: it comes in at
/// the door and walks a path tile by tile to its own desk, sits there at
/// its PC whatever it does (stands by it, waving, to ask), and leaves by
/// the door.
class OfficeCharacter {
  OfficeCharacter._(this.agent, this.tile, {this.lead})
    : activity = agent.activity,
      status = agent.status,
      current = agent.source.current,
      position = _center(tile);

  /// Its conversation, as last synced; a team member's is its lead's.
  OfficeAgent agent;

  /// Its lead, for a team member: in while that runs its subagent.
  final OfficeCharacter? lead;

  /// The subagent it is, for a team member.
  TeamMember? member;

  /// A lead's: its conversation's subagents at work ([teamOf]), those of
  /// them in the room by id, and how many there was no seat for.
  List<TeamMember> team = const [];
  final _team = <String, OfficeCharacter>{};
  int teamOverflow = 0;

  OfficeActivity activity;

  /// Its conversation's status and what its turn runs, as last followed:
  /// what its bubble says ([activityText]).
  ThreadStatus status;
  ChatItem? current;

  /// Where its bubble was last drawn, in the room's pixels: a click on it
  /// is one on the character. Null: none.
  Rect? bubble;

  Tile tile;
  List<Tile> path = const [];

  /// Of the step to [path]'s first tile, 0 to 1.
  double _progress = 0;

  /// Its own desk, for as long as it is in the room.
  Seat? desk;

  /// Where it is going, and how it will be there.
  Seat? _goal;
  _Pose _pose = _Pose.stand;
  OfficeFacing facing = OfficeFacing.down;

  /// On its way out, by the door.
  bool leaving = false;

  /// Of its coming in at the door (Pixel Agents' matrix effect), 0 to 1;
  /// it walks once in.
  double appear = 0;

  /// Of its going at the door, once there, 0 to 1: out at 1.
  double vanish = 0;

  /// A team member done: the seconds it sits on with its ✓ before it gets
  /// up to leave.
  double done = 0;

  /// The matrix effect's, and how long one done sits on.
  static const effectTime = 0.5, doneTime = 1.5;

  int _frame = 0;
  double _frameTime = 0;

  bool get walking => path.isNotEmpty;
  bool get sitting => !walking && _pose == _Pose.sit;
  bool get isMember => lead != null;

  /// Where it is, in the room's pixels (see [RoomScene.origin]): its feet,
  /// on its tile's middle.
  Offset position;

  /// The frame of its sheet now ([OfficeSprites.frames]).
  int get frame {
    if (walking) return const [0, 1, 2, 1][_frame % 4];
    final two = _frame % 2;
    if (isMember) return sitting ? 3 + two : 1;
    return switch (activity) {
      OfficeActivity.reading => 5 + two,
      OfficeActivity.typing ||
      OfficeActivity.server ||
      OfficeActivity.window ||
      OfficeActivity.intern => 3 + two,
      // Arms up and down.
      OfficeActivity.waving => two == 0 ? 1 : 3,
      // Still, hands on the desk or round the cup.
      OfficeActivity.done || OfficeActivity.coffee when sitting => 3,
      _ => 1,
    };
  }

  /// Where its frame is drawn, in the room's pixels: a little lower sat,
  /// as Pixel Agents' CHARACTER_SITTING_OFFSET_PX.
  Rect get rect => Rect.fromLTWH(
    position.dx - OfficeSprites.frameWidth / 2,
    position.dy + (sitting ? 6 : 0) - OfficeSprites.frameHeight + 8,
    OfficeSprites.frameWidth,
    OfficeSprites.frameHeight,
  );

  static Offset _center(Tile at) => Offset(
    at.col * OfficeLayout.tile + OfficeLayout.tile / 2,
    at.row * OfficeLayout.tile + OfficeLayout.tile / 2,
  );

  void _goTo(OfficeLayout layout, Seat? goal, _Pose pose) {
    _pose = pose;
    if (goal == null) return;
    final moved = goal.tile != _goal?.tile;
    _goal = goal;
    if (!walking) facing = goal.facing;
    if (!moved) return;
    // Mid step: on to the tile it steps to, then the new way from there.
    path = walking && _progress > 0
        ? [path.first, ...layout.findPath(path.first, goal.tile)]
        : layout.findPath(tile, goal.tile);
    if (!walking) _progress = 0;
  }

  void _snap() {
    appear = 1;
    if (_goal case final goal?) tile = goal.tile;
    path = const [];
    _progress = 0;
    position = _center(tile);
    facing = _goal?.facing ?? facing;
  }

  /// [seconds] on: a step along its path, its frames.
  void _update(double seconds) {
    _frameTime += seconds;
    final frameTime = walking ? 0.15 : 0.3;
    if (_frameTime >= frameTime) {
      _frameTime %= frameTime;
      _frame++;
    }
    if (appear < 1) {
      // At the door till it is all there.
      appear = math.min(1, appear + seconds / effectTime);
      return;
    }
    if (!walking) return;
    final next = path.first;
    facing = switch ((next.col - tile.col, next.row - tile.row)) {
      (> 0, _) => OfficeFacing.right,
      (< 0, _) => OfficeFacing.left,
      (_, > 0) => OfficeFacing.down,
      _ => OfficeFacing.up,
    };
    // Pixel Agents' 48 pixels a second: 3 tiles.
    _progress += 3 * seconds;
    final (from, to) = (_center(tile), _center(next));
    position = Offset.lerp(from, to, math.min(_progress, 1))!;
    if (_progress >= 1) {
      tile = next;
      path = path.sublist(1);
      _progress = 0;
      if (!walking) {
        _frame = 0;
        facing = _goal?.facing ?? facing;
      }
    }
  }
}

/// A room's characters: one per agent synced ([sync]), and their teams.
class RoomScene {
  RoomScene({OfficeLayout? layout}) : layout = layout ?? OfficeLayout.room;

  final OfficeLayout layout;

  final _byKey = <Object, OfficeCharacter>{};

  /// At most this many of a lead's team come in; the rest are its
  /// [OfficeCharacter.teamOverflow].
  static const maxTeam = 3;

  /// Those still in, teams too, in no order.
  List<OfficeCharacter> get characters => [
    for (final character in _byKey.values) ...[
      character,
      ...character._team.values,
    ],
    ..._leavingMembers,
  ];
  final _leavingMembers = <OfficeCharacter>[];

  /// Someone walks: frames to draw at the clock's quickest.
  bool get moving => characters.any((c) => c.walking);

  static Object _keyOf(OfficeAgent agent) => agent.thread ?? agent.title;

  /// Those in the room are now [agents]: who is new comes in by the door,
  /// who is not among them any more leaves by it; each goes to where its
  /// activity is done. [still] (motion turned down): each is there at
  /// once, and who leaves is gone.
  void sync(List<OfficeAgent> agents, {bool still = false}) {
    final keys = {for (final agent in agents) _keyOf(agent)};
    for (final character in _byKey.values) {
      if (!keys.contains(_keyOf(character.agent))) character.leaving = true;
    }
    for (final agent in agents) {
      final character = _byKey[_keyOf(agent)] ??= OfficeCharacter._(
        agent,
        layout.door,
      );
      character
        ..agent = agent
        ..activity = agent.activity
        ..status = agent.status
        ..current = agent.source.current
        ..team = agent.team
        ..leaving = false;
    }
    _place(still: still);
  }

  /// What each one's thread runs now: the workspace tells of a status
  /// changed, not of each tool a turn runs.
  void _follow() {
    for (final character in _byKey.values) {
      if (character.agent.thread case final thread?) {
        character
          ..status = thread.shownStatus
          ..current = runningItem(thread)
          ..activity = activityOf(character.status, kindOf(character.current))
          ..team = teamOf(thread);
      }
    }
  }

  void _place({required bool still}) {
    final characters = _byKey.values.toList();
    final desks = {
      for (final c in characters)
        if (c.desk case final desk?) desk.tile,
    };
    // Who is done keeps its seat while it sits on.
    final taken = <Tile>{
      for (final c in _leavingMembers)
        if (c.done > 0 && c._goal != null) c._goal!.tile,
    };
    for (final character in characters) {
      if (character.leaving) {
        _leave(character);
        continue;
      }
      final desk = character.desk ??= layout.deskFor(
        character.agent.hash,
        desks,
      );
      if (desk != null) desks.add(desk.tile);
      if (character.activity == OfficeActivity.waving) {
        // Up from its chair, turned to the room.
        character._goTo(
          layout,
          desk == null ? null : Seat(desk.tile, OfficeFacing.down),
          _Pose.stand,
        );
      } else {
        character._goTo(layout, desk, _Pose.sit);
      }
      if (character._goal case final goal?) taken.add(goal.tile);
    }
    // The teams after: who leads a conversation has the desks first.
    taken.addAll(desks);
    for (final character in characters) {
      if (!character.leaving) _keepTeam(character, taken);
    }
    if (still) {
      for (final character in _leavingMembers) {
        character
          ..done = 0
          ..leaving = true;
      }
      for (final character in this.characters) {
        character._snap();
      }
      _sweep(all: true);
    }
  }

  void _leave(OfficeCharacter character) {
    character
      ..leaving = true
      ..done = 0;
    character._goTo(layout, Seat(layout.door, OfficeFacing.up), _Pose.stand);
    for (final member in character._team.values) {
      _leavingMembers.add(member);
      _leave(member);
    }
    character._team.clear();
  }

  /// [lead]'s team in, up to [maxTeam], each to the free desk nearest its
  /// lead's (sat, at work) or round the meeting table, none of [taken];
  /// who is done, or has no seat, out by the door.
  void _keepTeam(OfficeCharacter lead, Set<Tile> taken) {
    final desk = lead.desk;
    final team = desk == null ? const <TeamMember>[] : lead.team;
    final ids = {for (final member in team) member.id};
    for (final id in [...lead._team.keys]) {
      if (!ids.contains(id)) _leaveTeam(lead, id);
    }
    var placed = 0;
    for (final member in team.take(maxTeam)) {
      final character = lead._team[member.id] ??= OfficeCharacter._(
        lead.agent,
        layout.door,
        lead: lead,
      );
      character.member = member;
      final kept = character._goal;
      final seat = kept != null && !taken.contains(kept.tile)
          ? kept
          : layout.teamSeat(desk!, taken);
      if (seat == null) {
        _leaveTeam(lead, member.id);
        continue;
      }
      taken.add(seat.tile);
      placed++;
      character._goTo(layout, seat, seat.pc ? _Pose.sit : _Pose.stand);
    }
    lead.teamOverflow = team.length - placed;
  }

  /// [lead]'s member [id] done: sat on a while, its ✓ over it, if sat;
  /// then out.
  void _leaveTeam(OfficeCharacter lead, String id) {
    final member = lead._team.remove(id)!;
    _leavingMembers.add(member);
    if (member.sitting) {
      member.done = OfficeCharacter.doneTime;
    } else {
      _leave(member);
    }
  }

  /// Takes out who has left: gone at the door ([all]: wherever they are).
  void _sweep({bool all = false}) {
    bool out(OfficeCharacter c) => c.leaving && (all || c.vanish >= 1);
    _byKey.removeWhere((_, c) => out(c));
    _leavingMembers.removeWhere(out);
  }

  double _sinceFollow = 0;

  /// [seconds] on.
  void update(double seconds) {
    // Twice a second is soon enough to see a tool change.
    if ((_sinceFollow += seconds) >= 0.5) {
      _sinceFollow = 0;
      _follow();
      _place(still: false);
    }
    for (final character in characters) {
      if (character.isMember && !character.leaving) {
        character.agent = character.lead!.agent;
      }
      if (character.done > 0 && (character.done -= seconds) <= 0) {
        _leave(character);
      }
      character._update(seconds);
      if (character.leaving &&
          !character.walking &&
          character.tile == layout.door) {
        character.vanish = math.min(
          1,
          character.vanish + seconds / OfficeCharacter.effectTime,
        );
      }
    }
    _sweep();
  }

  /// The room's floor, row 0's top left, in a [RoomBox.rect] at [topLeft]:
  /// a tile down, for the wall's pieces.
  static Offset origin(Offset topLeft) =>
      topLeft + const Offset(0, OfficeLayout.tile);

  /// The character at [at], in the room's pixels, or whose bubble is
  /// there; the front one first.
  OfficeCharacter? characterAt(Offset at) =>
      (characters..sort((a, b) => b.position.dy.compareTo(a.position.dy)))
          .where(
            (c) =>
                !c.leaving &&
                (c.rect.contains(at) || (c.bubble?.contains(at) ?? false)),
          )
          .firstOrNull;

  /// Draws the room at [topLeft] ([RoomBox.rect]'s): its floor of the
  /// [floor]th tiles, the wall, the furniture and the characters, front
  /// ones over those behind, [badge]s on them. [tick] plays what plays by
  /// itself: the PCs, the server's lights.
  void paint(
    Canvas canvas,
    Offset topLeft,
    OfficeSprites sprites, {
    int floor = 0,
    Color floorTint = const Color(0xffc8a27a),
    Color wallTint = const Color(0xffe6dccb),
    Color? badge,
    int tick = 0,
    bool small = false,
  }) {
    final o = origin(topLeft);
    const t = OfficeLayout.tile;
    Offset at(Tile tile) => o + Offset(tile.col * t, tile.row * t);
    for (var row = 0; row < OfficeLayout.rows; row++) {
      for (var col = 0; col < OfficeLayout.cols; col++) {
        final tile = (col: col, row: row);
        if (row > 0) {
          sprites.draw(
            canvas,
            sprites.floors[floor % sprites.floors.length],
            at(tile),
            tint: floorTint,
          );
          continue;
        }
        // Row 0 all wall, east and west joined, the door a dark way in it.
        final mask = (col < OfficeLayout.cols - 1 ? 2 : 0) | (col > 0 ? 8 : 0);
        sprites.drawWall(
          canvas,
          mask,
          at(tile) - const Offset(0, t),
          tint: wallTint,
        );
        if (tile == layout.door) {
          canvas.drawRect(
            Rect.fromLTWH(at(tile).dx + 2, at(tile).dy - 10, t - 4, t + 10),
            Paint()..color = const Color(0xff3b2c22),
          );
        }
      }
    }
    final characters = this.characters;
    // Back to front: by where each stands; a seat under who sits on it.
    final drawables = <(double, void Function())>[
      // Pieces at one depth in the layout's order (a PC on its desk).
      for (final (i, piece) in layout.pieces.indexed)
        (
          piece.onWall
              ? -1.0 + i / 100
              : (piece.tile.row + (piece.seat ? 0 : 1)) * t - 1 + i / 100,
          () => _paintPiece(canvas, piece, at, sprites, characters, tick),
        ),
      for (final character in characters)
        (
          character.position.dy,
          () => _paintCharacter(canvas, character, o, sprites, badge, small),
        ),
    ]..sort((a, b) => a.$1.compareTo(b.$1));
    for (final (_, paint) in drawables) {
      paint();
    }
  }

  void _paintPiece(
    Canvas canvas,
    OfficePiece piece,
    Offset Function(Tile) at,
    OfficeSprites sprites,
    List<OfficeCharacter> characters,
    int tick,
  ) {
    final bottom = at(piece.tile) + const Offset(0, OfficeLayout.tile);
    var asset = piece.asset;
    if (asset == null) {
      // The server: a dark rack of 16×32, its lights blinking.
      final rack = Rect.fromLTWH(bottom.dx + 2, bottom.dy - 30, 12, 30);
      canvas.drawRect(rack, Paint()..color = const Color(0xff2b2f3a));
      for (var i = 0; i < 4; i++) {
        final on = (tick + i * 3) % 7 < 4;
        canvas
          ..drawRect(
            Rect.fromLTWH(rack.left + 2, rack.top + 3 + i * 7, 8, 4),
            Paint()..color = const Color(0xff3d4352),
          )
          ..drawRect(
            Rect.fromLTWH(rack.left + 8, rack.top + 4 + i * 7, 1, 1),
            Paint()
              ..color = on ? const Color(0xff4cd964) : const Color(0xff1e5b2a),
          );
      }
      return;
    }
    if (asset == 'PC/PC_FRONT_OFF' &&
        characters.any(
          (c) =>
              c.sitting &&
              c.tile == (col: piece.tile.col, row: piece.tile.row + 1),
        )) {
      asset = 'PC/PC_FRONT_ON_${tick % 3 + 1}';
    }
    final image = sprites.furniture[asset];
    if (image == null) return;
    sprites.draw(canvas, image, bottom - Offset(0, image.height.toDouble()));
  }

  void _paintCharacter(
    Canvas canvas,
    OfficeCharacter character,
    Offset origin,
    OfficeSprites sprites,
    Color? badge,
    bool small,
  ) {
    final rect = character.rect.shift(origin);
    final kernel = character.agent.kernel;
    sprites.drawCharacter(
      canvas,
      character.member?.sprite ?? character.agent.sprite,
      rect,
      frame: character.frame,
      facing: character.facing,
      hue: character.member?.hue ?? character.agent.hue,
      badge: character.isMember ? null : badge,
      kernel: kernel,
      appear: character.appear,
      vanish: character.vanish,
    );
    if (character.appear < 1 || character.vanish > 0) return;
    // Who runs it, by its head; a team member's, its lead's, smaller.
    final member = small || character.isMember;
    OfficeSprites.drawKernel(
      canvas,
      kernel,
      rect.topLeft + (member ? const Offset(12, 4) : const Offset(11, 3)),
      small: member,
    );
  }
}

/// The scenes of the campus's rooms, kept from build to build so their
/// characters walk on.
class OfficeScenes {
  final _rooms = <Project, RoomScene>{};

  RoomScene? operator [](Project project) => _rooms[project];

  bool get moving => _rooms.values.any((scene) => scene.moving);

  /// No room has anyone in it: nothing to play.
  bool get isEmpty => _rooms.isEmpty;

  double _seconds = 0;

  /// Steps of 0.15 s gone: the PCs' and the server's frames.
  int get tick => _seconds ~/ 0.15;

  /// To [campus]: a room's scene for each room shown, synced; those of
  /// rooms not shown any more dropped.
  void sync(OfficeCampus campus, {bool still = false}) {
    final shown = <Project>{};
    for (final building in campus.buildings) {
      for (final room in building.rooms) {
        shown.add(room.project);
        (_rooms[room.project] ??= RoomScene()).sync(room.visible, still: still);
      }
    }
    _rooms.removeWhere((project, _) => !shown.contains(project));
  }

  void update(double seconds) {
    _seconds += seconds;
    for (final scene in _rooms.values) {
      scene.update(seconds);
    }
  }

  /// The character at [at], in [geometry]'s pixels, and where it is: a
  /// team member's agent is its lead's. Those a scene has no desk for (level 3)
  /// stand still in [RoomBox.beyond].
  (OfficeAgent, Rect)? find(CampusGeometry geometry, Offset at) {
    for (final building in geometry.buildings) {
      for (final room in building.rooms) {
        if (!room.rect.contains(at)) continue;
        final origin = RoomScene.origin(room.rect.topLeft);
        if (_rooms[room.room.project]?.characterAt(at - origin)
            case final character?) {
          return (character.agent, character.rect.shift(origin));
        }
        for (final (agent, rect) in room.beyond) {
          if (rect.contains(at)) return (agent, rect);
        }
        return null;
      }
    }
    return null;
  }
}
