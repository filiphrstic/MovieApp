import 'package:flutter/material.dart';

// Here we can create a custom theme for our app by setting color scheme, font family, light and dark mode,...

const primaryColor = Colors.purple;
final backgroundColor = Colors.grey[100];
final backgroundColorDark = Colors.grey[200];

class Themes {
  static ThemeData themeData = ThemeData(
    colorSchemeSeed: primaryColor,
  );
}
