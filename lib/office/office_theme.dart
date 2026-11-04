import 'package:flutter/painting.dart';

import '../workspace/companies.dart';

/// What a company's rooms are dressed in, by its icon: the moon's night
/// sky, the briefcase's goals, the rocket's launch pad; [plain] for any
/// other, a poster of its color.
enum OfficeDecor { night, goals, launch, plain }

/// A company's look in the office, from its color and its icon alone, so
/// a new one has its own at once: the floor's tiles and tint, the wall's,
/// the rug's color, the accent of its signs and lamps, and its decor.
class OfficeTheme {
  const OfficeTheme._({
    required this.decor,
    required this.accent,
    required this.floor,
    required this.floorTint,
    required this.wallTint,
    required this.carpet,
    this.icon,
  });

  /// Null for no company: the rooms as they were, neutral.
  static OfficeTheme? of(Company? company) {
    if (company == null) return null;
    final accent = Color(company.color ?? 0xff8e8e93);
    final decor = _decors[company.icon] ?? OfficeDecor.plain;
    final look = _looks[decor]!;
    final hsl = HSLColor.fromColor(accent);
    Color tone(double saturation, double lightness, [double turn = 0]) =>
        HSLColor.fromAHSL(
          1,
          (hsl.hue + turn) % 360,
          (hsl.saturation * saturation).clamp(0, 1),
          lightness,
        ).toColor();
    return OfficeTheme._(
      decor: decor,
      accent: accent,
      floor: look.floor,
      floorTint: tone(look.floorS, look.floorL, look.floorTurn),
      wallTint: tone(look.wallS, look.wallL),
      carpet: tone(0.85, look.carpetL),
      icon: company.icon,
    );
  }

  /// Which decor an icon (see `companyIcons`) brings.
  static const _decors = {
    'moon': OfficeDecor.night,
    'star': OfficeDecor.night,
    'work': OfficeDecor.goals,
    'business': OfficeDecor.goals,
    'store': OfficeDecor.goals,
    'rocket': OfficeDecor.launch,
    'bolt': OfficeDecor.launch,
  };

  /// Each decor's floor tiles (assets/office/floors) and how saturated
  /// and light its floor, wall and rug are, in the company's hue.
  static const _looks = {
    OfficeDecor.night: (
      floor: 4,
      floorTurn: 0.0,
      floorS: 0.45,
      floorL: 0.52,
      wallS: 0.45,
      wallL: 0.78,
      carpetL: 0.36,
    ),
    OfficeDecor.goals: (
      floor: 6,
      floorTurn: -14.0,
      floorS: 0.65,
      floorL: 0.80,
      wallS: 0.75,
      wallL: 0.86,
      carpetL: 0.50,
    ),
    OfficeDecor.launch: (
      floor: 3,
      floorTurn: 0.0,
      floorS: 0.10,
      floorL: 0.44,
      wallS: 0.20,
      wallL: 0.30,
      carpetL: 0.34,
    ),
    OfficeDecor.plain: (
      floor: 1,
      floorTurn: 0.0,
      floorS: 0.30,
      floorL: 0.68,
      wallS: 0.35,
      wallL: 0.84,
      carpetL: 0.45,
    ),
  };

  final OfficeDecor decor;

  /// The company's own color: its banner, plaques, lamps.
  final Color accent;
  final int floor;
  final Color floorTint, wallTint, carpet;

  /// Its icon's name, for [glyphs].
  final String? icon;

  /// The company's banner on a room's back wall, in a room at [topLeft]
  /// (its [RoomBox] rect's): over the wall between the bookshelf and the
  /// poster, its icon at the left, its name (written by the painter) after.
  static Rect banner(Offset topLeft) =>
      Rect.fromLTWH(topLeft.dx + 34, topLeft.dy + 11, 60, 13);

  /// The plaque on a room's door, in a room at [topLeft]: its project's
  /// icon on it.
  static Rect plaque(Offset topLeft) =>
      Rect.fromLTWH(topLeft.dx + 7 * 16 + 3, topLeft.dy + 12, 10, 8);

