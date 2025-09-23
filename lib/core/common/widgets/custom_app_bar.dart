import 'package:flutter/material.dart';
import 'package:task_3/core/common/styles/global_text_style.dart';
import 'package:task_3/core/utils/constants/app_colors.dart';
import 'package:task_3/core/utils/constants/sizer.dart';

/// custom app bar widget for consistent design
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// app bar title
  final String title;

  /// leading widget
  final Widget? leading;

  /// action widgets
  final List<Widget>? actions;

  /// show back button
  final bool showBackButton;

  /// background color
  final Color? backgroundColor;

  /// center title
  final bool centerTitle;

  /// elevation
  final double elevation;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.showBackButton = true,
    this.backgroundColor,
    this.centerTitle = false,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.titleLarge.copyWith(
          color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
        ),
      ),
      leading: leading ?? (showBackButton ? _buildBackButton(context) : null),
      actions: actions,
      backgroundColor:
          backgroundColor ??
          (isDark ? AppColors.darkSurface : AppColors.surface),
      elevation: elevation,
      centerTitle: centerTitle,
      automaticallyImplyLeading: showBackButton,
      iconTheme: IconThemeData(
        color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
        size: Sizer.iconMd,
      ),
      actionsIconTheme: IconThemeData(
        color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
        size: Sizer.iconMd,
      ),
    );
  }

  /// build custom back button
  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back),
      padding: EdgeInsets.all(Sizer.paddingMd),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
