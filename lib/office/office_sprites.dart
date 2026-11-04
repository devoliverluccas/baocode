import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'office_model.dart';

/// Where a character faces; its sheet has no left row, the right one is
/// mirrored.
enum OfficeFacing { down, up, right, left }

/// The office's pictures (assets/office, from Pixel Agents: see its
/// CREDITS.md), read once for the app.
class OfficeSprites {
  OfficeSprites._(this.characters, this.floors, this.wall, this.furniture);

  /// A character sheet's frame, in its pixels.
  static const frameWidth = 16.0, frameHeight = 32.0;

  /// Frames of a sheet's row: walking (0–2), typing (3–4), reading (5–6).
  static const frames = 7;

  /// The sheets, by [OfficeAgent.kernel] then [OfficeAgent.sprite]: their
  /// shirts in the kernel's color ([shirt]).
  final Map<OfficeKernel, List<ui.Image>> characters;

  /// Grey tiles of 16, tinted as they are drawn.
  final List<ui.Image> floors;

  /// The wall's 16 pieces of 16×32, 4 a row, by which neighbours are wall
  /// too: north 1, east 2, south 4, west 8.
  final ui.Image wall;

  /// By their path in assets/office/furniture, less ".png":
  /// "DESK/DESK_FRONT".
  final Map<String, ui.Image> furniture;

  static const _furniture = [
    'CLOCK/CLOCK',
    'COFFEE/COFFEE',
    'COFFEE_TABLE/COFFEE_TABLE',
    'DESK/DESK_FRONT',
    'DOUBLE_BOOKSHELF/DOUBLE_BOOKSHELF',
    'PC/PC_FRONT_OFF',
    'PC/PC_FRONT_ON_1',
    'PC/PC_FRONT_ON_2',
    'PC/PC_FRONT_ON_3',
    'PLANT/PLANT',
    'SMALL_PAINTING/SMALL_PAINTING',
    'SOFA/SOFA_FRONT',
    'WHITEBOARD/WHITEBOARD',
    'WOODEN_CHAIR/WOODEN_CHAIR_BACK',
  ];

  static Future<OfficeSprites>? _loading;
  static Future<OfficeSprites> load() => _loading ??= _load();

  static Future<OfficeSprites> _load() async {
    final sheets = [
      for (var i = 0; i < OfficeAgent.sprites; i++)
        await image('assets/office/characters/char_$i.png'),
    ];
    return OfficeSprites._(
      {
        for (final kernel in OfficeKernel.values)
          kernel: [for (final sheet in sheets) await shirted(sheet, kernel)],
      },
      [
        for (var i = 0; i < 9; i++)
          await image('assets/office/floors/floor_$i.png'),
      ],
      await image('assets/office/walls/wall_0.png'),
      {
        for (final name in _furniture)
          name: await image('assets/office/furniture/$name.png'),
      },
    );
  }

  /// [sheet] with its shirts in [kernel]'s color ([shirt]).
  static Future<ui.Image> shirted(ui.Image sheet, OfficeKernel kernel) async {
    final data = await sheet.toByteData();
    final pixels = Uint8List.fromList(data!.buffer.asUint8List());
    shirt(pixels, sheet.width, kernel);
    final buffer = await ui.ImmutableBuffer.fromUint8List(pixels);
    final descriptor = ui.ImageDescriptor.raw(
      buffer,
      width: sheet.width,
      height: sheet.height,
      pixelFormat: ui.PixelFormat.rgba8888,
    );
    final codec = await descriptor.instantiateCodec();
    return (await codec.getNextFrame()).image;
  }

  /// The shirt colors, by kernel, as HSL: Claude's orange, Codex's near
  /// black, the others' grey.
  static const _shirts = {
    OfficeKernel.claude: (15.0, 0.65, 0.56),
    OfficeKernel.codex: (230.0, 0.10, 0.17),
    OfficeKernel.other: (0.0, 0.0, 0.55),
  };

