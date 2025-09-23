import 'package:flutter/material.dart';
import 'package:task_3/core/utils/constants/app_colors.dart';
import 'package:task_3/core/utils/constants/sizer.dart';

/// custom app bar theme
class CustomAppBarTheme {
  CustomAppBarTheme._();

  /// light app bar theme
  static AppBarTheme lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.surface,
    surfaceTintColor: Colors.transparent,
    iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 24),
    actionsIconTheme: const IconThemeData(
      color: AppColors.textPrimary,
      size: 24,
    ),
    titleTextStyle: TextStyle(
      fontSize: Sizer.fontLg,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
  );

  /// dark app bar theme
  static AppBarTheme darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.darkSurface,
    surfaceTintColor: Colors.transparent,
    iconTheme: const IconThemeData(color: AppColors.darkTextPrimary, size: 24),
    actionsIconTheme: const IconThemeData(
      color: AppColors.darkTextPrimary,
      size: 24,
    ),
    titleTextStyle: TextStyle(
      fontSize: Sizer.fontLg,
      fontWeight: FontWeight.w600,
      color: AppColors.darkTextPrimary,
    ),
  );
}
