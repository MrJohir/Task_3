import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

/// custom app bar theme configuration
class CustomAppBarTheme {
  CustomAppBarTheme._();

  // light theme app bar
  static const AppBarTheme lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.surface,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: AppColors.onSurface,
      size: 24,
    ),
    actionsIconTheme: IconThemeData(
      color: AppColors.onSurface,
      size: 24,
    ),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.onSurface,
    ),
  );

  // dark theme app bar
  static const AppBarTheme darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.surfaceDark,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: AppColors.onSurfaceDark,
      size: 24,
    ),
    actionsIconTheme: IconThemeData(
      color: AppColors.onSurfaceDark,
      size: 24,
    ),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.onSurfaceDark,
    ),
  );
}