  /// Turns the shirts of a sheet's [rgba] pixels, [width] wide, to
  /// [kernel]'s color, their shading kept: in each frame's rows 17 to 27
  /// (the chest, arms out), what is not skin (a color of its face: rows 13
  /// to 17 of its standing frame), not near black (outlines) nor white.
  // ponytail: a heuristic for these 6 sheets; a sheet of its own shirt
  // mask if new ones get it wrong.
  static void shirt(Uint8List rgba, int width, OfficeKernel kernel) {
    int at(int x, int y) => (y * width + x) * 4;
    int color(int i) => rgba[i] << 16 | rgba[i + 1] << 8 | rgba[i + 2];
    final skin = <int>{
      for (var y = 13; y < 18; y++)
        for (var x = 0; x < frameWidth; x++)
          if (rgba[at(16 + x, y) + 3] != 0) color(at(16 + x, y)),
    };
    final height = rgba.length ~/ 4 ~/ width;
    final shirt = <int>[];
    for (var y = 0; y < height; y++) {
      if (y % frameHeight < 17 || y % frameHeight > 27) continue;
      for (var x = 0; x < width; x++) {
        final i = at(x, y);
        if (rgba[i + 3] == 0 || skin.contains(color(i))) continue;
        final l = _hsl(i, rgba).lightness;
        if (l > 0.08 && l < 0.97) shirt.add(i);
      }
    }
    if (shirt.isEmpty) return;
    final mean =
        shirt.map((i) => _hsl(i, rgba).lightness).reduce((a, b) => a + b) /
        shirt.length;
    final (h, s, l) = _shirts[kernel]!;
    final shades = [
      for (final i in shirt)
        (l + (_hsl(i, rgba).lightness - mean) * 0.5).clamp(
          math.max(0.03, l - 0.2),
          l + 0.1,
        ),
    ];
    for (final (n, i) in shirt.indexed) {
      final turned = HSLColor.fromAHSL(1, h, s, shades[n].toDouble()).toColor();
      rgba
        ..[i] = (turned.r * 255).round()
        ..[i + 1] = (turned.g * 255).round()
        ..[i + 2] = (turned.b * 255).round();
    }
  }

  static HSLColor _hsl(int i, Uint8List rgba) => HSLColor.fromColor(
    Color.fromARGB(255, rgba[i], rgba[i + 1], rgba[i + 2]),
  );

  static Future<ui.Image> image(String asset) async {
    final data = await rootBundle.load(asset);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    return (await codec.getNextFrame()).image;
  }

  static Paint _crisp([Color? tint]) => Paint()
    ..filterQuality = FilterQuality.none
    ..colorFilter = tint == null
        ? null
        : ColorFilter.mode(tint, BlendMode.modulate);

  /// Colors turned [degrees] round the wheel, their lightness kept: Pixel
  /// Agents' hueShift, for characters of one sheet told apart.
  static ColorFilter hueTurn(double degrees) {
    final a = degrees * math.pi / 180;
    final (c, s) = (math.cos(a), math.sin(a));
    return ColorFilter.matrix([
      0.213 + c * 0.787 - s * 0.213,
      0.715 - c * 0.715 - s * 0.715,
      0.072 - c * 0.072 + s * 0.928,
      0, 0, //
      0.213 - c * 0.213 + s * 0.143,
      0.715 + c * 0.285 + s * 0.140,
      0.072 - c * 0.072 - s * 0.283,
      0, 0, //
      0.213 - c * 0.213 - s * 0.787,
      0.715 - c * 0.715 + s * 0.715,
      0.072 + c * 0.928 + s * 0.072,
      0, 0, //
      0, 0, 0, 1, 0,
    ]);
  }

  /// Draws [image] whole, pixel for pixel, its top left at [at]; multiplied
  /// by [tint] if any (the grey floor and wall).
  void draw(Canvas canvas, ui.Image image, Offset at, {Color? tint}) =>
      canvas.drawImage(image, at, _crisp(tint));

  /// Draws the wall's piece for [mask] (see [wall]), its top left at [at].
  void drawWall(Canvas canvas, int mask, Offset at, {Color? tint}) =>
      canvas.drawImageRect(
        wall,
        Rect.fromLTWH(mask % 4 * 16, mask ~/ 4 * 32, 16, 32),
        Rect.fromLTWH(at.dx, at.dy, 16, 32),
        _crisp(tint),
      );

  /// Draws [sprite]'s [frame] facing [facing] into [to] (a frame's size at
  /// a whole scale, so its pixels stay square and crisp), in [kernel]'s
  /// shirt, its hair turned by [hue] degrees ([hueTurn]); a [badge] of its
  /// company's color on its chest, or on its back. [appear] under 1: coming
  /// in by Pixel Agents' matrix effect, so far; [vanish] over 0: going.
  void drawCharacter(
    Canvas canvas,
    int sprite,
    Rect to, {
    int frame = 0,
    OfficeFacing facing = OfficeFacing.down,
    double hue = 0,
    Color? badge,
    OfficeKernel kernel = OfficeKernel.other,
    double appear = 1,
    double vanish = 0,
  }) {
    final row = switch (facing) {
      OfficeFacing.down => 0,
      OfficeFacing.up => 1,
      OfficeFacing.right || OfficeFacing.left => 2,
    };
    final sheets = characters[kernel]!;
    final sheet = sheets[sprite % sheets.length];
    final px = to.width / frameWidth;
    final plain = _crisp();
    final hair = hue == 0 ? null : (_crisp()..colorFilter = hueTurn(hue));
    // Rows [top, bottom) of [w] columns from [x] of the frame; the hair
    // (the rows over 13) turned.
    void column(int x, int w, double top, double bottom) {
      if (bottom <= top) return;
      Rect cut(double from, double until) => Rect.fromLTWH(
        frame * frameWidth + x,
        row * frameHeight + from,
        w.toDouble(),
        until - from,
      );
      Rect onto(double from, double until) => Rect.fromLTWH(
        to.left + x * px,
        to.top + from * px,
        w * px,
        (until - from) * px,
      );
      canvas.drawImageRect(sheet, cut(top, bottom), onto(top, bottom), plain);
      final head = math.min(bottom, 13.0);
      if (hair != null && head > top) {
        canvas.drawImageRect(sheet, cut(top, head), onto(top, head), hair);
      }
    }

    canvas.save();
    if (facing == OfficeFacing.left) {
      canvas
        ..translate(to.right + to.left, 0)
        ..scale(-1, 1);
    }
    final whole = appear >= 1 && vanish <= 0;
    if (whole) {
      column(0, frameWidth.toInt(), 0, frameHeight);
    } else {
      _matrix(
        canvas,
        to,
        px,
        sprite,
        appear < 1 ? appear : vanish,
        spawn: appear < 1,
        column,
      );
    }
    canvas.restore();
    if (badge != null && whole) {
      // 2 of the frame's pixels, left of its chest or back; mirrored, as
      // the sheet is, facing left.
      final x = facing == OfficeFacing.left ? 5 : 9;
      canvas.drawRect(
        Rect.fromLTWH(to.left + x * px, to.top + 19 * px, 2 * px, 2 * px),
        Paint()..color = badge,
      );
    }
  }

