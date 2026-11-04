import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../chat/chat_models.dart' show ChatItem;
import '../l10n/l10n.dart';
import '../workspace/company_dialog.dart' show companyIcons;
import '../workspace/workspace.dart' show ThreadStatus;
import 'office_characters.dart';
import 'office_layout.dart';
import 'office_model.dart';
import 'office_sprites.dart';

/// Where each thing of the campus is, in the sprites' pixels (a character
/// is 16×32): what [CampusPainter] draws, and what a tap or hover is
/// looked up in ([agentAt] and the like).
class CampusGeometry {
  CampusGeometry._(this.size, this.buildings, {this.labeled = false});

  /// Level 1: the buildings side by side from the top left, each a column
  /// of its rooms (two abreast) from its top down.
  factory CampusGeometry.of(OfficeCampus campus) {
    final buildings = <BuildingBox>[];
    var x = gap;
    var height = 0.0;
    for (final building in campus.buildings) {
      final box = _place(building, building.rooms, x, columns: 2)._down(gap);
      buildings.add(box);
      height = math.max(height, box.rect.bottom);
      x += box.rect.width + gap;
    }
    return CampusGeometry._(Size(x, height + gap), buildings);
  }

  /// Level 2: [building] alone, a room for each of its projects (those not
  /// in the Ativas empty, closed), each character with its title.
  factory CampusGeometry.building(OfficeBuilding building) {
    final rooms = [
      ...building.rooms,
      for (final project in building.dim) OfficeRoom(project, const []),
    ];
    final columns = math.min(4, math.sqrt(rooms.length).ceil());
    return CampusGeometry._alone(
      _place(building, rooms, gap, columns: columns, labeled: true),
    );
  }

  /// Level 3: [room] of [building] alone, every character in it.
  factory CampusGeometry.room(OfficeBuilding building, OfficeRoom room) =>
      CampusGeometry._alone(
        _place(building, [room], gap, columns: 1, labeled: true, all: true),
      );

  factory CampusGeometry._alone(BuildingBox box) {
    final placed = box._down(gap);
    return CampusGeometry._(
      Size(placed.rect.right + gap, placed.rect.bottom + gap),
      [placed],
      labeled: true,
    );
  }

  /// [building] at [x], [rooms] in [columns]: [all] its characters (level
  /// 3: those its scene has no desk for in rows under it), or up to
  /// [OfficeRoom.maxVisible] with the dim squares under (level 1).
  static BuildingBox _place(
    OfficeBuilding building,
    List<OfficeRoom> rooms,
    double x, {
    required int columns,
    bool labeled = false,
    bool all = false,
  }) {
    columns = math.max(1, math.min(columns, rooms.length));
    final rows = (rooms.length / columns).ceil();
    final lines = all ? (rooms.single.overflow / perRow).ceil() : 0;
    final height = roomHeight + lines * lineHeight;
    final outer = pad * 2 + columns * roomWidth + (columns - 1) * roomGap;
    final boxes = [
      for (final (i, room) in rooms.indexed)
        RoomBox._(
          room,
          Rect.fromLTWH(
            x + pad + (i % columns) * (roomWidth + roomGap),
            signHeight + pad + (i ~/ columns) * (height + roomGap),
            roomWidth,
            height,
          ),
          all: all,
        ),
    ];
    final top = signHeight + pad + rows * (height + roomGap);
    // The dim squares only on the campus: on level 2 they are rooms.
    final dim = labeled ? 0.0 : dimHeight;
    return BuildingBox._(
      building,
      Rect.fromLTWH(x, 0, outer, top + dim + pad),
      boxes,
      Rect.fromLTWH(x + pad, top, outer - pad * 2, dim),
    );
  }

  static const gap = 8.0, pad = 6.0, signHeight = 14.0;
  // A room's scene, its wall a tile over its floor (see OfficeLayout).
  static const roomWidth = OfficeLayout.width;
  static const roomHeight = OfficeLayout.height;
  static const roomGap = 4.0, dimHeight = 10.0;

  /// A character's width where it stands in a row (its title over it), how
  /// many a row, each row this high.
  static const slot = 30.0, perRow = 4;
  static const lineHeight = OfficeSprites.frameHeight + 8;

