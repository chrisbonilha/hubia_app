part of 'hubia_theme.dart';

const color = Color(0xFFff1616);

final hslColor = HSLColor.fromColor(color);
final lightness = hslColor.lightness;
final lowStep = (1.0 - lightness) / 6;
final highStep = lightness / 5;

Color get navyBlue => const Color(0xFF104E5B);
Color get yellow => const Color(0xFFFDC27A);
Color get grey => const Color(0xFF616F80);

MaterialColor get hubiaColorPalette => MaterialColor(color.value, {
      50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
      100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
      200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
      300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
      400: (hslColor.withLightness(lightness + lowStep)).toColor(),
      500: (hslColor.withLightness(lightness)).toColor(),
      600: (hslColor.withLightness(lightness - highStep)).toColor(),
      700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
      800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
      900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
    });
