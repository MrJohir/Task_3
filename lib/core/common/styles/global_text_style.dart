import 'package:flutter/material.dart';
import 'package:task_3/core/utils/constants/app_colors.dart';
import 'package:task_3/core/utils/constants/sizer.dart';

/// global text styles for consistent typography
class AppTextStyles {
  AppTextStyles._();

  // headline styles
  static TextStyle get headlineLarge => TextStyle(
    fontSize: Sizer.fontXxxl,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle get headlineMedium => TextStyle(
    fontSize: Sizer.fontXxl,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle get headlineSmall => TextStyle(
    fontSize: Sizer.fontXl,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // title styles
  static TextStyle get titleLarge => TextStyle(
    fontSize: Sizer.fontLg,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle get titleMedium => TextStyle(
    fontSize: Sizer.fontMd,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get titleSmall => TextStyle(
    fontSize: Sizer.fontSm,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // body styles
  static TextStyle get bodyLarge => TextStyle(
    fontSize: Sizer.fontMd,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontSize: Sizer.fontSm,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle get bodySmall => TextStyle(
    fontSize: Sizer.fontXs,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // label styles
  static TextStyle get labelLarge => TextStyle(
    fontSize: Sizer.fontSm,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get labelMedium => TextStyle(
    fontSize: Sizer.fontXs,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static TextStyle get labelSmall => TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textTertiary,
    height: 1.4,
  );

  // button styles
  static TextStyle get buttonLarge => TextStyle(
    fontSize: Sizer.fontMd,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    height: 1.2,
  );

  static TextStyle get buttonMedium => TextStyle(
    fontSize: Sizer.fontSm,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    height: 1.2,
  );

  static TextStyle get buttonSmall => TextStyle(
    fontSize: Sizer.fontXs,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    height: 1.2,
  );

  // display styles
  static TextStyle get displayLarge => TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.12,
  );

  static TextStyle get displayMedium => TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.16,
  );

  static TextStyle get displaySmall => TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.22,
  );
}
