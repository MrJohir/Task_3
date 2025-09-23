import 'package:flutter/material.dart';
import 'package:task_3/core/common/styles/global_text_style.dart';
import 'package:task_3/core/utils/constants/app_colors.dart';
import 'package:task_3/core/utils/constants/sizer.dart';

/// custom button widget for consistent design
class CustomButton extends StatelessWidget {
  /// button text
  final String text;

  /// onPressed callback
  final VoidCallback? onPressed;

  /// button type
  final ButtonType type;

  /// button size
  final ButtonSize size;

  /// full width button
  final bool isFullWidth;

  /// loading state
  final bool isLoading;

  /// custom background color
  final Color? backgroundColor;

  /// custom text color
  final Color? textColor;

  /// icon widget
  final Widget? icon;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.size = ButtonSize.medium,
    this.isFullWidth = false,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: _getButtonHeight(),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: _getButtonStyle(isDark),
        child: isLoading ? _buildLoadingWidget() : _buildButtonContent(),
      ),
    );
  }

  /// get button height based on size
  double _getButtonHeight() {
    switch (size) {
      case ButtonSize.small:
        return Sizer.heightXs;
      case ButtonSize.medium:
        return Sizer.heightMd;
      case ButtonSize.large:
        return Sizer.heightLg;
    }
  }

  /// get button style based on type and theme
  ButtonStyle _getButtonStyle(bool isDark) {
    final baseStyle = ElevatedButton.styleFrom(
      elevation: 0,
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(),
        vertical: _getVerticalPadding(),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizer.radiusMd),
      ),
    );

    switch (type) {
      case ButtonType.primary:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.all(
            backgroundColor ?? AppColors.primary,
          ),
          foregroundColor: WidgetStateProperty.all(
            textColor ?? AppColors.white,
          ),
          overlayColor: WidgetStateProperty.all(
            AppColors.primaryLight.withOpacity(0.1),
          ),
        );

      case ButtonType.secondary:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.all(
            backgroundColor ??
                (isDark
                    ? AppColors.darkSurfaceVariant
                    : AppColors.surfaceVariant),
          ),
          foregroundColor: WidgetStateProperty.all(
            textColor ??
                (isDark ? AppColors.darkTextPrimary : AppColors.textPrimary),
          ),
          side: WidgetStateProperty.all(
            BorderSide(
              color: isDark ? AppColors.darkDivider : AppColors.divider,
              width: 1,
            ),
          ),
        );

      case ButtonType.outline:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.all(AppColors.transparent),
          foregroundColor: WidgetStateProperty.all(
            textColor ?? AppColors.primary,
          ),
          side: WidgetStateProperty.all(
            BorderSide(color: backgroundColor ?? AppColors.primary, width: 1),
          ),
        );

      case ButtonType.text:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.all(AppColors.transparent),
          foregroundColor: WidgetStateProperty.all(
            textColor ?? AppColors.primary,
          ),
          elevation: WidgetStateProperty.all(0),
          overlayColor: WidgetStateProperty.all(
            AppColors.primary.withOpacity(0.1),
          ),
        );
    }
  }

  /// get horizontal padding based on size
  double _getHorizontalPadding() {
    switch (size) {
      case ButtonSize.small:
        return Sizer.paddingMd;
      case ButtonSize.medium:
        return Sizer.paddingLg;
      case ButtonSize.large:
        return Sizer.paddingXl;
    }
  }

  /// get vertical padding based on size
  double _getVerticalPadding() {
    switch (size) {
      case ButtonSize.small:
        return Sizer.paddingSm;
      case ButtonSize.medium:
        return Sizer.paddingMd;
      case ButtonSize.large:
        return Sizer.paddingLg;
    }
  }

  /// get text style based on size
  TextStyle _getTextStyle() {
    switch (size) {
      case ButtonSize.small:
        return AppTextStyles.buttonSmall;
      case ButtonSize.medium:
        return AppTextStyles.buttonMedium;
      case ButtonSize.large:
        return AppTextStyles.buttonLarge;
    }
  }

  /// build loading widget
  Widget _buildLoadingWidget() {
    return SizedBox(
      width: _getLoadingSize(),
      height: _getLoadingSize(),
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
        strokeWidth: 2,
      ),
    );
  }

  /// get loading indicator size
  double _getLoadingSize() {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 20;
      case ButtonSize.large:
        return 24;
    }
  }

  /// build button content
  Widget _buildButtonContent() {
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          SizedBox(width: Sizer.sm),
          Text(text, style: _getTextStyle()),
        ],
      );
    }

    return Text(text, style: _getTextStyle());
  }
}

/// button types
enum ButtonType { primary, secondary, outline, text }

/// button sizes
enum ButtonSize { small, medium, large }
