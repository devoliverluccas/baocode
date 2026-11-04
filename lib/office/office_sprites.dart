import 'dart:math' as math;
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

  /// The sheets, by [OfficeAgent.sprite].
  final List<ui.Image> characters;

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

  static Future<OfficeSprites> _load() async => OfficeSprites._(
    [
      for (var i = 0; i < OfficeAgent.sprites; i++)
        await image('assets/office/characters/char_$i.png'),
    ],
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
  /// a whole scale, so its pixels stay square and crisp), its colors turned
  /// by [hue] degrees ([hueTurn]); a [badge] of its company's color on its
  /// chest, or on its back.
  void drawCharacter(
    Canvas canvas,
    int sprite,
    Rect to, {
    int frame = 0,
    OfficeFacing facing = OfficeFacing.down,
    double hue = 0,
    Color? badge,
  }) {
    final row = switch (facing) {
      OfficeFacing.down => 0,
      OfficeFacing.up => 1,
      OfficeFacing.right || OfficeFacing.left => 2,
    };
    final from = Rect.fromLTWH(
      frame * frameWidth,
      row * frameHeight,
      frameWidth,
      frameHeight,
    );
    final sheet = characters[sprite % characters.length];
    final paint = _crisp();
    if (hue != 0) paint.colorFilter = hueTurn(hue);
    if (facing != OfficeFacing.left) {
      canvas.drawImageRect(sheet, from, to, paint);
    } else {
      canvas
        ..save()
        ..translate(to.right + to.left, 0)
        ..scale(-1, 1)
        ..drawImageRect(sheet, from, to, paint)
        ..restore();
    }
    if (badge != null) {
      // 2 of the frame's pixels, left of its chest or back; mirrored, as
      // the sheet is, facing left.
      final px = to.width / frameWidth;
      final x = facing == OfficeFacing.left ? 5 : 9;
      canvas.drawRect(
        Rect.fromLTWH(to.left + x * px, to.top + 19 * px, 2 * px, 2 * px),
        Paint()..color = badge,
      );
    }
  }
}
