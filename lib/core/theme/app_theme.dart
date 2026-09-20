import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: ColorsManager.darkBackground,
    primaryColor: ColorsManager.mainBlue,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorsManager.darkBackground,
      elevation: 0,
    ),
    cardTheme: const CardThemeData(
      color: ColorsManager.darkBackground,
      elevation: 0,
    ),
  );
}