  /// The whole campus's.
  final Size size;
  final List<BuildingBox> buildings;

  /// The characters have their titles over them (levels 2 and 3).
  final bool labeled;

  /// Where they stand in rows: where they are while the sprites load
  /// (after, see [OfficeScenes.find]).
  OfficeAgent? agentAt(Offset at) => find((_, rect) => rect.contains(at))?.$1;

  /// The first character [test] holds for, and where it is.
  (OfficeAgent, Rect)? find(bool Function(OfficeAgent, Rect) test) {
    for (final building in buildings) {
      for (final room in building.rooms) {
        for (final (agent, rect) in room.agents) {
          if (test(agent, rect)) return (agent, rect);
        }
      }
    }
    return null;
  }

  RoomBox? roomAt(Offset at) {
    for (final building in buildings) {
      for (final room in building.rooms) {
        if (room.rect.contains(at)) return room;
      }
    }
    return null;
  }

  BuildingBox? buildingAt(Offset at) {
    for (final building in buildings) {
      if (building.rect.contains(at)) return building;
    }
    return null;
  }
}

class BuildingBox {
  BuildingBox._(this.building, this.rect, this.rooms, this.dim);

  final OfficeBuilding building;
  final Rect rect;
  final List<RoomBox> rooms;

  /// The row of its projects' dim squares.
  final Rect dim;

  /// Its sign, the top of [rect].
  Rect get sign =>
      Rect.fromLTWH(rect.left, rect.top, rect.width, CampusGeometry.signHeight);

  BuildingBox _down(double dy) =>
      BuildingBox._(building, rect.translate(0, dy), [
        for (final room in rooms)
          RoomBox._(room.room, room.rect.translate(0, dy), all: room.all),
      ], dim.translate(0, dy));
}

class RoomBox {
  RoomBox._(this.room, this.rect, {required this.all})
    : agents = [
        // Those its scene has: in a row on its floor.
        for (final (i, agent) in room.visible.indexed)
          (agent, _at(rect, i, rect.top + CampusGeometry.roomHeight)),
        // The rest (level 3): in rows under it.
        if (all)
          for (final (i, agent)
              in room.agents.skip(OfficeRoom.maxVisible).indexed)
            (
              agent,
              _at(
                rect,
                i % CampusGeometry.perRow,
                rect.top +
                    CampusGeometry.roomHeight +
                    (i ~/ CampusGeometry.perRow + 1) *
                        CampusGeometry.lineHeight,
              ),
            ),
      ];

  /// The [i]th of a row whose feet are at [bottom].
  static Rect _at(Rect rect, int i, double bottom) => Rect.fromLTWH(
    rect.left +
        3 +
        i * CampusGeometry.slot +
        (CampusGeometry.slot - OfficeSprites.frameWidth) / 2,
    bottom - OfficeSprites.frameHeight - 2,
    OfficeSprites.frameWidth,
    OfficeSprites.frameHeight,
  );

  final OfficeRoom room;
  final Rect rect;

  /// All its characters are placed (level 3), or up to
  /// [OfficeRoom.maxVisible].
  final bool all;

  /// Its characters, each where it stands in a row.
  final List<(OfficeAgent, Rect)> agents;

  /// Those its scene has no desk for (level 3): in rows under it, still.
  Iterable<(OfficeAgent, Rect)> get beyond => agents.skip(room.visible.length);
}

/// The colors [CampusPainter] draws with, from the theme.
typedef OfficeColors = ({
  Color text,
  Color muted,
  Color border,
  Color room,
  Color building,
  Color waiting,
  Color sky,
  Color ground,

  /// A room's, while someone in it works: its lights on.
  Color lit,
});

/// The campus (level 1), at a whole [scale] of [geometry]: the companies'
/// buildings, their rooms with the characters in them, the dim squares.
class CampusPainter extends CustomPainter {
  CampusPainter({
    required this.geometry,
    required this.scale,
    required this.colors,
    this.pixelRatio = 1,
    this.sprites,
    this.scenes,
    this.highlight,
    this.l10n,
    super.repaint,
  });

  /// What the bubbles say in; English when null.
  final AppLocalizations? l10n;