  /// Icons drawn in pixels, 7×7: the company's on its banner and roof.
  static const glyphs = {
    'moon': [
      '..xxx..',
      '.xxx...',
      'xxx....',
      'xxx....',
      'xxx....',
      '.xxx...',
      '..xxx..',
    ],
    'work': [
      '..xxx..',
      '..x.x..',
      'xxxxxxx',
      'xxxxxxx',
      'x.....x',
      'xxxxxxx',
      'xxxxxxx',
    ],
    'business': [
      'xxxx...',
      'x.x.xxx',
      'xxxxx.x',
      'x.x.xxx',
      'xxxxx.x',
      'x.x.xxx',
      'xxxxxxx',
    ],
    'rocket': [
      '...x...',
      '..xxx..',
      '..x.x..',
      '..xxx..',
      '.xxxxx.',
      'x.xxx.x',
      '..x.x..',
    ],
    'star': [
      '...x...',
      '...x...',
      'xxxxxxx',
      '.xxxxx.',
      '..xxx..',
      '.xx.xx.',
      '.x...x.',
    ],
    'bolt': [
      '....xx.',
      '...xx..',
      '..xx...',
      '.xxxxx.',
      '...xx..',
      '..xx...',
      '.xx....',
    ],
    'heart': [
      '.......',
      '.xx.xx.',
      'xxxxxxx',
      'xxxxxxx',
      '.xxxxx.',
      '..xxx..',
      '...x...',
    ],
  };

  /// Draws [rows] of [glyphs] (or any of their kind) at [at], in [color],
  /// [px] a pixel of theirs.
  static void glyph(
    Canvas canvas,
    List<String> rows,
    Offset at,
    Color color, [
    double px = 1,
  ]) {
    final paint = Paint()..color = color;
    for (final (y, row) in rows.indexed) {
      for (var x = 0; x < row.length; x++) {
        if (row[x] == 'x') {
          canvas.drawRect(
            Rect.fromLTWH(at.dx + x * px, at.dy + y * px, px, px),
            paint,
          );
        }
      }
    }
  }

  /// Draws [rows] of pixels at [at], each letter a color of [palette], a
  /// '.' none.
  static void picture(
    Canvas canvas,
    List<String> rows,
    Offset at,
    Map<String, Color> palette,
  ) {
    for (final (y, row) in rows.indexed) {
      for (var x = 0; x < row.length; x++) {
        if (palette[row[x]] case final color?) {
          canvas.drawRect(
            Rect.fromLTWH(at.dx + x, at.dy + y, 1, 1),
            Paint()..color = color,
          );
        }
      }
    }
  }

  static Color shade(Color color, double by) =>
      Color.lerp(color, const Color(0xff000000), by)!;
  static Color tint(Color color, double by) =>
      Color.lerp(color, const Color(0xffffffff), by)!;

  /// What reads on [color]: black or white.
  static Color inkOn(Color color) => color.computeLuminance() > 0.5
      ? const Color(0xff000000)
      : const Color(0xffffffff);

