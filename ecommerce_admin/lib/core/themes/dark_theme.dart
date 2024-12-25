import 'package:flutter/material.dart';

class DarkTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: Colors.orange,
      cardColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      brightness: Brightness.dark,
    );
  }
}
