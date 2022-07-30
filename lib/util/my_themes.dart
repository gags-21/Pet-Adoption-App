// Custom Theme Data
import 'package:flutter/material.dart';

import '../models/constants.dart';

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