import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_3/core/common/styles/global_text_style.dart';
import 'package:task_3/core/utils/constants/app_colors.dart';
import 'package:task_3/core/utils/constants/app_texts.dart';
import 'package:task_3/core/utils/constants/sizer.dart';
import 'package:task_3/features/notes/controllers/note_controller.dart';

/// search widget for filtering notes
class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final noteController = Get.find<NoteController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Sizer.marginMd,
        vertical: Sizer.marginSm,
      ),
      child: Obx(
        () => TextField(
          controller: noteController.searchController,
          focusNode: noteController.searchFocusNode,
          onChanged: noteController.searchNotes,
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText: AppTexts.searchNotes,
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: isDark
                  ? AppColors.darkTextTertiary
                  : AppColors.textTertiary,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.textSecondary,
              size: Sizer.iconMd,
            ),
            suffixIcon: _buildSuffixIcon(noteController, isDark),
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
      ),
    );
  }

  /// build suffix icon based on state
  Widget? _buildSuffixIcon(NoteController controller, bool isDark) {
    if (controller.searchQuery.isEmpty) return null;

    return IconButton(
      onPressed: controller.clearSearch,
      icon: Icon(
        Icons.clear,
        color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
      ),
      iconSize: Sizer.iconSm,
    );
  }
}
