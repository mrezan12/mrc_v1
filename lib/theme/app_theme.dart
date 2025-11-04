import 'package:flutter/material.dart';
import 'app_colors.dart';

/// EVISTAL Smart Home App - Tema Sistemi
/// Flutter ThemeData yapılandırmaları
/// Renkler için AppColors kütüphanesini kullanır

class AppTheme {
  // ============ RGB RENK PALETİ (AppColors'tan referans) ============
  /// RGB mod renk paleti - AppColors kütüphanesinden
  static const List<List<Color>> rgbColors = AppColors.rgbColors;

  // ============ DARK THEME ============
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkTextPrimary,
      onPrimary: AppColors.darkButtonActiveText,
      secondary: AppColors.darkTextSecondary,
      surface: AppColors.darkCardBackground1,
      onSurface: AppColors.darkTextPrimary,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppColors.darkTextPrimary,
        height: 1.5,
      ),
      displayMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.darkTextPrimary,
        height: 1.5,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.darkTextPrimary,
        height: 1.5,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.darkTextPrimary,
        height: 1.5,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextPrimary,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextSecondary,
        height: 1.5,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.darkTextPrimary,
        height: 1.5,
      ),
    ),
  );

  // ============ LIGHT THEME ============
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: const ColorScheme.light(
      primary: AppColors.lightTextPrimary,
      onPrimary: AppColors.lightButtonActiveText,
      secondary: AppColors.lightTextSecondary,
      surface: AppColors.lightCardBackground1,
      onSurface: AppColors.lightTextPrimary,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppColors.lightTextPrimary,
        height: 1.5,
      ),
      displayMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.lightTextPrimary,
        height: 1.5,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.lightTextPrimary,
        height: 1.5,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.lightTextPrimary,
        height: 1.5,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextPrimary,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextSecondary,
        height: 1.5,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.lightTextPrimary,
        height: 1.5,
      ),
    ),
  );
}

