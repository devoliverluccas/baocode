import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'office_model.dart';
import 'office_sprites.dart';

/// Where each thing of the campus is, in the sprites' pixels (a character
/// is 16×32): what [CampusPainter] draws, and what a tap or hover is
/// looked up in ([agentAt] and the like).
class CampusGeometry {
  CampusGeometry._(this.size, this.buildings, {this.labeled = false});

  factory CampusGeometry.of(OfficeCampus campus) {
    final buildings = <BuildingBox>[];
    var x = gap;
    var height = 0.0;
    for (final building in campus.buildings) {
      final box = _place(building, building.rooms, x, columns: 2);
      buildings.add(box);
      height = math.max(height, box.rect.height);
      x += box.rect.width + gap;
    }
    // On one ground: the lower ones down to the tallest's foot.
    final placed = [
      for (final box in buildings) box._down(height - box.rect.height + gap),
    ];
    return CampusGeometry._(Size(x, height + gap * 2), placed);
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
      _place(building, rooms, gap, columns: columns, slot: labeledSlot),
    );
  }

  /// Level 3: [room] of [building] alone, every character in it.
  factory CampusGeometry.room(OfficeBuilding building, OfficeRoom room) =>
      CampusGeometry._alone(
        _place(
          building,
          [room],
          gap,
          columns: 1,
          slot: labeledSlot,
          perRow: roomPerRow,
          all: true,
        ),
      );

  factory CampusGeometry._alone(BuildingBox box) {
    final placed = box._down(gap);
    return CampusGeometry._(
      Size(placed.rect.right + gap, placed.rect.bottom + gap),
      [placed],
      labeled: true,
    );
  }

  /// [building] at [x], [rooms] in [columns] of rooms [perRow] characters
  /// wide, [slot] apart: [all] its characters (level 3, in rows), or up to
  /// [OfficeRoom.maxVisible] with the dim squares under (level 1).
  static BuildingBox _place(
    OfficeBuilding building,
    List<OfficeRoom> rooms,
    double x, {
    required int columns,
    double slot = OfficeSprites.frameWidth + 2,
    int perRow = OfficeRoom.maxVisible,
    bool all = false,
  }) {
    columns = math.max(1, math.min(columns, rooms.length));
    final rows = (rooms.length / columns).ceil();
    final width = perRow * slot + 6;
    final lines = all
        ? math.max(1, (rooms.single.agents.length / perRow).ceil())
        : 1;
    final labeled = slot == labeledSlot;
    // Titles over the characters: under the project's name.
    final height = roomHeight + (labeled ? 6 : 0) + (lines - 1) * lineHeight;
    final outer = pad * 2 + columns * width + (columns - 1) * roomGap;
    final boxes = [
      for (final (i, room) in rooms.indexed)
        RoomBox._(
          room,
          Rect.fromLTWH(
            x + pad + (i % columns) * (width + roomGap),
            signHeight + pad + (i ~/ columns) * (height + roomGap),
            width,
            height,
          ),
          slot: slot,
          perRow: perRow,
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
  static const roomWidth =
      OfficeRoom.maxVisible * (OfficeSprites.frameWidth + 2) + 6;
  static const roomHeight = OfficeSprites.frameHeight + 14;
  static const roomGap = 4.0, dimHeight = 10.0;

  /// A character's width where it has its title over it, and how many a
  /// row on level 3, each row this high.
  static const labeledSlot = 30.0, roomPerRow = 6;
  static const lineHeight = OfficeSprites.frameHeight + 8;

  /// The whole campus's.
  final Size size;
  final List<BuildingBox> buildings;

  /// The characters have their titles over them (levels 2 and 3).
  final bool labeled;

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
          RoomBox._(
            room.room,
            room.rect.translate(0, dy),
            slot: room.slot,
            perRow: room.perRow,
            all: room.all,
          ),
      ], dim.translate(0, dy));
}

class RoomBox {
  RoomBox._(
    this.room,
    this.rect, {
    required this.slot,
    required this.perRow,
    required this.all,
  }) : agents = [
         // In rows of [perRow], the first on the floor.
         for (final (i, agent) in (all ? room.agents : room.visible).indexed)
           (
             agent,
             Rect.fromLTWH(
               rect.left +
                   3 +
                   (i % perRow) * slot +
                   (slot - OfficeSprites.frameWidth) / 2,
               rect.bottom -
                   OfficeSprites.frameHeight -
                   2 -
                   (i ~/ perRow) * CampusGeometry.lineHeight,
               OfficeSprites.frameWidth,
               OfficeSprites.frameHeight,
             ),
           ),
       ];

