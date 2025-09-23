import 'package:flutter/material.dart';
import 'package:task_3/core/common/styles/global_text_style.dart';
import 'package:task_3/core/utils/constants/app_colors.dart';
import 'package:task_3/core/utils/constants/sizer.dart';

/// loading widget for consistent loading states
class LoadingWidget extends StatelessWidget {
  /// loading message
  final String? message;

  /// show message
  final bool showMessage;

  /// loading size
  final LoadingSize size;

  const LoadingWidget({
    super.key,
    this.message,
    this.showMessage = true,
    this.size = LoadingSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLoadingIndicator(),
          if (showMessage && message != null) ...[
            SizedBox(height: Sizer.md),
            _buildLoadingMessage(isDark),
          ],
        ],
      ),
    );
  }

  /// build loading indicator
  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: _getIndicatorSize(),
      height: _getIndicatorSize(),
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        strokeWidth: 3,
      ),
    );
  }

  /// build loading message
  Widget _buildLoadingMessage(bool isDark) {
    return Text(
      message ?? 'Loading...',
      style: AppTextStyles.bodyMedium.copyWith(
        color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
      ),
      textAlign: TextAlign.center,
    );
  }

  /// get indicator size based on loading size
  double _getIndicatorSize() {
    switch (size) {
      case LoadingSize.small:
        return 24;
      case LoadingSize.medium:
        return 32;
      case LoadingSize.large:
        return 40;
    }
  }
}

/// loading sizes
enum LoadingSize { small, medium, large }
