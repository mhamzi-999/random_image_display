import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Provides the light and dark themes for the application.
class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      colorScheme: const ColorScheme.light().copyWith(
        primary: AppColors.primary,
        secondary: AppColors.primary,
        error: AppColors.error,
        surface: AppColors.surfaceNeutral,
        surfaceTint: AppColors.primary,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: AppColors.primary,
        secondary: AppColors.primary,
        error: AppColors.error,
        surface: AppColors.surfaceDeep,
        surfaceTint: AppColors.primary,
      ),
      useMaterial3: true,
    );
  }
}
