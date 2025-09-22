import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants/app_colors.dart';

/// global text styles for consistent typography across the app
class AppTextStyles {
  // heading styles
  static TextStyle get headingLarge => TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.onSurface,
        height: 1.2,
      );

  static TextStyle get headingMedium => TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.onSurface,
        height: 1.3,
      );

  static TextStyle get headingSmall => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface,
        height: 1.3,
      );

  // title styles
  static TextStyle get titleLarge => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface,
        height: 1.4,
      );

  static TextStyle get titleMedium => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface,
        height: 1.4,
      );

  static TextStyle get titleSmall => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface,
        height: 1.4,
      );

  // body styles
  static TextStyle get bodyLarge => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.onSurface,
        height: 1.5,
      );

  static TextStyle get bodyMedium => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.onSurface,
        height: 1.5,
      );

  static TextStyle get bodySmall => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.onSurface,
        height: 1.4,
      );

  // label styles
  static TextStyle get labelLarge => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface,
        height: 1.4,
      );

  static TextStyle get labelMedium => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface,
        height: 1.3,
      );

  static TextStyle get labelSmall => TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface,
        height: 1.3,
      );

  // button styles
  static TextStyle get buttonLarge => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.onPrimary,
        height: 1.2,
      );

  static TextStyle get buttonMedium => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.onPrimary,
        height: 1.2,
      );

  static TextStyle get buttonSmall => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.onPrimary,
        height: 1.2,
      );

  // caption and metadata styles
  static TextStyle get caption => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.outline,
        height: 1.3,
      );

  static TextStyle get overline => TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.outline,
        height: 1.3,
        letterSpacing: 1.5,
      );

  // specialized styles
  static TextStyle get noteTitle => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface,
        height: 1.4,
      );

  static TextStyle get noteContent => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.onSurface,
        height: 1.5,
      );

  static TextStyle get noteMetadata => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.outline,
        height: 1.3,
      );

  static TextStyle get appBarTitle => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface,
        height: 1.2,
      );

  static TextStyle get tabLabel => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface,
        height: 1.3,
      );

  static TextStyle get chipLabel => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface,
        height: 1.2,
      );

  static TextStyle get errorText => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.error,
        height: 1.3,
      );

  static TextStyle get hintText => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.outline,
        height: 1.4,
      );

  static TextStyle get linkText => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
        height: 1.4,
        decoration: TextDecoration.underline,
      );

  // dark theme variants
  static TextStyle get headingLargeDark => headingLarge.copyWith(
        color: AppColors.onSurfaceDark,
      );

  static TextStyle get headingMediumDark => headingMedium.copyWith(
        color: AppColors.onSurfaceDark,
      );

  static TextStyle get headingSmallDark => headingSmall.copyWith(
        color: AppColors.onSurfaceDark,
      );

  static TextStyle get titleLargeDark => titleLarge.copyWith(
        color: AppColors.onSurfaceDark,
      );

  static TextStyle get titleMediumDark => titleMedium.copyWith(
        color: AppColors.onSurfaceDark,
      );

  static TextStyle get titleSmallDark => titleSmall.copyWith(
        color: AppColors.onSurfaceDark,
      );

  static TextStyle get bodyLargeDark => bodyLarge.copyWith(
        color: AppColors.onSurfaceDark,
      );

  static TextStyle get bodyMediumDark => bodyMedium.copyWith(
        color: AppColors.onSurfaceDark,
      );

  static TextStyle get bodySmallDark => bodySmall.copyWith(
        color: AppColors.onSurfaceDark,
      );

  static TextStyle get labelLargeDark => labelLarge.copyWith(
        color: AppColors.onSurfaceDark,
      );

  static TextStyle get labelMediumDark => labelMedium.copyWith(
        color: AppColors.onSurfaceDark,
      );

  static TextStyle get labelSmallDark => labelSmall.copyWith(
        color: AppColors.onSurfaceDark,
      );

  static TextStyle get noteTitleDark => noteTitle.copyWith(
        color: AppColors.onSurfaceDark,
      );

  static TextStyle get noteContentDark => noteContent.copyWith(
        color: AppColors.onSurfaceDark,
      );

  static TextStyle get noteMetadataDark => noteMetadata.copyWith(
        color: AppColors.outlineDark,
      );

  static TextStyle get appBarTitleDark => appBarTitle.copyWith(
        color: AppColors.onSurfaceDark,
      );

  static TextStyle get tabLabelDark => tabLabel.copyWith(
        color: AppColors.onSurfaceDark,
      );

  static TextStyle get chipLabelDark => chipLabel.copyWith(
        color: AppColors.onSurfaceDark,
      );

  static TextStyle get hintTextDark => hintText.copyWith(
        color: AppColors.outlineDark,
      );
}