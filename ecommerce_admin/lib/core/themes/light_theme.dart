import 'package:flutter/material.dart';

class LightTheme {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      primaryColor: Colors.orange,
      disabledColor: Colors.grey,
      cardColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
    );
  }
}
