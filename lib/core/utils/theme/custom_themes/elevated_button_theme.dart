import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

/// custom elevated button theme configuration
class CustomElevatedButtonTheme {
  CustomElevatedButtonTheme._();

  // light theme elevated button
  static final ElevatedButtonThemeData lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.onPrimary,
      backgroundColor: AppColors.primary,
      disabledForegroundColor: AppColors.outline,
      disabledBackgroundColor: AppColors.surfaceVariant,
      side: const BorderSide(color: AppColors.primary),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

  // dark theme elevated button
  static final ElevatedButtonThemeData darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.onPrimary,
      backgroundColor: AppColors.primary,
      disabledForegroundColor: AppColors.outlineDark,
      disabledBackgroundColor: AppColors.surfaceVariantDark,
      side: const BorderSide(color: AppColors.primary),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}