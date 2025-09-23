import 'package:flutter/material.dart';
import 'package:task_3/core/common/styles/global_text_style.dart';
import 'package:task_3/core/utils/constants/app_colors.dart';

/// custom text theme
class CustomTextTheme {
  CustomTextTheme._();

  /// light text theme
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: AppTextStyles.headlineLarge,
    headlineMedium: AppTextStyles.headlineMedium,
    headlineSmall: AppTextStyles.headlineSmall,
    titleLarge: AppTextStyles.titleLarge,
    titleMedium: AppTextStyles.titleMedium,
    titleSmall: AppTextStyles.titleSmall,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.bodySmall,
    labelLarge: AppTextStyles.labelLarge,
    labelMedium: AppTextStyles.labelMedium,
    labelSmall: AppTextStyles.labelSmall,
    displayLarge: AppTextStyles.displayLarge,
    displayMedium: AppTextStyles.displayMedium,
    displaySmall: AppTextStyles.displaySmall,
  );

  /// dark text theme
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: AppTextStyles.headlineLarge.copyWith(
      color: AppColors.darkTextPrimary,
    ),
    headlineMedium: AppTextStyles.headlineMedium.copyWith(
      color: AppColors.darkTextPrimary,
    ),
    headlineSmall: AppTextStyles.headlineSmall.copyWith(
      color: AppColors.darkTextPrimary,
    ),
    titleLarge: AppTextStyles.titleLarge.copyWith(
      color: AppColors.darkTextPrimary,
    ),
    titleMedium: AppTextStyles.titleMedium.copyWith(
      color: AppColors.darkTextPrimary,
    ),
    titleSmall: AppTextStyles.titleSmall.copyWith(
      color: AppColors.darkTextPrimary,
    ),
    bodyLarge: AppTextStyles.bodyLarge.copyWith(
      color: AppColors.darkTextPrimary,
    ),
    bodyMedium: AppTextStyles.bodyMedium.copyWith(
      color: AppColors.darkTextPrimary,
    ),
    bodySmall: AppTextStyles.bodySmall.copyWith(
      color: AppColors.darkTextSecondary,
    ),
    labelLarge: AppTextStyles.labelLarge.copyWith(
      color: AppColors.darkTextPrimary,
    ),
    labelMedium: AppTextStyles.labelMedium.copyWith(
      color: AppColors.darkTextSecondary,
    ),
    labelSmall: AppTextStyles.labelSmall.copyWith(
      color: AppColors.darkTextTertiary,
    ),
    displayLarge: AppTextStyles.displayLarge.copyWith(
      color: AppColors.darkTextPrimary,
    ),
    displayMedium: AppTextStyles.displayMedium.copyWith(
      color: AppColors.darkTextPrimary,
    ),
    displaySmall: AppTextStyles.displaySmall.copyWith(
      color: AppColors.darkTextPrimary,
    ),
  );
}
