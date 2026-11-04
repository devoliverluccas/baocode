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
  OfficeSprites._(this.characters);

  /// A character sheet's frame, in its pixels.
  static const frameWidth = 16.0, frameHeight = 32.0;

  /// Frames of a sheet's row: walking (0–2), typing (3–4), reading (5–6).
  static const frames = 7;

  /// The sheets, by [OfficeAgent.sprite].
  final List<ui.Image> characters;

  static Future<OfficeSprites>? _loading;
  static Future<OfficeSprites> load() => _loading ??= _load();

  static Future<OfficeSprites> _load() async => OfficeSprites._([
    for (var i = 0; i < OfficeAgent.sprites; i++)
      await image('assets/office/characters/char_$i.png'),
  ]);

  static Future<ui.Image> image(String asset) async {
    final data = await rootBundle.load(asset);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    return (await codec.getNextFrame()).image;
  }

  /// Draws [sprite]'s [frame] facing [facing] into [to] (a frame's size at
  /// a whole scale, so its pixels stay square and crisp).
  void drawCharacter(
    Canvas canvas,
    int sprite,
    Rect to, {
    int frame = 0,
    OfficeFacing facing = OfficeFacing.down,
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
    final paint = Paint()..filterQuality = FilterQuality.none;
    final sheet = characters[sprite % characters.length];
    if (facing != OfficeFacing.left) {
      return canvas.drawImageRect(sheet, from, to, paint);
    }
    canvas
      ..save()
      ..translate(to.right + to.left, 0)
      ..scale(-1, 1)
      ..drawImageRect(sheet, from, to, paint)
      ..restore();
  }
}
