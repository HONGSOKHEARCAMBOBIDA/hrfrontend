import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';

class AppTheme {
  // ✅ Main Colors
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color secondaryColor = Color(0xFFFFC107);
  static const Color backgroundColor = Color(0xFFF5F5F5);

  // ✅ Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: TheColors.infoColor,
    scaffoldBackgroundColor: TheColors.bgColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: TheColors.infoColor,
      foregroundColor: TheColors.bgColor,
      elevation: 0,
    ),
    colorScheme: const ColorScheme.light(
      primary: TheColors.infoColor,
      secondary: TheColors.warningColor,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: TheColors.black),
      bodyMedium: TextStyle(fontSize: 14, color: TheColors.black),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: TheColors.infoColor,
        foregroundColor: TheColors.bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );

  // ✅ Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: TheColors.infoColor,
    scaffoldBackgroundColor: TheColors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: TheColors.black,
      foregroundColor: TheColors.bgColor,
      elevation: 0,
    ),
    colorScheme: const ColorScheme.dark(
      primary: TheColors.infoColor,
      secondary: TheColors.warningColor,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: TheColors.bgColor),
      bodyMedium: TextStyle(fontSize: 14, color: TheColors.bgColor),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}
