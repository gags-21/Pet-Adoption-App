import 'package:flutter/material.dart';
import 'package:pet_adoption_app_task/models/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  Future<ThemeMode> toggleTheme(bool toDark) async {
    themeMode = toDark ? ThemeMode.dark : ThemeMode.light;

    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('theme', toDark ? 'dark' : 'light');
    notifyListeners();
    return themeMode;
  }

  initialize() async {
    //shared pref
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
