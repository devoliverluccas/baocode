import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'office_characters.dart';
import 'office_layout.dart';
import 'office_model.dart';
import 'office_sprites.dart';

/// Where each thing of the campus is, in the sprites' pixels (a character
/// is 16×32): what [CampusPainter] draws, and what a tap or hover is
/// looked up in ([agentAt] and the like).
class CampusGeometry {
  CampusGeometry._(this.size, this.buildings);

  factory CampusGeometry.of(OfficeCampus campus) {
    final buildings = <BuildingBox>[];
    var x = gap;
    var height = 0.0;
    for (final building in campus.buildings) {
      final columns = math.max(1, math.min(2, building.rooms.length));
      final rows = (building.rooms.length / columns).ceil();
      final width = pad * 2 + columns * roomWidth + (columns - 1) * roomGap;
      final rooms = [
        for (final (i, room) in building.rooms.indexed)
          RoomBox._(
            room,
            Rect.fromLTWH(
              x + pad + (i % columns) * (roomWidth + roomGap),
              signHeight + pad + (i ~/ columns) * (roomHeight + roomGap),
              roomWidth,
              roomHeight,
            ),
          ),
      ];
      final top = signHeight + pad + rows * (roomHeight + roomGap);
      final box = BuildingBox._(
        building,
        Rect.fromLTWH(x, 0, width, top + dimHeight + pad),
        rooms,
        Rect.fromLTWH(x + pad, top, width - pad * 2, dimHeight),
      );
      buildings.add(box);
      height = math.max(height, box.rect.height);
      x += width + gap;
    }
    // On one ground: the lower ones down to the tallest's foot.
    final placed = [
      for (final box in buildings) box._down(height - box.rect.height + gap),
    ];
    return CampusGeometry._(Size(x, height + gap * 2), placed);
  }

  static const gap = 8.0, pad = 6.0, signHeight = 14.0;
  // A room's scene, its wall a tile over its floor (see OfficeLayout).
  static const roomWidth = OfficeLayout.width;
  static const roomHeight = OfficeLayout.height;
  static const roomGap = 4.0, dimHeight = 10.0;

  /// The whole campus's.
  final Size size;
  final List<BuildingBox> buildings;

  OfficeAgent? agentAt(Offset at) {
    for (final building in buildings) {
      for (final room in building.rooms) {
        for (final (agent, rect) in room.agents) {
          if (rect.contains(at)) return agent;
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
          RoomBox._(room.room, room.rect.translate(0, dy)),
      ], dim.translate(0, dy));
}

class RoomBox {
  RoomBox._(this.room, this.rect)
    : agents = [
        for (final (i, agent) in room.visible.indexed)
          (
            agent,
            Rect.fromLTWH(
              rect.left + 4 + i * (OfficeSprites.frameWidth + 2),
              rect.bottom - OfficeSprites.frameHeight - 2,
              OfficeSprites.frameWidth,
              OfficeSprites.frameHeight,
            ),
          ),
      ];

  final OfficeRoom room;
  final Rect rect;

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
    this.scenes,
    super.repaint,
  });

  final CampusGeometry geometry;
  final int scale;
  final OfficeColors colors;

  /// Null while they load: boxes stand in for the characters.
  final OfficeSprites? sprites;

  /// The rooms' characters on the move; null: each stands still in a row.
  final OfficeScenes? scenes;

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
      paintRoom(canvas, room, badge: color);
    }
    paintDim(canvas, box);
  }

  /// A room and who is in it, their company's [badge] on them: its scene
  /// (lib/office/office_characters.dart) where there is one.
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
        ..save()
        ..clipRect(box.rect);
      scene.paint(
        canvas,
        box.rect.topLeft,
        sprites,
        floor: box.room.project.name.length,
        badge: badge,
        tick: scenes!.tick,
      );
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
      _paintMore(canvas, box);
      return;
    }
    canvas
      ..drawRect(box.rect, Paint()..color = colors.room)
      ..drawRect(box.rect, _stroke(colors.border));
    _text(canvas, box.room.project.name, label, size: 6, color: colors.text);
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
    _paintMore(canvas, box);
  }

  /// The "+N" of those not shown, and a "❗" if one of them waits.
  void _paintMore(Canvas canvas, RoomBox box) {
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
      old.sprites != sprites ||
      old.scenes != scenes;
}
