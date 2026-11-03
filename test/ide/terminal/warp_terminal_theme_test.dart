import 'package:bao_xterm/typings/xterm.dart';
import 'package:baocode/ide/terminal/terminal_render_theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Warp Dark colors over a dark theme background', () {
    final theme = warpTerminalTheme(ITheme(background: '#15202b'));
    expect(theme.background, '#15202b');
    expect(theme.cursorAccent, '#15202b');
    expect(theme.foreground, '#ffffff');
    expect(theme.red, '#ff8272');
  });

  test('no background: Warp Dark', () {
    expect(warpTerminalTheme(null).background, warpBackground);
  });

  test("a light background keeps the theme's colors", () {
    final theme = warpTerminalTheme(
      ITheme(background: '#ffffff', foreground: '#333333', red: '#cd3131'),
    );
    expect(theme.foreground, '#333333');
    expect(theme.red, '#cd3131');
  });
}
