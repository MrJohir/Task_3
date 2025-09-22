import 'package:flutter_screenutil/flutter_screenutil.dart';

/// sizer class for managing responsive sizes using flutter_screenutil
class Sizer {
  // padding and margin sizes
  static double get paddingXS => 4.w;
  static double get paddingS => 8.w;
  static double get paddingM => 12.w;
  static double get paddingL => 16.w;
  static double get paddingXL => 20.w;
  static double get paddingXXL => 24.w;
  static double get paddingXXXL => 32.w;
  
  // font sizes
  static double get fontXS => 10.sp;
  static double get fontS => 12.sp;
  static double get fontM => 14.sp;
  static double get fontL => 16.sp;
  static double get fontXL => 18.sp;
  static double get fontXXL => 20.sp;
  static double get fontXXXL => 24.sp;
  static double get fontTitle => 28.sp;
  static double get fontHeading => 32.sp;
  
  // icon sizes
  static double get iconXS => 12.w;
  static double get iconS => 16.w;
  static double get iconM => 20.w;
  static double get iconL => 24.w;
  static double get iconXL => 28.w;
  static double get iconXXL => 32.w;
  
  // button sizes
  static double get buttonHeight => 48.h;
  static double get buttonHeightS => 40.h;
  static double get buttonHeightL => 56.h;
  static double get buttonRadius => 8.r;
  static double get buttonRadiusS => 4.r;
  static double get buttonRadiusL => 12.r;
  
  // card and container sizes
  static double get cardRadius => 12.r;
  static double get cardRadiusS => 8.r;
  static double get cardRadiusL => 16.r;
  static double get containerRadius => 8.r;
  static double get containerRadiusS => 4.r;
  static double get containerRadiusL => 12.r;
  
  // elevation
  static double get elevationS => 2.0;
  static double get elevationM => 4.0;
  static double get elevationL => 8.0;
  static double get elevationXL => 12.0;
  
  // spacing
  static double get spaceXS => 4.h;
  static double get spaceS => 8.h;
  static double get spaceM => 12.h;
  static double get spaceL => 16.h;
  static double get spaceXL => 20.h;
  static double get spaceXXL => 24.h;
  static double get spaceXXXL => 32.h;
  
  // app bar and navigation
  static double get appBarHeight => 56.h;
  static double get bottomNavHeight => 60.h;
  static double get tabBarHeight => 48.h;
  
  // form field sizes
  static double get fieldHeight => 48.h;
  static double get fieldRadius => 8.r;
  static double get fieldBorderWidth => 1.0;
  
  // divider and border
  static double get dividerThickness => 1.0;
  static double get borderWidth => 1.0;
  static double get borderWidthThick => 2.0;
  
  // list item sizes
  static double get listItemHeight => 72.h;
  static double get listItemMinHeight => 56.h;
  static double get listItemMaxHeight => 120.h;
  
  // image sizes
  static double get avatarS => 32.w;
  static double get avatarM => 40.w;
  static double get avatarL => 48.w;
  static double get avatarXL => 64.w;
  
  // note specific sizes
  static double get noteCardHeight => 120.h;
  static double get noteCardMinHeight => 80.h;
  static double get noteCardMaxHeight => 200.h;
  static double get colorTagSize => 20.w;
  static double get colorTagRadius => 10.r;
  
  // shimmer sizes
  static double get shimmerRadius => 4.r;
  static double get shimmerHeight => 16.h;
  static double get shimmerWidth => 100.w;
  
  // floating action button
  static double get fabSize => 56.w;
  static double get fabMiniSize => 40.w;
}