  /// The rug down the middle of a room whose floor's row 0 is at [floor]
  /// (see RoomScene.origin), under the desks' row 5: its border, and
  /// the decor's pattern on it.
  void paintRug(Canvas canvas, Offset floor) {
    final rug = Rect.fromLTWH(floor.dx + 1, floor.dy + 5 * 16 + 2, 110, 12);
    canvas
      ..drawRect(rug, Paint()..color = shade(carpet, 0.35))
      ..drawRect(rug.deflate(1), Paint()..color = carpet)
      ..drawRect(
        rug.deflate(2),
        Paint()
          ..color = tint(carpet, 0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
    final mark = Paint()..color = tint(carpet, 0.45);
    for (var x = rug.left + 8; x < rug.right - 6; x += 12) {
      final y = rug.center.dy - 1;
      switch (decor) {
        case OfficeDecor.night:
          // A little star.
          canvas
            ..drawRect(Rect.fromLTWH(x, y - 1, 1, 3), mark)
            ..drawRect(Rect.fromLTWH(x - 1, y, 3, 1), mark);
        case OfficeDecor.goals:
          // Arrows up.
          canvas
            ..drawRect(Rect.fromLTWH(x, y - 1, 1, 1), mark)
            ..drawRect(Rect.fromLTWH(x - 1, y, 3, 1), mark)
            ..drawRect(Rect.fromLTWH(x, y + 1, 1, 2), mark);
        case OfficeDecor.launch:
          // Hazard stripes.
          canvas.drawRect(Rect.fromLTWH(x, y - 1, 4, 3), mark);
        case OfficeDecor.plain:
          canvas.drawRect(Rect.fromLTWH(x, y, 2, 2), mark);
      }
    }
  }

  /// Its pictures on a room's back wall, the room at [topLeft]: the
  /// company's banner (its name the painter's) between the bookshelf and
  /// the poster; the decor's poster by the door, and its piece beyond it.
  /// [tick] blinks what blinks.
  void paintWall(Canvas canvas, Offset topLeft, int tick) {
    // The banner, hung by two cords.
    final banner = OfficeTheme.banner(topLeft);
    final cord = Paint()..color = shade(accent, 0.55);
    canvas
      ..drawRect(Rect.fromLTWH(banner.left + 6, banner.top - 3, 1, 3), cord)
      ..drawRect(Rect.fromLTWH(banner.right - 7, banner.top - 3, 1, 3), cord)
      ..drawRect(banner, Paint()..color = shade(accent, 0.45))
      ..drawRect(banner.deflate(1), Paint()..color = accent)
      ..drawRect(
        Rect.fromLTWH(banner.left + 1, banner.top + 1, banner.width - 2, 1),
        Paint()..color = tint(accent, 0.35),
      );
    if (glyphs[icon] case final rows?) {
      glyph(
        canvas,
        rows,
        Offset(banner.left + 3, banner.top + 3),
        inkOn(accent),
      );
    }
    final poster = Offset(topLeft.dx + 97, topLeft.dy + 10);
    final beyond = Offset(topLeft.dx + 128, topLeft.dy + 8);
    switch (decor) {
      case OfficeDecor.night:
        _moonPoster(canvas, poster);
        _lamp(canvas, beyond, tick);
      case OfficeDecor.goals:
        _chartBoard(canvas, poster);
        _trophy(canvas, beyond);
      case OfficeDecor.launch:
        _rocketPoster(canvas, poster);
        _neon(canvas, beyond, tick);
      case OfficeDecor.plain:
        _colorPoster(canvas, poster);
        _shelfPlant(canvas, beyond);
    }
  }

  void _moonPoster(Canvas canvas, Offset at) => picture(
    canvas,
    const [
      'ffffffffffffff',
      'fnnnnnnnnnnwnf',
      'fnwnnnnnnnnnnf',
      'fnnnnyyyynnnnf',
      'fnnnyyyynnnnnf',
      'fnnyyyynnnnwnf',
      'fnnyyynnnnnnnf',
      'fnnyyynnnnnnnf',
      'fnnyyyynnnnnnf',
      'fnwnyyyynnnnnf',
      'fnnnnyyyynnwnf',
      'fnnnnnnnnnnnnf',
      'fnnnwnnnnwnnnf',
      'ffffffffffffff',
    ],
    at,
    {
      'f': shade(accent, 0.55),
      'n': const Color(0xff1b1840),
      'y': const Color(0xfff6e9a8),
      'w': const Color(0xffffffff),
    },
  );

  /// A lamp on the wall in the company's color, its light down the wall.
  void _lamp(Canvas canvas, Offset at, int tick) {
    final light = Path()
      ..moveTo(at.dx + 4, at.dy + 9)
      ..lineTo(at.dx + 11, at.dy + 9)
      ..lineTo(at.dx + 15, at.dy + 22)
      ..lineTo(at.dx, at.dy + 22)
      ..close();
    canvas
      ..drawPath(
        light,
        Paint()
          ..color = tint(accent, 0.5).withValues(alpha: 0.35)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5),
      )
      ..drawCircle(
        at + const Offset(7.5, 8),
        6,
        Paint()
          ..color = accent.withValues(alpha: 0.45)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
      );
    picture(
      canvas,
      const [
        '.....mm.......',
        '.....m........',
        '....aaaaa.....',
        '...aaaaaaa....',
        '..aaaaaaaaa...',
        '.aaaaaaaaaaa..',
        '....lllll.....',
      ],
      at + const Offset(1, 2),
      {'a': accent, 'l': const Color(0xfffff8e1), 'm': const Color(0xff3a3550)},
    );
  }

  /// A board of bars going up, an arrow over them: the goals.
  void _chartBoard(Canvas canvas, Offset at) {
    final board = Rect.fromLTWH(at.dx, at.dy, 14, 14);
    canvas
      ..drawRect(board, Paint()..color = const Color(0xff6b6b6b))
      ..drawRect(board.deflate(1), Paint()..color = const Color(0xfff7f7f2));
    final bar = Paint()..color = shade(accent, 0.1);
    for (final (i, h) in const [3.0, 5.0, 7.0, 9.0].indexed) {
      canvas.drawRect(
        Rect.fromLTWH(at.dx + 2 + i * 3, at.dy + 12 - h, 2, h),
        bar,
      );
    }
    glyph(
      canvas,
      const ['....xxx', '.....xx', '....x.x', '.x.x...', 'x.x....'],
      Offset(at.dx + 4, at.dy + 1),
      const Color(0xff2e9e4f),
    );
  }

  /// A gold cup on a little shelf.
  void _trophy(Canvas canvas, Offset at) => picture(
    canvas,
    const [
      '...gggggggg...',
      '.gggghhggggg..',
      'g.gghhgggggg.g',
      'g.ggggggggg..g',
      '.g.ggggggg..g.',
      '..g.gggggg.g..',
      '.....gggg.....',
      '......gg......',
      '......gg......',
      '....dddddd....',
      '...dddddddd...',
      'ssssssssssssss',
      '.s..........s.',
    ],
    at + const Offset(1, 1),
    {
      'g': const Color(0xffe8b923),
      'h': const Color(0xfffff1a8),
      'd': const Color(0xff8a5a1e),
      's': const Color(0xff6b4a2e),
    },
  );

  void _rocketPoster(Canvas canvas, Offset at) => picture(
    canvas,
    const [
      'ffffffffffffff',
      'fkkkkkkwkkkkkf',
      'fkkkkkwwkkkkkf',
      'fkwkkwwwwkkkkf',
      'fkkkkwbbwkkkkf',
      'fkkkkwbbwkkwkf',
      'fkkkkwwwwkkkkf',
      'fkkkrwwwwrkkkf',
      'fkkrrwwwwrrkkf',
      'fkkrkkookkrkkf',
      'fkkkkooookkkkf',
      'fkwkkkookkkkkf',
      'fkkkkkkkkkkkkf',
      'ffffffffffffff',
    ],
    at,
    {
      'f': shade(accent, 0.35),
      'k': const Color(0xff15151c),
      'w': const Color(0xffeeeeee),
      'b': const Color(0xff4fc3f7),
      'r': accent,
      'o': const Color(0xffff9f1c),
    },
  );

  /// A bolt in neon of the company's color, blinking now and then.
  void _neon(Canvas canvas, Offset at, int tick) {
    final on = tick % 23 != 0;
    final bolt = [
      '.......nnn..',
      '......nnn...',
      '.....nnn....',
      '....nnn.....',
      '...nnnnnnn..',
      '......nnn...',
      '.....nnn....',
      '....nnn.....',
      '...nn.......',
      '..n.........',
    ];
    if (on) {
      canvas.drawCircle(
        at + const Offset(7, 8),
        8,
        Paint()
          ..color = accent.withValues(alpha: 0.6)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
      );
    }
    picture(canvas, bolt, at + const Offset(2, 3), {
      'n': on ? tint(accent, 0.3) : shade(accent, 0.4),
    });
  }

  /// A poster of the company's color, its icon on it.
  void _colorPoster(Canvas canvas, Offset at) {
    final poster = Rect.fromLTWH(at.dx, at.dy, 14, 14);
    canvas
      ..drawRect(poster, Paint()..color = shade(accent, 0.5))
      ..drawRect(poster.deflate(1), Paint()..color = accent);
    glyph(
      canvas,
      glyphs[icon] ??
          const [
            '...x...',
            '..xxx..',
            '.xxxxx.',
            'xxxxxxx',
            '.xxxxx.',
            '..xxx..',
            '...x...',
          ],
      at + const Offset(3.5, 3.5),
      inkOn(accent),
    );
  }

  /// A pot on a shelf, its leaves down over it.
  void _shelfPlant(Canvas canvas, Offset at) => picture(
    canvas,
    const [
      '....g..g......',
      '..gggggggg....',
      '.gg.gggg.gg...',
      'g...gggg...g..',
      '....pppp......',
      '....pppp......',
      'ssssssssssss..',
      '.g........g...',
      '.g............',
    ],
    at + const Offset(1, 4),
    {
      'g': const Color(0xff4caf50),
      'p': shade(accent, 0.2),
      's': const Color(0xff6b4a2e),
    },
  );
}
