import 'package:flutter/material.dart';
import 'package:task_3/core/utils/constants/app_colors.dart';
import 'package:task_3/core/utils/constants/sizer.dart';

/// custom card widget for consistent design
class CustomCard extends StatelessWidget {
  /// card child widget
  final Widget child;

  /// card padding
  final EdgeInsets? padding;

  /// card margin
  final EdgeInsets? margin;

  /// background color
  final Color? backgroundColor;

  /// border radius
  final double? borderRadius;

  /// elevation
  final double elevation;

  /// on tap callback
  final VoidCallback? onTap;

  /// show border
  final bool showBorder;

  /// border color
  final Color? borderColor;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.elevation = 0,
    this.onTap,
    this.showBorder = true,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: margin ?? EdgeInsets.all(Sizer.marginSm),
      child: Material(
        color:
            backgroundColor ??
            (isDark ? AppColors.darkSurface : AppColors.surface),
        borderRadius: BorderRadius.circular(borderRadius ?? Sizer.radiusMd),
        elevation: elevation,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius ?? Sizer.radiusMd),
          child: Container(
            padding: padding ?? EdgeInsets.all(Sizer.paddingMd),
            decoration: showBorder
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      borderRadius ?? Sizer.radiusMd,
                    ),
                    border: Border.all(
                      color:
                          borderColor ??
                          (isDark ? AppColors.darkDivider : AppColors.divider),
                      width: 1,
                    ),
                  )
                : null,
            child: child,
          ),
        ),
      ),
    );
  }
}
