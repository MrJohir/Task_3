import 'package:flutter/material.dart';
import 'package:task_3/core/utils/constants/app_colors.dart';
import 'package:task_3/core/utils/constants/sizer.dart';

/// custom text field theme
class CustomTextFieldTheme {
  CustomTextFieldTheme._();

  /// light text field theme
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppColors.textSecondary,
    suffixIconColor: AppColors.textSecondary,
    labelStyle: TextStyle(
      fontSize: Sizer.fontSm,
      color: AppColors.textSecondary,
    ),
    hintStyle: TextStyle(fontSize: Sizer.fontSm, color: AppColors.textTertiary),
    errorStyle: TextStyle(fontSize: Sizer.fontXs, color: AppColors.error),
    floatingLabelStyle: TextStyle(
      color: AppColors.primary,
      fontSize: Sizer.fontSm,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizer.radiusMd),
      borderSide: const BorderSide(width: 1, color: AppColors.divider),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizer.radiusMd),
      borderSide: const BorderSide(width: 1, color: AppColors.divider),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizer.radiusMd),
      borderSide: const BorderSide(width: 2, color: AppColors.primary),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizer.radiusMd),
      borderSide: const BorderSide(width: 1, color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizer.radiusMd),
      borderSide: const BorderSide(width: 2, color: AppColors.error),
    ),
    fillColor: AppColors.surface,
    filled: true,
    contentPadding: EdgeInsets.symmetric(
      horizontal: Sizer.paddingMd,
      vertical: Sizer.paddingMd,
    ),
  );

  /// dark text field theme
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppColors.darkTextSecondary,
    suffixIconColor: AppColors.darkTextSecondary,
    labelStyle: TextStyle(
      fontSize: Sizer.fontSm,
      color: AppColors.darkTextSecondary,
    ),
    hintStyle: TextStyle(
      fontSize: Sizer.fontSm,
      color: AppColors.darkTextTertiary,
    ),
    errorStyle: TextStyle(fontSize: Sizer.fontXs, color: AppColors.error),
    floatingLabelStyle: TextStyle(
      color: AppColors.primary,
      fontSize: Sizer.fontSm,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizer.radiusMd),
      borderSide: const BorderSide(width: 1, color: AppColors.darkDivider),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizer.radiusMd),
      borderSide: const BorderSide(width: 1, color: AppColors.darkDivider),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizer.radiusMd),
      borderSide: const BorderSide(width: 2, color: AppColors.primary),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizer.radiusMd),
      borderSide: const BorderSide(width: 1, color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizer.radiusMd),
      borderSide: const BorderSide(width: 2, color: AppColors.error),
    ),
    fillColor: AppColors.darkSurface,
    filled: true,
    contentPadding: EdgeInsets.symmetric(
      horizontal: Sizer.paddingMd,
      vertical: Sizer.paddingMd,
    ),
  );
}