  final CampusGeometry geometry;

  /// The screen's pixels a sprite's pixel takes: whole, so pixel art stays
  /// crisp whatever the display's scaling ([pixelRatio]).
  final int scale;
  final double pixelRatio;
  final OfficeColors colors;

  /// Null while they load: boxes stand in for the characters.
  final OfficeSprites? sprites;

  /// The rooms' characters on the move; null: each stands still in a row.
  final OfficeScenes? scenes;

  /// The building or room under the pointer, a click away: outlined.
  final Rect? highlight;

  /// A building's own color; grey ([OfficeColors.muted]) without one.
  Color colorOf(OfficeBuilding building) => switch (building.color) {
    final argb? => Color(argb),
    null => colors.muted,
  };

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..scale(scale / pixelRatio)
      ..drawRect(Offset.zero & geometry.size, Paint()..color = colors.sky);
    for (final building in geometry.buildings) {
      // Each stands on its own patch of ground.
      final foot = building.rect.bottom;
      canvas.drawRect(
        Rect.fromLTRB(
          building.rect.left - 2,
          foot,
          building.rect.right + 2,
          foot + 3,
        ),
        Paint()..color = colors.ground,
      );
      paintBuilding(canvas, building);
    }
    if (highlight case final rect?) {
      canvas.drawRect(
        rect.inflate(1),
        _stroke(colors.text.withValues(alpha: 0.7)),
      );
    }
  }

  /// Its facade tinted with its color, under a roof in it that bears its
  /// icon and name, a door at its foot.
  void paintBuilding(Canvas canvas, BuildingBox box) {
    final color = colorOf(box.building);
    final ink = inkOn(color);
    // The roof juts out a pixel each side, a darker eave under it.
    final roof = Rect.fromLTRB(
      box.sign.left - 1,
      box.sign.top,
      box.sign.right + 1,
      box.sign.bottom,
    );
    canvas
      ..drawRect(
        box.rect,
        Paint()..color = Color.lerp(colors.building, color, 0.18)!,
      )
      ..drawRect(box.rect, _stroke(colors.border))
      ..drawRect(roof, Paint()..color = color)
      ..drawRect(
        Rect.fromLTRB(roof.left, roof.bottom - 2, roof.right, roof.bottom),
        Paint()..color = _shade(color, 0.3),
      );
    final icon = companyIcons[box.building.icon];
    final sign = box.sign.deflate(3);
    if (icon != null) {
      _text(
        canvas,
        String.fromCharCode(icon.codePoint),
        sign,
        size: 7,
        color: ink,
        family: icon.fontFamily,
        package: icon.fontPackage,
      );
    }
    // The projects in no company: how many, the way to assign them beside.
    final none = box.building.company == null;
    final count = box.building.rooms.length + box.building.dim.length;
    _text(
      canvas,
      none ? '${box.building.name} · $count' : box.building.name,
      icon == null
          ? sign
          : Rect.fromLTRB(sign.left + 9, sign.top, sign.right, sign.bottom),
      size: 7,
      color: ink,
      bold: true,
    );
    // The door, right of the dim squares, down to the ground.
    final door = Rect.fromLTRB(
      box.dim.right - doorWidth,
      box.dim.top,
      box.dim.right,
      box.rect.bottom,
    );
    canvas
      ..drawRect(door, Paint()..color = _shade(color, 0.45))
      ..drawRect(
        Rect.fromLTWH(door.right - 3, door.center.dy.floorToDouble(), 1, 1),
        Paint()..color = ink,
      );
    for (final room in box.rooms) {
      if (room.room.agents.isEmpty) {
        paintClosed(canvas, room);
      } else {
        paintRoom(canvas, room, badge: color);
      }
    }
    paintDim(canvas, box);
  }

  /// A project with nothing in the Ativas (level 2): dim, its door shut.
  void paintClosed(Canvas canvas, RoomBox box) {
    canvas.drawRect(box.rect, _stroke(colors.border));
    _text(
      canvas,
      box.room.project.name,
      Rect.fromLTWH(box.rect.left + 3, box.rect.top + 2, box.rect.width - 6, 8),
      size: 6,
      color: colors.muted,
    );
    final door = Rect.fromLTWH(
      box.rect.center.dx - 5,
      box.rect.bottom - 18,
      10,
      18,
    );
    canvas
      ..drawRect(door, Paint()..color = colors.room)
      ..drawRect(door, _stroke(colors.muted))
      ..drawRect(
        Rect.fromLTWH(door.right - 3, door.center.dy, 1, 1),
        Paint()..color = colors.muted,
      );
  }

  /// A room and who is in it, their company's [badge] on them: its scene
  /// (lib/office/office_characters.dart) where there is one, those it has
  /// no desk for (level 3) in rows under it.
  void paintRoom(Canvas canvas, RoomBox box, {Color? badge}) {
    final label = Rect.fromLTWH(
      box.rect.left + 3,
      box.rect.top + 2,
      box.rect.width - 6,
      8,
    );
    if ((sprites, scenes?[box.room.project]) case (
      final sprites?,
      final scene?,
    )) {
      canvas
        ..drawRect(box.rect, Paint()..color = roomColor(box.room))
        ..save()
        ..clipRect(
          Rect.fromLTWH(
            box.rect.left,
            box.rect.top,
            box.rect.width,
            CampusGeometry.roomHeight,
          ),
        );
      scene.paint(
        canvas,
        box.rect.topLeft,
        sprites,
        floor: box.room.project.name.length,
        badge: badge,
        tick: scenes!.tick,
        small: !geometry.labeled,
      );
      // Someone at work in it: its lights on, a wash over the scene.
      if (roomColor(box.room) == colors.lit) {
        canvas.drawRect(
          box.rect,
          Paint()..color = colors.lit.withValues(alpha: 0.18),
        );
      }
      canvas
        ..restore()
        ..drawRect(box.rect, _stroke(colors.border))
        ..drawRect(
          Rect.fromLTWH(label.left - 2, label.top - 1, label.width + 4, 9),
          Paint()..color = const Color(0x99000000),
        );
      _text(
        canvas,
        box.room.project.name,
        label,
        size: 6,
        color: const Color(0xffffffff),
      );
      final origin = RoomScene.origin(box.rect.topLeft);
      final says = <_Say>[];
      for (final character in scene.characters) {
        character.bubble = null;
        if (character.leaving || character.walking) continue;
        final rect = character.rect.shift(origin);
        if (character.member case final member?) {
          if (character.done > 0) {
            says.add(_Say(rect, _Mark.done, character: character));
          } else if (geometry.labeled) {
            says.add(
              _Say(rect, _Mark.work, line: _memberLine(member), member: true),
            );
          }
          continue;
        }
        says.add(
          _sayOf(
            character.agent,
            character.status,
            character.current,
            rect,
            character: character,
          ),
        );
        if (character.teamOverflow > 0) {
          _text(
            canvas,
            '+${character.teamOverflow}',
            Rect.fromLTWH(rect.right - 3, rect.top + 11, 10, 5),
            size: 4,
            color: const Color(0xffffffff),
          );
        }
      }
      _paintStill(canvas, box.beyond, sprites, says);
      _paintSays(canvas, says, box.rect, origin);
      _paintMore(canvas, box);
      return;
    }
    canvas
      ..drawRect(box.rect, Paint()..color = roomColor(box.room))
      ..drawRect(box.rect, _stroke(colors.border));
    _text(canvas, box.room.project.name, label, size: 6, color: colors.text);
    final says = <_Say>[];
    _paintStill(canvas, box.agents, sprites, says);
    _paintSays(canvas, says, box.rect, Offset.zero);
    _paintMore(canvas, box);
  }

  /// [agents] standing where they are: boxes while the sprites load; their
  /// bubbles to [says].
  void _paintStill(
    Canvas canvas,
    Iterable<(OfficeAgent, Rect)> agents,
    OfficeSprites? sprites,
    List<_Say> says,
  ) {
    for (final (agent, rect) in agents) {
      switch (sprites) {
        case final sprites?:
          sprites.drawCharacter(
            canvas,
            agent.sprite,
            rect,
            hue: agent.hue,
            kernel: agent.kernel,
          );
          OfficeSprites.drawKernel(
            canvas,
            agent.kernel,
            rect.topLeft + const Offset(11, 3),
            small: !geometry.labeled,
          );
        case null:
          canvas.drawRect(rect.deflate(3), Paint()..color = colors.muted);
      }
      says.add(_sayOf(agent, agent.status, agent.source.current, rect));
    }
  }

  /// The bubble of a conversation's character at [rect], for its [status]
  /// and what its turn runs ([current]): its title on top, then what it
  /// does ([activityText]); on the campus, its icon alone.
  _Say _sayOf(
    OfficeAgent agent,
    ThreadStatus status,
    ChatItem? current,
    Rect rect, {
    OfficeCharacter? character,
  }) => _Say(
    rect,
    switch (status) {
      ThreadStatus.needsInput => _Mark.wait,
      ThreadStatus.unread => _Mark.done,
      ThreadStatus.running => _Mark.work,
      ThreadStatus.idle => null,
    },
    title: agent.title,
    line: activityText(status, current, l10n ?? englishLocalizations),
    character: character,
  );

  /// [says] drawn, kept in [room]: each over its own head, a tail down to
  /// it, the most urgent first; one that would cover another put a line
  /// up, else down to its icon; who has neither (one idle) left out, its
  /// title in its hover. [origin]: the scene's, for [OfficeCharacter.bubble].
  void _paintSays(Canvas canvas, List<_Say> says, Rect room, Offset origin) {
    says.sort((a, b) => b.priority.compareTo(a.priority));
    final placed = <(Rect, _Say, TextPainter?, TextPainter?)>[];
    bool clear(Rect box) =>
        !placed.any((p) => p.$1.inflate(1).overlaps(box)) &&
        box.top >= room.top + 10;
    for (final say in says) {
      final head = say.head;
      Rect over(Size size, double up) => Rect.fromLTWH(
        (head.dx - size.width / 2)
            .clamp(room.left + 1, room.right - size.width - 1)
            .roundToDouble(),
        head.dy - 3 - size.height - up,
        size.width,
        size.height,
      );
      TextPainter? title, line;
      if (geometry.labeled) {
        final ink = say.colors.$2;
        if (!say.member && say.title != null) {
          title = _painter(say.title!, ink.withValues(alpha: 0.65), 3.5);
        }
        if (say.line != null) {
          line = _painter(
            say.line!,
            ink,
            4,
            indent: say.mark == _Mark.work || say.mark == null ? 0 : 6,
          );
        }
      }
      Rect? box;
      if (title != null || line != null) {
        final indent = say.mark == _Mark.work || say.mark == null ? 0 : 6;
        final size = Size(
          (math.max(title?.width ?? 0, (line?.width ?? 0) + indent) + 4)
              .ceilToDouble(),
          2 + (title == null ? 0 : 4.5) + (line == null ? 0 : 4) + 1.5,
        );
        for (final up in [0.0, size.height + 2, size.height * 2 + 4]) {
          if (clear(over(size, up))) {
            box = over(size, up);
            break;
          }
        }
      }
      if (box == null) {
        title?.dispose();
        line?.dispose();
        (title, line) = (null, null);
        if (say.mark == null) continue;
        const icon = Size(10, 7);
        box = [
          for (final up in [0.0, 9.0, 18.0]) over(icon, up),
        ].firstWhere(clear, orElse: () => over(icon, 0));
      }
      placed.add((box, say, title, line));
      say.character?.bubble = box.shift(-origin);
    }
    // The least urgent first: the most on top.
    for (final (box, say, title, line) in placed.reversed) {
      _paintBubble(canvas, box, say, title, line);
    }
  }

  void _paintBubble(
    Canvas canvas,
    Rect box,
    _Say say,
    TextPainter? title,
    TextPainter? line,
  ) {
    const dark = Color(0xff1c1c1e);
    final (fill, ink) = say.colors;
    final head = say.head;
    final tail = head.dx.floorToDouble();
    canvas
      ..drawRect(box.inflate(1), Paint()..color = dark)
      ..drawRect(box, Paint()..color = fill)
      // A tail down to its head: a notch, then a line.
      ..drawRect(
        Rect.fromLTWH(tail - 1, box.bottom + 1, 3, 1),
        Paint()..color = dark,
      )
      ..drawRect(Rect.fromLTWH(tail, box.bottom, 1, 1), Paint()..color = fill)
      ..drawRect(
        Rect.fromLTRB(tail, box.bottom + 2, tail + 1, head.dy - 1),
        Paint()..color = dark,
      );
    if (title == null && line == null) {
      _mark(canvas, say.mark!, box, ink);
      return;
    }
    var y = box.top + 1.5;
    if (title != null) {
      title
        ..paint(canvas, Offset(box.left + 2, y))
        ..dispose();
      y += 4.5;
    }
    if (line != null) {
      if (say.mark case final mark? when mark != _Mark.work) {
        _glyph(canvas, mark, Offset(box.left + 2, y), ink);
        line.paint(canvas, Offset(box.left + 8, y));
      } else {
        line.paint(canvas, Offset(box.left + 2, y));
      }
      line.dispose();
    }
  }

  /// A bubble's icon in [box] (10×7): the "!" of one waiting, the ✓ of one
  /// done, three dots at work, one up and down in turn.
  void _mark(Canvas canvas, _Mark mark, Rect box, Color ink) {
    final paint = Paint()..color = ink;
    void dot(double x, double y, [double w = 2, double h = 2]) =>
        canvas.drawRect(Rect.fromLTWH(box.left + x, box.top + y, w, h), paint);
    switch (mark) {
      case _Mark.wait:
        dot(4, 1, 2, 3);
        dot(4, 5, 2, 1);
      case _Mark.done:
        for (final (x, y) in const [(2, 3), (3, 4), (4, 3), (5, 2), (6, 1)]) {
          dot(x.toDouble(), y.toDouble(), 2, 2);
        }
      case _Mark.work:
        final up = (scenes?.tick ?? 0) ~/ 2 % 3;
        for (var i = 0; i < 3; i++) {
          dot(1 + i * 3.0, i == up ? 2 : 3);
        }
    }
  }

  /// [mark]'s glyph before a bubble's line, 5 wide at [at].
  static void _glyph(Canvas canvas, _Mark mark, Offset at, Color ink) {
    final rows = switch (mark) {
      _Mark.done => const ['....x', '...x.', 'x.x..', '.x...'],
      _ => const ['.xx..', '.xx..', '.xx..', '.....', '.xx..'],
    };
    for (final (y, row) in rows.indexed) {
      for (var x = 0; x < row.length; x++) {
        if (row[x] == 'x') {
          canvas.drawRect(
            Rect.fromLTWH(at.dx + x, at.dy + y, 1, 1),
            Paint()..color = ink,
          );
        }
      }
    }
  }

  static TextPainter _painter(
    String text,
    Color color,
    double size, {
    double indent = 0,
  }) => TextPainter(
    text: TextSpan(
      text: text,
      style: TextStyle(
        color: color,
        fontFamily: _font,
        fontSize: size,
        height: 1,
      ),
    ),
    maxLines: 1,
    ellipsis: '…',
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: maxBubble - 4 - indent);

  /// Windows' own; where there is none, the platform's.
  static const _font = 'Segoe UI';

  /// A bubble's widest: a desk's.
  static const maxBubble = 48.0;

  /// What a team member's bubble says: the call it runs ([activityText]),
  /// else what it was asked.
  String _memberLine(TeamMember member) => switch (member.tool) {
    final tool? => activityText(
      ThreadStatus.running,
      tool,
      l10n ?? englishLocalizations,
    )!,
    null => member.label,
  };

  /// The "+N" of those not shown, and a "!" if one of them waits.
  void _paintMore(Canvas canvas, RoomBox box) {
    // Level 3 shows them all.
    if (box.all) return;
    if (box.room.overflow > 0) {
      _text(
        canvas,
        '+${box.room.overflow}',
        Rect.fromLTWH(box.rect.right - 14, box.rect.bottom - 10, 12, 8),
        size: 6,
        color: colors.muted,
      );
    }
    // Someone waiting among those not shown: the room says so.
    if (box.room.waiting &&
        !box.room.visible.any((a) => a.activity == OfficeActivity.waving)) {
      final at = Rect.fromLTWH(box.rect.right - 12, box.rect.top + 1, 10, 7);
      canvas
        ..drawRect(at.inflate(1), Paint()..color = const Color(0xff1c1c1e))
        ..drawRect(at, Paint()..color = const Color(0xffffcc00));
      _mark(canvas, _Mark.wait, at, const Color(0xff1c1c1e));
    }
  }

  /// A room's light: on while someone in it works.
  Color roomColor(OfficeRoom room) =>
      room.agents.any((agent) => agent.status == ThreadStatus.running)
      ? colors.lit
      : colors.room;

  /// The door's width, at the right of the dim squares' row.
  static const doorWidth = 8.0;

  /// At most this many dim squares, then "+N".
  static const maxDim = 8;

  /// The building's projects with nothing in the Ativas: a dim square
  /// each, up to [maxDim] (or a row's worth), then how many more.
  void paintDim(Canvas canvas, BuildingBox box) {
    // None on levels 2 and 3, where they are rooms.
    if (box.dim.isEmpty) return;
    const side = 6.0, step = side + 2;
    final dim = box.building.dim;
    final fits = math.min(
      maxDim,
      ((box.dim.width - 16 - doorWidth) / step).floor(),
    );
    final shown = dim.length > fits ? fits : dim.length;
    for (var i = 0; i < shown; i++) {
      canvas.drawRect(
        Rect.fromLTWH(box.dim.left + i * step, box.dim.top + 2, side, side),
        _stroke(colors.muted),
      );
    }
    if (dim.length > shown) {
      _text(
        canvas,
        '+${dim.length - shown}',
        Rect.fromLTWH(box.dim.left + shown * step, box.dim.top + 1, 16, 8),
        size: 6,
        color: colors.muted,
      );
    }
  }

  /// What reads on [color]: black or white.
  static Color inkOn(Color color) => color.computeLuminance() > 0.5
      ? const Color(0xff000000)
      : const Color(0xffffffff);

  static Color _shade(Color color, double by) =>
      Color.lerp(color, const Color(0xff000000), by)!;

  Paint _stroke(Color color) => Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  void _text(
    Canvas canvas,
    String text,
    Rect within, {
    required double size,
    Color? color,
    bool bold = false,
    String? family,
    String? package,
  }) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color ?? colors.waiting,
          fontFamily: family ?? _font,
          package: package,
          fontSize: size,
          fontWeight: bold ? FontWeight.w600 : null,
          height: 1,
        ),
      ),
      maxLines: 1,
      ellipsis: '…',
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: within.width);
    painter.paint(canvas, within.topLeft);
    painter.dispose();
  }

  @override
  bool shouldRepaint(CampusPainter old) =>
      old.geometry != geometry ||
      old.scale != scale ||
      old.pixelRatio != pixelRatio ||
      old.colors != colors ||
      old.sprites != sprites ||
      old.scenes != scenes ||
      old.highlight != highlight ||
      old.l10n != l10n;
}

/// A bubble's icon: what one waits for, is done with, is at.
enum _Mark { wait, done, work }

/// A bubble to draw over the head of the character at [rect].
class _Say {
  _Say(
    this.rect,
    this.mark, {
    this.title,
    this.line,
    this.character,
    this.member = false,
  });

  final Rect rect;
  final _Mark? mark;

  /// Its conversation's title, small over [line]; none for a team member.
  final String? title;
  final String? line;
  final OfficeCharacter? character;
  final bool member;

  /// The top of its head, the middle.
  Offset get head => Offset(rect.center.dx, rect.top + 3);

  /// Who waits on the user first, then who is done, at work, idle.
  int get priority => switch (mark) {
    _Mark.wait => 3,
    _Mark.done => 2,
    _Mark.work => 1,
    null => 0,
  };

  /// Its fill and ink.
  (Color, Color) get colors => switch (mark) {
    _Mark.wait => (const Color(0xffffcc00), const Color(0xff1c1c1e)),
    _Mark.done => (const Color(0xff34c759), const Color(0xffffffff)),
    _Mark.work => (const Color(0xfff5f5f5), const Color(0xff1c1c1e)),
    null => (const Color(0xffd1d1d6), const Color(0xff1c1c1e)),
  };
}