  /// Pixel Agents' matrixEffect, [progress] 0 to 1: each column swept down
  /// by a bright head, a green trail behind it, each a little later than
  /// the last at random; [spawn], the character shows behind the head, else
  /// it goes.
  static void _matrix(
    Canvas canvas,
    Rect to,
    double px,
    int seed,
    double progress,
    void Function(int x, int w, double top, double bottom) column, {
    required bool spawn,
  }) {
    const trail = 6, sweep = frameHeight + trail, stagger = 0.3;
    for (var x = 0; x < frameWidth; x++) {
      final late = (x * 7919 + seed * 104729) % 97 / 97 * stagger;
      final head = (((progress - late) / (1 - stagger)).clamp(0.0, 1.0) * sweep)
          .floor();
      final cut = head.clamp(0, frameHeight.toInt()).toDouble();
      if (spawn) {
        column(x, 1, 0, cut);
      } else {
        column(x, 1, cut, frameHeight);
      }
      // The trail over what came (or went), the head under it.
      for (var i = 0; i < trail; i++) {
        final y = head - 1 - i;
        if (y < 0 || y >= frameHeight) continue;
        if ((x * 7 + y * 13 + (progress * 30).floor() * 31) & 0xff > 180) {
          continue;
        }
        canvas.drawRect(
          Rect.fromLTWH(to.left + x * px, to.top + y * px, px, px),
          Paint()..color = Color.fromRGBO(0, 255, 65, (1 - i / trail) * 0.6),
        );
      }
      if (head < frameHeight) {
        canvas.drawRect(
          Rect.fromLTWH(to.left + x * px, to.top + head * px, px, px),
          Paint()..color = const Color(0xffccffcc),
        );
      }
    }
  }

  /// [kernel]'s badge, its top left at [at]: Claude's spark on orange,
  /// Codex's hexagon on black, a "?" on grey; 7 pixels square, or 5
  /// ([small], a team member's).
  static void drawKernel(
    Canvas canvas,
    OfficeKernel kernel,
    Offset at, {
    bool small = false,
  }) {
    final (fill, marks) = switch ((kernel, small)) {
      (OfficeKernel.claude, false) => (
        const Color(0xffd97757),
        const ['..x..', 'x.x.x', '.xxx.', 'x.x.x', '..x..'],
      ),
      (OfficeKernel.claude, true) => (
        const Color(0xffd97757),
        const ['x.x', '.x.', 'x.x'],
      ),
      (OfficeKernel.codex, false) => (
        const Color(0xff111111),
        const ['.xxx.', 'x...x', 'x...x', 'x...x', '.xxx.'],
      ),
      (OfficeKernel.codex, true) => (
        const Color(0xff111111),
        const ['xxx', 'x.x', 'xxx'],
      ),
      (OfficeKernel.other, false) => (
        const Color(0xff8e8e93),
        const ['.xx..', '...x.', '..x..', '.....', '..x..'],
      ),
      (OfficeKernel.other, true) => (
        const Color(0xff8e8e93),
        const ['xx.', '.x.', '...'],
      ),
    };
    final side = marks.length + 2.0;
    canvas
      ..drawRect(
        Rect.fromLTWH(at.dx, at.dy, side, side),
        Paint()..color = const Color(0xff1c1c1e),
      )
      ..drawRect(
        Rect.fromLTWH(at.dx + 1, at.dy + 1, side - 2, side - 2),
        Paint()..color = fill,
      );
    final ink = Paint()..color = const Color(0xffffffff);
    for (final (y, line) in marks.indexed) {
      for (var x = 0; x < line.length; x++) {
        if (line[x] == 'x') {
          canvas.drawRect(
            Rect.fromLTWH(at.dx + 1 + x, at.dy + 1 + y, 1, 1),
            ink,
          );
        }
      }
    }
  }
}
