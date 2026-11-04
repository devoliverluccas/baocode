import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../chat/chat_models.dart' show ChatItem;
import '../l10n/l10n.dart';
import '../workspace/company_dialog.dart' show companyIcons;
import '../workspace/workspace.dart' show Project, ThreadStatus;
import 'office_characters.dart';
import 'office_layout.dart';
import 'office_model.dart';
import 'office_sprites.dart';
import 'office_theme.dart';

/// Where each thing of the campus is, in the sprites' pixels (a character
/// is 16×32): what [CampusPainter] draws, and what a tap or hover is
/// looked up in ([agentAt] and the like).
class CampusGeometry {
  CampusGeometry._(this.size, this.buildings, {this.labeled = false});

  /// Level 1: the buildings side by side from the top left, [perRow] of
  /// them a row (all, when null), each a column of its rooms ([columns]
  /// abreast) from its top down.
  factory CampusGeometry.of(
    OfficeCampus campus, {
    int columns = 2,
    int? perRow,
  }) {
    final buildings = <BuildingBox>[];
    var x = gap, y = gap, bottom = 0.0, right = 0.0;
    for (final (i, building) in campus.buildings.indexed) {
      if (perRow != null && i > 0 && i % perRow == 0) {
        x = gap;
        y = bottom + gap;
      }
      final box = _place(
        building,
        building.rooms,
        x,
        columns: columns,
      )._down(y);
      buildings.add(box);
      bottom = math.max(bottom, box.rect.bottom);
      right = math.max(right, box.rect.right);
      x += box.rect.width + gap;
    }
    return CampusGeometry._(Size(right + gap, bottom + gap), buildings);
  }

  /// Level 2: [building] alone, its rooms with someone in ([columns]
  /// abreast), each character with its title; under them a card of a line
  /// for each of its other projects, [card] logical pixels at [unit] of
  /// them a sprite's pixel, at least [cardColumns] abreast, its
  /// conversations' count from [counts].
  factory CampusGeometry.building(
    OfficeBuilding building, {
    int? columns,
    int cardColumns = 1,
    double unit = 1,
    Map<Project, int> counts = const {},
  }) => CampusGeometry._alone(
    _place(
      building,
      building.rooms,
      gap,
      columns: columns ?? math.min(4, math.sqrt(building.rooms.length).ceil()),
      labeled: true,
      cards: building.dim,
      card: card / unit,
      cardColumns: cardColumns,
      counts: counts,
    ),
  );

  /// A level 2 card's, in logical pixels.
  static const card = Size(200, 30);

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
    List<Project> cards = const [],
    Size card = Size.zero,
    int cardColumns = 1,
    Map<Project, int> counts = const {},
  }) {
    columns = math.max(1, math.min(columns, rooms.length));
    final rows = (rooms.length / columns).ceil();
    final lines = all ? (rooms.single.overflow / perRow).ceil() : 0;
    final height = roomHeight + lines * lineHeight;
    // The cards as wide as the rooms over them, else [cardColumns] of them.
    final inner = rooms.isEmpty && cards.isNotEmpty
        ? 0.0
        : columns * roomWidth + (columns - 1) * roomGap;
    final abreast = cards.isEmpty
        ? 1
        : math.min(
            cards.length,
            math.max(
              cardColumns,
              ((inner + roomGap) / (card.width + roomGap)).floor(),
            ),
          );
    final outer =
        pad * 2 +
        math.max(inner, abreast * card.width + (abreast - 1) * roomGap);
    final top = signHeight + pad + rows * (height + roomGap);
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
      for (final (i, project) in cards.indexed)
        RoomBox._(
          OfficeRoom(project, const []),
          Rect.fromLTWH(
            x + pad + (i % abreast) * (card.width + roomGap),
            top + (i ~/ abreast) * (card.height + roomGap),
            card.width,
            card.height,
          ),
          all: false,
          card: true,
          count: counts[project] ?? 0,
        ),
    ];
    final under =
        top + (cards.length / abreast).ceil() * (card.height + roomGap);
    // The dim squares only on the campus: on level 2 they are cards.
    final dim = labeled ? 0.0 : dimHeight;
    return BuildingBox._(
      building,
      Rect.fromLTWH(x, 0, outer, under + dim + pad),
      boxes,
      Rect.fromLTWH(x + pad, under, outer - pad * 2, dim),
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
          RoomBox._(
            room.room,
            room.rect.translate(0, dy),
            all: room.all,
            card: room.card,
            count: room.count,
          ),
      ], dim.translate(0, dy));
}

