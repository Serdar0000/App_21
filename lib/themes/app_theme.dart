import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppThemes {
  /// Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColorsLight.primary,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: AppColorsLight.background,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: AppColorsLight.textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: AppColorsLight.textPrimary),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColorsLight.primary,
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: AppColorsLight.textPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
      headlineSmall: TextStyle(
        color: AppColorsLight.textPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      bodyMedium: TextStyle(color: AppColorsLight.textSecondary, fontSize: 14),
      labelMedium: TextStyle(color: AppColorsLight.textHint, fontSize: 12),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorsLight.background,
      hintStyle: TextStyle(color: AppColorsLight.textHint),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColorsLight.border, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColorsLight.primaryLight.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColorsLight.primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
  );

  /// Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColorsDark.primary,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: AppColorsDark.background,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: AppColorsDark.textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: AppColorsDark.textPrimary),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColorsDark.primary,
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: AppColorsDark.textPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
      headlineSmall: TextStyle(
        color: AppColorsDark.textPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      bodyMedium: TextStyle(color: AppColorsDark.textSecondary, fontSize: 14),
      labelMedium: TextStyle(color: AppColorsDark.textHint, fontSize: 12),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorsDark.surface,
      hintStyle: TextStyle(color: AppColorsDark.textHint),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColorsDark.border, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColorsDark.border.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColorsDark.primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
  );
}
