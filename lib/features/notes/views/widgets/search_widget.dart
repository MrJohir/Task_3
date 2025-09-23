import 'package:flutter/material.dart';
import 'package:task_3/core/common/styles/global_text_style.dart';
import 'package:task_3/core/utils/constants/app_colors.dart';
import 'package:task_3/core/utils/constants/app_texts.dart';
import 'package:task_3/core/utils/constants/sizer.dart';

/// search widget for filtering notes
class SearchWidget extends StatefulWidget {
  /// search query callback
  final Function(String) onSearchChanged;

  /// initial search query
  final String initialQuery;

  /// show clear button
  final bool showClearButton;

  const SearchWidget({
    super.key,
    required this.onSearchChanged,
    this.initialQuery = '',
    this.showClearButton = true,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Sizer.marginMd,
        vertical: Sizer.marginSm,
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: widget.onSearchChanged,
        style: AppTextStyles.bodyMedium,
        decoration: InputDecoration(
          hintText: AppTexts.searchNotes,
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: isDark ? AppColors.darkTextTertiary : AppColors.textTertiary,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.textSecondary,
            size: Sizer.iconMd,
          ),
          suffixIcon: _buildSuffixIcon(),
          filled: true,
          fillColor: isDark
              ? AppColors.darkSurfaceVariant
              : AppColors.surfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizer.radiusLg),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizer.radiusLg),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizer.radiusLg),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: Sizer.paddingMd,
            vertical: Sizer.paddingMd,
          ),
        ),
      ),
    );
  }

  /// build suffix icon based on state
  Widget? _buildSuffixIcon() {
    if (_controller.text.isEmpty) return null;

    if (!widget.showClearButton) return null;

    return IconButton(
      onPressed: _clearSearch,
      icon: const Icon(Icons.clear, color: AppColors.textSecondary),
      iconSize: Sizer.iconSm,
    );
  }

  /// clear search input
  void _clearSearch() {
    _controller.clear();
    widget.onSearchChanged('');
    _focusNode.unfocus();
  }
}