class RoomBox {
  RoomBox._(
    this.room,
    this.rect, {
    required this.all,
    this.card = false,
    this.count = 0,
  }) : agents = [
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

  /// A project with no one in (level 2): a card of a line, its door shut,
  /// its name and [count] of conversations.
  final bool card;
  final int count;

  /// Its characters, each where it stands in a row.
  final List<(OfficeAgent, Rect)> agents;

  /// Those its scene has no desk for (level 3): in rows under it, still.
  Iterable<(OfficeAgent, Rect)> get beyond => agents.skip(room.visible.length);
}

/// The largest whole [scale] of the screen's pixels a sprite's pixel takes
/// (pixel art stays crisp at 125% as at 100%), up to [max], at which one of
/// [options] lays [make] out within [space]; at 1 whatever its size, the
/// first. [make] has the logical pixels a sprite's pixel takes: what is a
/// size of the screen's (a level 2 card) is laid out in it.
({CampusGeometry geometry, int scale, T option}) fitGeometry<T>(
  CampusGeometry Function(T option, double unit) make,
  List<T> options,
  Size space, {
  required int max,
  double pixelRatio = 1,
}) {
  for (var scale = max; scale > 1; scale--) {
    final unit = scale / pixelRatio;
    for (final option in options) {
      final geometry = make(option, unit);
      if (geometry.size.width * unit <= space.width &&
          geometry.size.height * unit <= space.height) {
        return (geometry: geometry, scale: scale, option: option);
      }
    }
  }
  return (
    geometry: make(options.first, 1 / pixelRatio),
    scale: 1,
    option: options.first,
  );
}

/// Level 1's rooms abreast a building to fit with, the first liked best.
const campusColumns = [2, 1, 3, 4];

/// Level 1's options ([CampusGeometry.of]'s columns and buildings a row)
/// for [buildings] of them: all in a row first, then rows of fewer.
List<(int, int)> campusOptions(int buildings) => [
  for (var perRow = math.max(1, buildings); perRow >= 1; perRow--)
    for (final columns in campusColumns) (columns, perRow),
];

/// Level 2's: rooms abreast, the most first, then cards at least abreast.
List<(int, int)> buildingColumns(OfficeBuilding building) => [
  for (var rooms = math.min(6, building.rooms.length); rooms >= 1; rooms--)
    for (var cards = 1; cards <= 6; cards++) (rooms, cards),
  if (building.rooms.isEmpty)
    for (var cards = 1; cards <= 6; cards++) (1, cards),
];

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
/// Its words (signs, names, bubbles) at a size of the screen's, whatever
/// the scale, in [font].
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
    this.font = const TextStyle(),
    this.iconsOnly = false,
    super.repaint,
  });

  /// The bubbles their icon alone, words or not (the mini office).
  final bool iconsOnly;

  /// What the bubbles say in; English when null.
  final AppLocalizations? l10n;

  final CampusGeometry geometry;

  /// The screen's pixels a sprite's pixel takes: whole, so pixel art stays
  /// crisp whatever the display's scaling ([pixelRatio]).
  final int scale;
  final double pixelRatio;
  final OfficeColors colors;

  /// The app's text style: its family, the size of each word set here.
  final TextStyle font;

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

  /// Logical pixels a sprite's pixel takes.
  double get unit => scale / pixelRatio;

  /// What is drawn over the pixel art, in logical pixels: the words.
  final _over = <void Function(Canvas)>[];

  /// [rect], of the sprites' pixels, in logical ones.
  Rect _screen(Rect rect) => Rect.fromLTRB(
    rect.left * unit,
    rect.top * unit,
    rect.right * unit,
    rect.bottom * unit,
  );

  /// A room's name strip, over its wall: logical pixels high.
  static const labelHeight = 20.0;

  @override
  void paint(Canvas canvas, Size size) {
    _over.clear();
    canvas
      ..save()
      ..scale(unit)
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
    canvas.restore();
    for (final draw in _over) {
      draw(canvas);
    }
    _over.clear();
    if (highlight case final rect?) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          _screen(rect).inflate(1.5),
          const Radius.circular(3),
        ),
        _stroke(colors.text.withValues(alpha: 0.7), 1.5),
      );
    }
  }

  /// Its facade tinted with its color, under a roof in it that bears its
  /// icon and name, a door at its foot.
  void paintBuilding(Canvas canvas, BuildingBox box) {
    final color = colorOf(box.building);
    final ink = inkOn(color);
    final theme = OfficeTheme.of(box.building.company);
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
        Paint()
          ..color = Color.lerp(
            colors.building,
            color,
            theme == null ? 0.18 : 0.26,
          )!,
      )
      ..drawRect(box.rect, _stroke(colors.border))
      ..drawRect(roof, Paint()..color = color)
      ..drawRect(
        Rect.fromLTRB(roof.left, roof.bottom - 2, roof.right, roof.bottom),
        Paint()..color = _shade(color, 0.3),
      );
    if (theme != null) _paintRoofTop(canvas, box, theme);
    final glyph = OfficeTheme.glyphs[box.building.icon];
    final icon = glyph == null ? companyIcons[box.building.icon] : null;
    // The projects in no company: how many, the way to assign them beside.
    final none = box.building.company == null;
    final count = box.building.rooms.length + box.building.dim.length;
    final sign = _screen(box.sign);
    _over.add((canvas) {
      var left = sign.left + 8;
      if (icon != null) {
        _write(
          canvas,
          String.fromCharCode(icon.codePoint),
          Rect.fromLTRB(left, sign.top, sign.right, sign.bottom - 2),
          size: 13,
          color: ink,
          family: icon.fontFamily,
          package: icon.fontPackage,
        );
        left += 19;
      } else if (glyph != null) {
        // In pixels of 2, as the icon's 14.
        OfficeTheme.glyph(
          canvas,
          glyph,
          Offset(left, ((sign.top + sign.bottom - 2) / 2 - 7).roundToDouble()),
          ink,
          2,
        );
        left += 20;
      }
      _write(
        canvas,
        none ? '${box.building.name} · $count' : box.building.name,
        Rect.fromLTRB(
          left,
          sign.top,
          sign.right - (none ? 64 : 8),
          sign.bottom - 2,
        ),
        size: 12.5,
        color: ink,
        bold: true,
      );
    });
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
      if (room.card) {
        paintCard(room);
      } else {
        paintRoom(
          canvas,
          room,
          badge: color,
          theme: theme,
          company: box.building.name,
        );
      }
    }
    paintDim(canvas, box);
  }

  /// A project with nothing in the Ativas (level 2): a line, its door
  /// shut, its name and how many conversations it has.
  void paintCard(RoomBox box) {
    final rect = _screen(box.rect);
    _over.add((canvas) {
      final card = RRect.fromRectAndRadius(rect, const Radius.circular(4));
      canvas
        ..drawRRect(card, Paint()..color = colors.room)
        ..drawRRect(card, _stroke(colors.border));
      // The door: 8×14, its knob.
      final door = Rect.fromLTWH(
        rect.left + 10,
        (rect.center.dy - 7).roundToDouble(),
        8,
        14,
      );
      canvas
        ..drawRect(door, Paint()..color = colors.border)
        ..drawRect(door, _stroke(colors.muted))
        ..drawRect(
          Rect.fromLTWH(door.right - 3, door.center.dy, 2, 2),
          Paint()..color = colors.muted,
        );
      var right = rect.right - 10;
      if (box.count > 0) {
        final count = _layout('${box.count}', 11.5, colors.muted);
        right -= count.width;
        count
          ..paint(canvas, Offset(right, rect.center.dy - count.height / 2))
          ..dispose();
        // A speech bubble before it, of the pixels' look: 7×6.
        right -= 12;
        final talk = Paint()..color = colors.muted;
        final at = Offset(right, (rect.center.dy - 3).roundToDouble());
        canvas
          ..drawRect(Rect.fromLTWH(at.dx, at.dy, 8, 5), talk)
          ..drawRect(Rect.fromLTWH(at.dx + 1, at.dy + 5, 2, 2), talk);
        right -= 8;
      }
      _write(
        canvas,
        box.room.project.name,
        Rect.fromLTRB(door.right + 10, rect.top, right, rect.bottom),
        size: 12.5,
        color: colors.text,
      );
    });
  }

  /// A room and who is in it, their company's [badge] on them: its scene
  /// (lib/office/office_characters.dart) where there is one, those it has
  /// no desk for (level 3) in rows under it.
  void paintRoom(
    Canvas canvas,
    RoomBox box, {
    Color? badge,
    OfficeTheme? theme,
    String company = '',
  }) {
    _paintLabel(box, theme);
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
        theme: theme,
      );
      // Too small in the mini office, its roof says it.
      if (theme != null && !iconsOnly) _paintBannerName(box, theme, company);
      // Someone at work in it: its lights on, a wash over the scene.
      if (roomColor(box.room) == colors.lit) {
        canvas.drawRect(
          box.rect,
          Paint()..color = colors.lit.withValues(alpha: 0.18),
        );
      }
      canvas
        ..restore()
        ..drawRect(box.rect, _stroke(colors.border));
      final origin = RoomScene.origin(box.rect.topLeft);
      final says = <_Say>[];
      for (final character in scene.characters) {
        character.bubble = null;
        if (character.leaving || character.walking) continue;
        final rect = character.rect.shift(origin);
        if (character.member case final member?) {
          if (character.done > 0) {
            says.add(_Say(rect, _Mark.done, character: character));
          } else if (geometry.labeled && !iconsOnly) {
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
          final at = _screen(rect).topRight + const Offset(-4, 18);
          _over.add(
            (canvas) => _write(
              canvas,
              '+${character.teamOverflow}',
              Rect.fromLTWH(at.dx, at.dy, 24, 14),
              size: 10.5,
              color: const Color(0xffffffff),
              bold: true,
            ),
          );
        }
      }
      _paintStill(canvas, box.beyond, sprites, says);
      _paintSays(says, box.rect, origin);
      _paintMore(box);
      return;
    }
    canvas
      ..drawRect(box.rect, Paint()..color = roomColor(box.room))
      ..drawRect(box.rect, _stroke(colors.border));
    final says = <_Say>[];
    _paintStill(canvas, box.agents, sprites, says);
    _paintSays(says, box.rect, Offset.zero);
    _paintMore(box);
  }

  /// The room's name on its plate over the wall, in its company's color
  /// ([theme]'s accent) or dark.
  void _paintLabel(RoomBox box, OfficeTheme? theme) {
    final rect = _screen(box.rect);
    _over.add((canvas) {
      // Left of its "!" (see _paintMore).
      final room = rect.width - 14 - (box.room.waiting && !box.all ? 46 : 0);
      final name = _layout(
        box.room.project.name,
        12.5,
        const Color(0xffffffff),
        bold: geometry.labeled,
        maxWidth: room - 14,
      );
      final plate = Rect.fromLTWH(
        rect.left,
        rect.top,
        (name.width + 16).ceilToDouble(),
        labelHeight,
      );
      final fill = switch (theme) {
        final theme? => OfficeTheme.shade(theme.accent, 0.62),
        null => const Color(0xd9000000),
      };
      canvas
        ..drawRRect(
          RRect.fromRectAndCorners(
            plate,
            bottomRight: const Radius.circular(4),
          ),
          Paint()..color = fill,
        )
        ..drawRect(
          Rect.fromLTWH(plate.left, plate.bottom - 2, plate.width - 2, 2),
          Paint()..color = theme?.accent ?? const Color(0xff8e8e93),
        );
      name
        ..paint(
          canvas,
          Offset(
            plate.left + 8,
            (plate.center.dy - 1 - name.height / 2).roundToDouble(),
          ),
        )
        ..dispose();
    });
  }

  /// The company's name on its banner on the wall ([OfficeTheme.banner]).
  void _paintBannerName(RoomBox box, OfficeTheme theme, String name) {
    final banner = OfficeTheme.banner(box.rect.topLeft);
    final glyph = OfficeTheme.glyphs[theme.icon] != null;
    final at = _screen(
      Rect.fromLTRB(
        banner.left + (glyph ? 12 : 3),
        banner.top + 1,
        banner.right - 2,
        banner.bottom - 1,
      ),
    );
    _over.add(
      (canvas) => _write(
        canvas,
        name,
        at,
        size: math.min(13, at.height * 0.78),
        color: OfficeTheme.inkOn(theme.accent),
        bold: true,
      ),
    );
  }

  /// Over a themed building's roof, at its left: the night's moon and
  /// stars, the goals' flag, the launch pad's antenna, its light blinking.
  void _paintRoofTop(Canvas canvas, BuildingBox box, OfficeTheme theme) {
    final at = Offset(box.sign.left + 2, box.sign.top - 7);
    final accent = theme.accent;
    switch (theme.decor) {
      case OfficeDecor.night:
        OfficeTheme.glyph(
          canvas,
          OfficeTheme.glyphs['moon']!,
          at + const Offset(3, 0),
          const Color(0xfff6e9a8),
        );
        OfficeTheme.picture(
          canvas,
          const [
            '.w.......w..',
            '.....w......',
            '..........w.',
            '...w........',
          ],
          at + const Offset(12, 1),
          {'w': const Color(0xffffffff)},
        );
      case OfficeDecor.goals:
        OfficeTheme.picture(
          canvas,
          const [
            '.paaaa',
            '.paaa.',
            '.paa..',
            '.p....',
            '.p....',
            'pp....',
            'pp....',
          ],
          at + const Offset(4, 0),
          {'p': const Color(0xffbbbbbb), 'a': accent},
        );
      case OfficeDecor.launch:
        final on = (scenes?.tick ?? 0) % 8 < 4;
        OfficeTheme.picture(
          canvas,
          const ['..r..', '..p..', '..p..', '.ppp.', '.p.p.', 'pp.pp', 'p...p'],
          at + const Offset(4, 0),
          {
            'r': on ? const Color(0xffff3b30) : const Color(0xff5a1a16),
            'p': const Color(0xff9a9aa0),
          },
        );
      case OfficeDecor.plain:
    }
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
  /// does ([activityText]); on the campus what it does alone.
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

  /// A bubble's widest, in logical pixels: on levels 2 and 3, on the
  /// campus.
  static const maxBubble = 220.0, maxShortBubble = 180.0;

  /// A bubble's padding, across and down; its icon's width, and the space
  /// after it.
  static const _padX = 7.0, _padY = 5.0, _iconWidth = 10.0, _iconGap = 6.0;

  /// [says] laid out in logical pixels and drawn over all, kept in
  /// [room]: each over its own head, a tail down to it, the most urgent
  /// first; one that would cover another put a line up, else down to its
  /// icon; who has neither (one idle) left out, its title in its hover.
  /// [origin]: the scene's, for [OfficeCharacter.bubble].
  void _paintSays(List<_Say> says, Rect room, Offset origin) {
    says.sort((a, b) => b.priority.compareTo(a.priority));
    final area = _screen(room);
    final placed = <_Bubble>[];
    bool clear(Rect box) =>
        box.top >= area.top + labelHeight + 2 &&
        !placed.any((p) => p.box.inflate(2).overlaps(box));
    for (final say in says) {
      final head = say.head * unit;
      Rect over(Size size, double up) => Rect.fromLTWH(
        (head.dx - size.width / 2)
            .clamp(
              area.left + 2,
              math.max(area.left + 2, area.right - size.width - 2),
            )
            .roundToDouble(),
        (head.dy - 6 - size.height - up).roundToDouble(),
        size.width,
        size.height,
      );
      final (_, ink, faint) = say.colors(colors);
      final icon = say.mark == null ? 0.0 : _iconWidth + _iconGap;
      final width =
          (geometry.labeled ? maxBubble : maxShortBubble) - _padX * 2 - icon;
      TextPainter? title, line;
      if (geometry.labeled && !iconsOnly && !say.member && say.title != null) {
        title = _layout(say.title!, 11, faint, maxWidth: width);
      }
      if (say.line != null && !iconsOnly) {
        line = _layout(say.line!, 12.5, ink, bold: true, maxWidth: width);
      }
      Rect? box;
      if (title != null || line != null) {
        final size = Size(
          (icon + math.max(title?.width ?? 0, line?.width ?? 0) + _padX * 2)
              .ceilToDouble(),
          ((title?.height ?? 0) + (line?.height ?? 0) + _padY * 2)
              .ceilToDouble(),
        );
        for (final up in [0.0, size.height + 4, size.height * 2 + 8]) {
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
        const only = Size(_iconWidth + 12, 20);
        box = [
          for (final up in [0.0, 24.0, 48.0]) over(only, up),
        ].firstWhere(clear, orElse: () => over(only, 0));
      }
      placed.add((box: box, say: say, head: head, title: title, line: line));
      say.character?.bubble = Rect.fromLTRB(
        box.left / unit,
        box.top / unit,
        box.right / unit,
        box.bottom / unit,
      ).shift(-origin);
    }
    // The least urgent first: the most on top.
    _over.add((canvas) {
      for (final bubble in placed.reversed) {
        _paintBubble(canvas, bubble);
      }
    });
  }

  void _paintBubble(Canvas canvas, _Bubble bubble) {
    final _Bubble(:box, :say, :head, :title, :line) = bubble;
    final (fill, ink, _) = say.colors(colors);
    final edge = say.mark == _Mark.work || say.mark == null
        ? colors.border
        : _shade(fill, 0.3);
    // A tail from its bottom to the head; a line on from it if put up.
    final tip = Offset(
      head.dx.clamp(box.left + 3, box.right - 3),
      math.min(head.dy - 1, box.bottom + 5),
    );
    final root = tip.dx.clamp(box.left + 8, box.right - 8);
    final shape = Path.combine(
      PathOperation.union,
      Path()..addRRect(RRect.fromRectAndRadius(box, const Radius.circular(4))),
      Path()
        ..moveTo(root - 5, box.bottom - 1)
        ..lineTo(root + 5, box.bottom - 1)
        ..lineTo(tip.dx, tip.dy)
        ..close(),
    );
    canvas
      ..drawPath(
        shape.shift(const Offset(0, 1.5)),
        Paint()
          ..color = const Color(0x66000000)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.5),
      )
      ..drawPath(shape, Paint()..color = fill)
      ..drawPath(shape, _stroke(edge));
    if (head.dy - 1 > tip.dy + 1) {
      canvas.drawLine(tip, Offset(tip.dx, head.dy - 1), _stroke(edge, 1.5));
    }
    var x = box.left + _padX;
    if (say.mark case final mark?) {
      if (title == null && line == null) {
        _icon(canvas, mark, box.center.translate(-_iconWidth / 2, 0), ink);
        return;
      }
      // By the line it goes with: what it does.
      final y = line == null
          ? box.center.dy
          : box.bottom - _padY - line.height / 2;
      _icon(canvas, mark, Offset(x, y), ink);
      x += _iconWidth + _iconGap;
    }
    var y = box.top + _padY;
    if (title != null) {
      title.paint(canvas, Offset(x, y));
      y += title.height;
      title.dispose();
    }
    line
      ?..paint(canvas, Offset(x, y))
      ..dispose();
  }

  /// A bubble's icon, its left middle at [at], [_iconWidth] wide in
  /// pixels of 2: the "!" of one waiting, the ✓ of one done, three dots
  /// at work, one up and down in turn.
  void _icon(Canvas canvas, _Mark mark, Offset at, Color ink, [double px = 2]) {
    final paint = Paint()..color = ink;
    final rows = switch (mark) {
      _Mark.wait => const ['..x..', '..x..', '..x..', '.....', '..x..'],
      _Mark.done => const ['....x', '...x.', 'x.x..', '.x...'],
      _Mark.work => switch ((scenes?.tick ?? 0) ~/ 2 % 3) {
        0 => const ['x....', '..x.x'],
        1 => const ['..x..', 'x...x'],
        _ => const ['....x', 'x.x..'],
      },
    };
    final top = (at.dy - rows.length * px / 2).roundToDouble();
    for (final (y, row) in rows.indexed) {
      for (var x = 0; x < row.length; x++) {
        if (row[x] == 'x') {
          canvas.drawRect(
            Rect.fromLTWH(at.dx + x * px, top + y * px, px, px),
            paint,
          );
        }
      }
    }
  }

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
  void _paintMore(RoomBox box) {
    // Level 3 shows them all.
    if (box.all) return;
    final rect = _screen(box.rect);
    _over.add((canvas) {
      if (box.room.overflow > 0) {
        _write(
          canvas,
          '+${box.room.overflow}',
          Rect.fromLTWH(rect.right - 34, rect.bottom - 20, 30, 16),
          size: 11.5,
          color: const Color(0xffffffff),
          bold: true,
          right: true,
        );
      }
      // Someone waiting among those not shown: the room says so.
      if (box.room.waiting &&
          !box.room.visible.any((a) => a.activity == OfficeActivity.waving)) {
        final at = Rect.fromLTWH(rect.right - 44, rect.top + 2, 18, 16);
        canvas.drawRRect(
          RRect.fromRectAndRadius(at, const Radius.circular(3)),
          Paint()..color = const Color(0xffffcc00),
        );
        _icon(
          canvas,
          _Mark.wait,
          at.centerLeft + const Offset(4, 0),
          const Color(0xff1c1c1e),
        );
      }
    });
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
    // None on levels 2 and 3, where they are cards.
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
      final at = _screen(
        Rect.fromLTWH(box.dim.left + shown * step, box.dim.top, 16, 10),
      );
      _over.add(
        (canvas) => _write(
          canvas,
          '+${dim.length - shown}',
          Rect.fromLTWH(at.left, at.top, 40, at.height),
          size: 11,
          color: colors.muted,
        ),
      );
    }
  }

  /// What reads on [color]: black or white.
  static Color inkOn(Color color) => color.computeLuminance() > 0.5
      ? const Color(0xff000000)
      : const Color(0xffffffff);

  static Color _shade(Color color, double by) =>
      Color.lerp(color, const Color(0xff000000), by)!;

  static Paint _stroke(Color color, [double width = 1]) => Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = width;

  /// [text] at [size] logical pixels, a line, cut to [maxWidth].
  TextPainter _layout(
    String text,
    double size,
    Color color, {
    bool bold = false,
    double maxWidth = double.infinity,
    String? family,
    String? package,
  }) => TextPainter(
    text: TextSpan(
      text: text,
      style: font.copyWith(
        color: color,
        fontFamily: family ?? font.fontFamily,
        fontFamilyFallback: family == null ? font.fontFamilyFallback : null,
        package: package,
        fontSize: size,
        fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
        height: 1.25,
        decoration: TextDecoration.none,
      ),
    ),
    maxLines: 1,
    ellipsis: '…',
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: math.max(0, maxWidth));

  /// [text] in [within], in the middle of it down, from its left (or
  /// [right]).
  void _write(
    Canvas canvas,
    String text,
    Rect within, {
    required double size,
    required Color color,
    bool bold = false,
    bool right = false,
    String? family,
    String? package,
  }) {
    final painter = _layout(
      text,
      size,
      color,
      bold: bold,
      maxWidth: within.width,
      family: family,
      package: package,
    );
    painter
      ..paint(
        canvas,
        Offset(
          right ? within.right - painter.width : within.left,
          (within.center.dy - painter.height / 2).roundToDouble(),
        ),
      )
      ..dispose();
  }

  @override
  bool shouldRepaint(CampusPainter old) =>
      old.geometry != geometry ||
      old.scale != scale ||
      old.pixelRatio != pixelRatio ||
      old.colors != colors ||
      old.font != font ||
      old.sprites != sprites ||
      old.scenes != scenes ||
      old.highlight != highlight ||
      old.l10n != l10n;
}

/// A bubble's icon: what one waits for, is done with, is at.
enum _Mark { wait, done, work }

/// A bubble laid out: where, in logical pixels, over [head], its lines.
typedef _Bubble = ({
  Rect box,
  _Say say,
  Offset head,
  TextPainter? title,
  TextPainter? line,
});

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

  /// Its fill, ink and fainter ink: at work (or idle) the theme's, waiting
  /// yellow, done green.
  (Color, Color, Color) colors(OfficeColors theme) => switch (mark) {
    _Mark.wait => (
      const Color(0xffffcc00),
      const Color(0xff1c1c1e),
      const Color(0xa61c1c1e),
    ),
    _Mark.done => (
      const Color(0xff34c759),
      const Color(0xff0b2512),
      const Color(0xb30b2512),
    ),
    _ => (theme.building, theme.text, theme.muted),
  };
}