  final OfficeRoom room;
  final Rect rect;

  /// Each character's width, how many a row, and whether all of them are
  /// placed (or up to [OfficeRoom.maxVisible]).
  final double slot;
  final int perRow;
  final bool all;

  /// Its characters shown, each where it stands.
  final List<(OfficeAgent, Rect)> agents;
}

/// The colors [CampusPainter] draws with, from the theme.
typedef OfficeColors = ({
  Color text,
  Color muted,
  Color border,
  Color room,
  Color building,
  Color waiting,
});

/// The campus (level 1), at a whole [scale] of [geometry]: the companies'
/// buildings, their rooms with the characters in them, the dim squares.
class CampusPainter extends CustomPainter {
  CampusPainter({
    required this.geometry,
    required this.scale,
    required this.colors,
    this.sprites,
    super.repaint,
  });

  final CampusGeometry geometry;
  final int scale;
  final OfficeColors colors;

  /// Null while they load: boxes stand in for the characters.
  final OfficeSprites? sprites;

  /// A building's own color; grey ([OfficeColors.muted]) without one.
  Color colorOf(OfficeBuilding building) => switch (building.color) {
    final argb? => Color(argb),
    null => colors.muted,
  };

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(scale.toDouble());
    for (final building in geometry.buildings) {
      paintBuilding(canvas, building);
    }
  }

  void paintBuilding(Canvas canvas, BuildingBox box) {
    final color = colorOf(box.building);
    canvas
      ..drawRect(box.rect, Paint()..color = colors.building)
      ..drawRect(box.rect, _stroke(colors.border))
      ..drawRect(box.sign, Paint()..color = color);
    _text(
      canvas,
      box.building.name,
      box.sign.deflate(3),
      size: 7,
      color: color.computeLuminance() > 0.5
          ? const Color(0xff000000)
          : const Color(0xffffffff),
      bold: true,
    );
    for (final room in box.rooms) {
      if (room.room.agents.isEmpty) {
        paintClosed(canvas, room);
        continue;
      }
      paintRoom(canvas, room);
      if (geometry.labeled) {
        for (final (agent, rect) in room.agents) {
          _text(
            canvas,
            agent.title,
            Rect.fromLTWH(
              rect.center.dx - room.slot / 2 + 1,
              rect.top - 5,
              room.slot - 2,
              5,
            ),
            size: 4,
            color: colors.text,
          );
        }
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

  /// A room and who is in it. Where the characters move and animate (see
  /// lib/office/office_characters.dart), that draws them instead.
  void paintRoom(Canvas canvas, RoomBox box) {
    canvas
      ..drawRect(box.rect, Paint()..color = colors.room)
      ..drawRect(box.rect, _stroke(colors.border));
    _text(
      canvas,
      box.room.project.name,
      Rect.fromLTWH(box.rect.left + 3, box.rect.top + 2, box.rect.width - 6, 8),
      size: 6,
      color: colors.text,
    );
    for (final (agent, rect) in box.agents) {
      switch (sprites) {
        case final sprites?:
          sprites.drawCharacter(canvas, agent.sprite, rect);
        case null:
          canvas.drawRect(rect.deflate(3), Paint()..color = colors.muted);
      }
      if (agent.activity == OfficeActivity.waving) {
        _text(canvas, '❗', rect.translate(4, -6), size: 7);
      }
    }
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
      _text(
        canvas,
        '❗',
        Rect.fromLTWH(box.rect.right - 9, box.rect.top + 1, 8, 8),
        size: 6,
      );
    }
  }

  /// The building's projects with nothing in the Ativas: a dim square
  /// each, up to a row's worth, then how many more.
  void paintDim(Canvas canvas, BuildingBox box) {
    // None on levels 2 and 3, where they are rooms.
    if (box.dim.isEmpty) return;
    const side = 6.0, step = side + 2;
    final dim = box.building.dim;
    final fits = ((box.dim.width - 16) / step).floor();
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
  }) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color ?? colors.waiting,
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
      old.colors != colors ||
      old.sprites != sprites;
}
