// theme_notifier.dart
import 'package:flutter/material.dart';
import 'package:dictionary_app/database/sql_theme.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false; // Default: light mode
  bool _isLoaded = false;
  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => _isDarkMode ? _darkTheme : _lightTheme;

  ThemeNotifier() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    _isDarkMode = await SqlTheme.instance.getTheme();
    _isLoaded = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  bool get isLoaded => _isLoaded;

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await SqlTheme.instance.saveTheme(_isDarkMode);
    notifyListeners();
  }

  // Define your themes
  final ThemeData _lightTheme = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        backgroundColor: WidgetStatePropertyAll(
          Color.fromARGB(255, 10, 132, 255),
        ),
      ),
    ),
    fontFamily: 'Manrope',
    dividerColor: Colors.black38,
    colorScheme: ColorScheme.light(
      primary: Color.fromARGB(255, 10, 132, 255),
      secondary: Colors.black26,
      // onBackground: Colors.black,
      onPrimary: Colors.black,
      surface: const Color.fromARGB(255, 250, 250, 250),
      onSurface: Colors.black,
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      // const Color.fromARGB(255, 10, 132, 255),
      foregroundColor: Colors.black,
    ),
  );

  final ThemeData _darkTheme = ThemeData(
    primaryColor: Color.fromARGB(255, 10, 132, 255),
    dividerColor: Colors.white30,
    primarySwatch: Colors.blue,
    fontFamily: 'Manrope',
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Color.fromARGB(255, 10, 132, 255),

      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        backgroundColor: WidgetStatePropertyAll(
          Color.fromARGB(255, 10, 132, 255),
        ),
      ),
    ),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
  );
}
