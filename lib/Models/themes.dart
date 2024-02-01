import 'package:flutter/material.dart';

ThemeClass themeClass = ThemeClass();

class ThemeClass {
  Color lightPrimaryColor = Colors.red.shade800;
  Color darkPrimaryColor = Colors.grey.shade900;
  Color secondaryColor = Colors.red.shade300;
  Color accentColor = Colors.red.shade200;

  static ThemeData lightTheme = ThemeData(
      primaryColor: ThemeData.light().scaffoldBackgroundColor,
      colorScheme: const ColorScheme.light().copyWith(
        primary: themeClass.lightPrimaryColor,
        secondary: themeClass.secondaryColor,
      ));

  static ThemeData darkTheme = ThemeData(
      primaryColor: ThemeData.dark().scaffoldBackgroundColor,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: themeClass.darkPrimaryColor,
      ));
}
