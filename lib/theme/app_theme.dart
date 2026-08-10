import 'package:flutter/material.dart';

/// -----------------------------------------------------------------------
/// AlIqra App Theme
/// Centralised colors & text styles so the whole app (kids + adults)
/// stays visually consistent: clean, green + white, simple/rounded icons.
/// -----------------------------------------------------------------------
class AppColors {
  // Primary brand green (used for buttons, app bar, highlights)
  static const Color primaryGreen = Color(0xFF1B7A43);
  // Lighter green for backgrounds / cards
  static const Color lightGreen = Color(0xFFE7F5EC);
  // Accent green for streaks / progress bars
  static const Color accentGreen = Color(0xFF34C759);
  // Neutral white / off-white background
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF7FAF8);
  // Text colors
  static const Color textDark = Color(0xFF1C1C1E);
  static const Color textLight = Color(0xFF6B7A70);
}

class AppTheme {
  /// The single ThemeData used across the app (light theme only for v1.0)
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primaryGreen,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryGreen,
        primary: AppColors.primaryGreen,
        secondary: AppColors.accentGreen,
        surface: AppColors.surface,
        brightness: Brightness.light,
      ),
      // Simple, readable, kid-friendly typography
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          color: AppColors.textDark,
        ),
        bodySmall: TextStyle(
          fontSize: 13,
          color: AppColors.textLight,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          side: const BorderSide(color: AppColors.primaryGreen),
          foregroundColor: AppColors.primaryGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: Color(0xFFE3ECE6)),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: AppColors.textLight,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
