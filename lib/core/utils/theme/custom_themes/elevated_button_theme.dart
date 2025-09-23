import 'package:flutter/material.dart';
import 'package:task_3/core/utils/constants/app_colors.dart';
import 'package:task_3/core/utils/constants/sizer.dart';

/// custom elevated button theme
class CustomElevatedButtonTheme {
  CustomElevatedButtonTheme._();

  /// light elevated button theme
  static ElevatedButtonThemeData lightElevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.textTertiary,
          disabledBackgroundColor: AppColors.surfaceVariant,
          side: const BorderSide(color: AppColors.primary),
          padding: EdgeInsets.symmetric(
            vertical: Sizer.paddingMd,
            horizontal: Sizer.paddingLg,
          ),
          textStyle: TextStyle(
            fontSize: Sizer.fontMd,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizer.radiusMd),
          ),
        ),
      );

  /// dark elevated button theme
  static ElevatedButtonThemeData darkElevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.darkTextTertiary,
          disabledBackgroundColor: AppColors.darkSurfaceVariant,
          side: const BorderSide(color: AppColors.primary),
          padding: EdgeInsets.symmetric(
            vertical: Sizer.paddingMd,
            horizontal: Sizer.paddingLg,
          ),
          textStyle: TextStyle(
            fontSize: Sizer.fontMd,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizer.radiusMd),
          ),
        ),
      );
}
