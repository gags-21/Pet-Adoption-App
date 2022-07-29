import 'package:flutter/material.dart';
import 'package:pet_adoption_app_task/models/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isDark) async {
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;

    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('theme', isDark ? 'dark' : 'light');
    notifyListeners();
  }

  initialize() async {
    //add shared pref here
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final theme = _prefs.getString('theme') ?? 'system';
    if (theme == 'dark') {
      themeMode = ThemeMode.dark;
    } else if (theme == 'light') {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.system;
    }
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      elevation: 0,
      foregroundColor: whiteTextColor,
      backgroundColor: Colors.transparent,
    ),
  );
  static final lightTheme = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      elevation: 0,
      foregroundColor: blackTextColor,
      backgroundColor: Colors.transparent,
    ),
  );
}
