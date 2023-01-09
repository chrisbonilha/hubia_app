import 'package:flutter/material.dart';

part 'hubia_color_palette.dart';
part 'hubia_text_theme.dart';
part 'hubia_button_theme.dart';
part 'hubia_input_theme.dart';

ThemeData hubiaTheme() {
  return ThemeData(
    primarySwatch: hubiaColorPalette,
    scaffoldBackgroundColor: Colors.grey.shade300,
    textTheme: hubiaTextTheme,
    fontFamily: "Roboto",
    elevatedButtonTheme: hubiaElevatedButtonTheme,
    outlinedButtonTheme: hubiaOutlinedButtonTheme,
    inputDecorationTheme: hubiaInputTheme,
  );
}
