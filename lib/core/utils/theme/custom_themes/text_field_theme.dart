import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

/// custom text field theme configuration
class CustomTextFieldTheme {
  CustomTextFieldTheme._();

  // light theme input decoration
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppColors.outline,
    suffixIconColor: AppColors.outline,
    labelStyle: const TextStyle().copyWith(
      fontSize: 14,
      color: AppColors.onSurface,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: 14,
      color: AppColors.outline,
    ),
    errorStyle: const TextStyle().copyWith(
      fontSize: 12,
      color: AppColors.error,
    ),
    floatingLabelStyle: const TextStyle().copyWith(
      fontSize: 14,
      color: AppColors.primary,
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.outline,
      ),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.outline,
      ),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        width: 2,
        color: AppColors.primary,
      ),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.error,
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        width: 2,
        color: AppColors.error,
      ),
    ),
    filled: true,
    fillColor: AppColors.surface,
    contentPadding: const EdgeInsets.all(16),
  );

  // dark theme input decoration
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppColors.outlineDark,
    suffixIconColor: AppColors.outlineDark,
    labelStyle: const TextStyle().copyWith(
      fontSize: 14,
      color: AppColors.onSurfaceDark,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: 14,
      color: AppColors.outlineDark,
    ),
    errorStyle: const TextStyle().copyWith(
      fontSize: 12,
      color: AppColors.error,
    ),
    floatingLabelStyle: const TextStyle().copyWith(
      fontSize: 14,
      color: AppColors.primary,
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.outlineDark,
      ),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.outlineDark,
      ),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        width: 2,
        color: AppColors.primary,
      ),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.error,
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        width: 2,
        color: AppColors.error,
      ),
    ),
    filled: true,
    fillColor: AppColors.surfaceDark,
    contentPadding: const EdgeInsets.all(16),
  );
}