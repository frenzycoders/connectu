import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomThemes {
  static String appName = 'ConnectU';
  static Color lightPrimary = Colors.white;
  static Color darkPrimary = Color(0xff2B2B2B);
  static Color lightAccent = Colors.white;
  static Color darkAccent = Color(0xff597ef7);
  static Color lightBG = Color(0xfff3f4f9);
  static Color darkBG = Color(0xff2B2B2B);

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: lightPrimary,
      textTheme: TextTheme(),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      color: darkPrimary,
      elevation: 0,
      textTheme: TextTheme(),
    ),
  );
}
