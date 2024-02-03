import 'package:flutter/material.dart';

class ThemeClass {
  Color lightPrimaryColor = Color.fromARGB(255, 250, 24, 24);
  Color darkPrimaryColor = const Color.fromRGBO(33, 33, 33, 1);
  Color secondaryColor = Colors.red.shade300;
  Color accentColor = Colors.red.shade200;

  ThemeData lightTheme = ThemeData(
      primaryColor: Color.fromARGB(255, 255, 0, 17),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: (Color.fromARGB(255, 255, 37, 52)),
      ),
      colorScheme: ColorScheme.light().copyWith(
        primary: Color.fromARGB(255, 220, 36, 36),
        secondary: Color.fromARGB(255, 167, 167, 167),
      ));

  ThemeData darkTheme = ThemeData(
      primaryColor: ThemeData.dark().scaffoldBackgroundColor,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: const Color.fromRGBO(33, 33, 33, 1),
      ));
}
