import 'dart:ui' show Color;

import 'package:baocode/office/office_theme.dart';
import 'package:baocode/workspace/companies.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a company looks by its icon and color; none, as before', () {
    expect(OfficeTheme.of(null), isNull);
    final lunar = OfficeTheme.of(
      const Company('LUNAR', '/l', color: 0xffba68c8, icon: 'moon'),
    )!;
    final promov = OfficeTheme.of(
      const Company('PROMOV', '/p', color: 0xffffd54f, icon: 'work'),
    )!;
    final stark = OfficeTheme.of(
      const Company('STARK', '/s', color: 0xfff06292, icon: 'rocket'),
    )!;
    expect(
      [lunar.decor, promov.decor, stark.decor],
      [OfficeDecor.night, OfficeDecor.goals, OfficeDecor.launch],
    );
    expect({lunar.floor, promov.floor, stark.floor}, hasLength(3));
    expect({lunar.wallTint, promov.wallTint, stark.wallTint}, hasLength(3));
    // A new one, of an icon with no decor of its own: a poster of its color.
    final other = OfficeTheme.of(
      const Company('ACME', '/a', color: 0xff34c759, icon: 'heart'),
    )!;
    expect(other.decor, OfficeDecor.plain);
    expect(other.accent, const Color(0xff34c759));
  });
}
