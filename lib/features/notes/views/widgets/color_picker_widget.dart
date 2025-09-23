import 'package:flutter/material.dart';
import 'package:task_3/core/common/styles/global_text_style.dart';
import 'package:task_3/core/utils/constants/app_colors.dart';
import 'package:task_3/core/utils/constants/app_texts.dart';
import 'package:task_3/core/utils/constants/sizer.dart';

/// color picker widget for selecting note colors
class ColorPickerWidget extends StatelessWidget {
  /// currently selected color index
  final int selectedColorIndex;

  /// callback when color is selected
  final Function(int) onColorSelected;

  /// show title
  final bool showTitle;

  const ColorPickerWidget({
    super.key,
    required this.selectedColorIndex,
    required this.onColorSelected,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showTitle) ...[
          Text(AppTexts.selectColor, style: AppTextStyles.titleSmall),
          SizedBox(height: Sizer.md),
        ],
        _buildColorGrid(),
      ],
    );
  }

  /// build color selection grid
  Widget _buildColorGrid() {
    return Wrap(
      spacing: Sizer.sm,
      runSpacing: Sizer.sm,
      children: List.generate(
        AppColors.noteTagColors.length,
        (index) => _buildColorOption(index),
      ),
    );
  }

  /// build individual color option
  Widget _buildColorOption(int index) {
    final isSelected = index == selectedColorIndex;
    final color = AppColors.noteTagColors[index];

    return GestureDetector(
      onTap: () => onColorSelected(index),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(Sizer.radiusMd),
          border: isSelected
              ? Border.all(color: AppColors.white, width: 3)
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: isSelected
            ? const Icon(Icons.check, color: AppColors.white, size: 24)
            : null,
      ),
    );
  }
}
