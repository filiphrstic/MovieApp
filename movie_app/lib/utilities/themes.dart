import 'package:flutter/material.dart';

// Here we can create a custom theme for our app by setting color scheme, font family, light and dark mode,...

const primaryColor = Colors.green;

class Themes {
  static ThemeData themeData = ThemeData(
    colorSchemeSeed: primaryColor,
  );
}
