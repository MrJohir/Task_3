import 'package:flutter/material.dart';
import 'package:task_3/core/common/styles/global_text_style.dart';
import 'package:task_3/core/common/widgets/custom_button.dart';
import 'package:task_3/core/utils/constants/app_colors.dart';
import 'package:task_3/core/utils/constants/app_texts.dart';
import 'package:task_3/core/utils/constants/sizer.dart';

/// empty state widget for when no notes are available
class EmptyStateWidget extends StatelessWidget {
  /// empty state type
  final EmptyStateType type;

  /// action button callback
  final VoidCallback? onActionPressed;

  /// custom title
  final String? customTitle;

  /// custom subtitle
  final String? customSubtitle;

  /// custom icon
  final IconData? customIcon;

  const EmptyStateWidget({
    super.key,
    this.type = EmptyStateType.noNotes,
    this.onActionPressed,
    this.customTitle,
    this.customSubtitle,
    this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(Sizer.paddingXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(isDark),
            SizedBox(height: Sizer.lg),
            _buildTitle(),
            SizedBox(height: Sizer.sm),
            _buildSubtitle(isDark),
            if (_showActionButton()) ...[
              SizedBox(height: Sizer.xl),
              _buildActionButton(),
            ],
          ],
        ),
      ),
    );
  }

  /// build empty state icon
  Widget _buildIcon(bool isDark) {
    final icon = customIcon ?? _getIconForType();
    final color = isDark ? AppColors.darkTextTertiary : AppColors.textTertiary;

    return Container(
      padding: EdgeInsets.all(Sizer.paddingXl),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(Sizer.radiusXl),
      ),
      child: Icon(icon, size: 64, color: color),
    );
  }

  /// build title text
  Widget _buildTitle() {
    return Text(
      customTitle ?? _getTitleForType(),
      style: AppTextStyles.headlineSmall,
      textAlign: TextAlign.center,
    );
  }

  /// build subtitle text
  Widget _buildSubtitle(bool isDark) {
    return Text(
      customSubtitle ?? _getSubtitleForType(),
      style: AppTextStyles.bodyMedium.copyWith(
        color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
      ),
      textAlign: TextAlign.center,
    );
  }

  /// build action button if needed
  Widget _buildActionButton() {
    return CustomButton(
      text: _getActionTextForType(),
      onPressed: onActionPressed,
      type: ButtonType.primary,
      icon: Icon(
        _getActionIconForType(),
        size: Sizer.iconSm,
        color: AppColors.white,
      ),
    );
  }

  /// check if action button should be shown
  bool _showActionButton() {
    return type == EmptyStateType.noNotes && onActionPressed != null;
  }

  /// get icon for empty state type
  IconData _getIconForType() {
    switch (type) {
      case EmptyStateType.noNotes:
        return Icons.note_add_outlined;
      case EmptyStateType.noSearchResults:
        return Icons.search_off;
      case EmptyStateType.noConnection:
        return Icons.wifi_off;
      case EmptyStateType.error:
        return Icons.error_outline;
    }
  }

  /// get title for empty state type
  String _getTitleForType() {
    switch (type) {
      case EmptyStateType.noNotes:
        return AppTexts.noNotes;
      case EmptyStateType.noSearchResults:
        return 'No results found';
      case EmptyStateType.noConnection:
        return 'No connection';
      case EmptyStateType.error:
        return 'Something went wrong';
    }
  }

  /// get subtitle for empty state type
  String _getSubtitleForType() {
    switch (type) {
      case EmptyStateType.noNotes:
        return AppTexts.noNotesSubtitle;
      case EmptyStateType.noSearchResults:
        return 'Try adjusting your search terms';
      case EmptyStateType.noConnection:
        return 'Check your internet connection';
      case EmptyStateType.error:
        return 'Please try again later';
    }
  }

  /// get action text for empty state type
  String _getActionTextForType() {
    switch (type) {
      case EmptyStateType.noNotes:
        return AppTexts.createNote;
      case EmptyStateType.noSearchResults:
        return 'Clear search';
      case EmptyStateType.noConnection:
        return AppTexts.retry;
      case EmptyStateType.error:
        return AppTexts.retry;
    }
  }

  /// get action icon for empty state type
  IconData _getActionIconForType() {
    switch (type) {
      case EmptyStateType.noNotes:
        return Icons.add;
      case EmptyStateType.noSearchResults:
        return Icons.clear;
      case EmptyStateType.noConnection:
        return Icons.refresh;
      case EmptyStateType.error:
        return Icons.refresh;
    }
  }
}

/// empty state types
enum EmptyStateType { noNotes, noSearchResults, noConnection, error }
