import 'package:flutter_screenutil/flutter_screenutil.dart';

/// sizer class for responsive sizing
class Sizer {
  Sizer._();

  // spacing
  static double get xs => 4.w;
  static double get sm => 8.w;
  static double get md => 16.w;
  static double get lg => 24.w;
  static double get xl => 32.w;
  static double get xxl => 48.w;

  // padding
  static double get paddingXs => 4.w;
  static double get paddingSm => 8.w;
  static double get paddingMd => 16.w;
  static double get paddingLg => 24.w;
  static double get paddingXl => 32.w;

  // margin
  static double get marginXs => 4.w;
  static double get marginSm => 8.w;
  static double get marginMd => 16.w;
  static double get marginLg => 24.w;
  static double get marginXl => 32.w;

  // border radius
  static double get radiusXs => 4.r;
  static double get radiusSm => 8.r;
  static double get radiusMd => 12.r;
  static double get radiusLg => 16.r;
  static double get radiusXl => 24.r;

  // font sizes
  static double get fontXs => 12.sp;
  static double get fontSm => 14.sp;
  static double get fontMd => 16.sp;
  static double get fontLg => 18.sp;
  static double get fontXl => 20.sp;
  static double get fontXxl => 24.sp;
  static double get fontXxxl => 32.sp;

  // icon sizes
  static double get iconXs => 16.w;
  static double get iconSm => 20.w;
  static double get iconMd => 24.w;
  static double get iconLg => 28.w;
  static double get iconXl => 32.w;

  // heights
  static double get heightXs => 32.h;
  static double get heightSm => 40.h;
  static double get heightMd => 48.h;
  static double get heightLg => 56.h;
  static double get heightXl => 64.h;

  // widths
  static double get widthXs => 80.w;
  static double get widthSm => 120.w;
  static double get widthMd => 160.w;
  static double get widthLg => 200.w;
  static double get widthXl => 240.w;
}
