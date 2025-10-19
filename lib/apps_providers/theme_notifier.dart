import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 10, 132, 255),
    ),

    primaryColor: const Color.fromARGB(255, 10, 132, 255),
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(4),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(
          const Color.fromARGB(255, 10, 132, 255),
        ),
      ),
    ),
    fontFamily: 'Manrope',
    // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  );

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
