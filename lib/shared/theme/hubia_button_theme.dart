part of 'hubia_theme.dart';

ElevatedButtonThemeData get hubiaElevatedButtonTheme =>
    ElevatedButtonThemeData(style: _buttonStyle());

OutlinedButtonThemeData get hubiaOutlinedButtonTheme =>
    OutlinedButtonThemeData(style: _buttonStyle(border: true));

ButtonStyle _buttonStyle({bool border = false}) {
  return ButtonStyle(
    minimumSize: MaterialStateProperty.all(const Size.fromHeight(30)),
    padding: MaterialStateProperty.all(const EdgeInsets.all(27)),
    textStyle: MaterialStateProperty.all(
      const TextStyle(fontWeight: FontWeight.bold),
    ),
    foregroundColor: MaterialStateProperty.all(Colors.white),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    side: border
        ? MaterialStateProperty.all(
            const BorderSide(
              color: Colors.white,
              style: BorderStyle.solid,
            ),
          )
        : null,
  );
}
