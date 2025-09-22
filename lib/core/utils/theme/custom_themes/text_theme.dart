import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

/// custom text theme configuration
class CustomTextTheme {
  CustomTextTheme._();

  // light theme text theme
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.onSurface,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColors.onSurface,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.onSurface,
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.onSurface,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColors.onSurface,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.onSurface,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.onSurface,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColors.onSurface,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: AppColors.onSurface,
    ),
    labelLarge: const TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.onSurface,
    ),
    labelMedium: const TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.onSurface,
    ),
    labelSmall: const TextStyle().copyWith(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: AppColors.onSurface,
    ),
  );

  // dark theme text theme
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.onSurfaceDark,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColors.onSurfaceDark,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.onSurfaceDark,
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.onSurfaceDark,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColors.onSurfaceDark,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.onSurfaceDark,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.onSurfaceDark,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColors.onSurfaceDark,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: AppColors.onSurfaceDark,
    ),
    labelLarge: const TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.onSurfaceDark,
    ),
    labelMedium: const TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.onSurfaceDark,
    ),
    labelSmall: const TextStyle().copyWith(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: AppColors.onSurfaceDark,
    ),
  );
}