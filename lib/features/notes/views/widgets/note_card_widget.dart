import 'package:flutter/material.dart';
import 'package:task_3/core/common/styles/global_text_style.dart';
import 'package:task_3/core/common/widgets/custom_card.dart';
import 'package:task_3/core/utils/constants/app_colors.dart';
import 'package:task_3/core/utils/constants/sizer.dart';
import 'package:task_3/features/notes/models/note_model.dart';

/// note card widget to display note information
class NoteCardWidget extends StatelessWidget {
  /// note model
  final NoteModel note;

  /// on tap callback
  final VoidCallback? onTap;

  /// on long press callback
  final VoidCallback? onLongPress;

  /// on delete callback
  final VoidCallback? onDelete;

  const NoteCardWidget({
    super.key,
    required this.note,
    this.onTap,
    this.onLongPress,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return CustomCard(
      onTap: onTap,
      backgroundColor: _getNoteColor(isDark),
      padding: EdgeInsets.all(Sizer.paddingMd),
      margin: EdgeInsets.symmetric(
        horizontal: Sizer.marginMd,
        vertical: Sizer.marginSm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title.isEmpty ? 'Untitled' : note.title,
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    note.content,
                    style: AppTextStyles.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: Sizer.iconXs,
                      color: isDark
                          ? AppColors.darkTextTertiary
                          : AppColors.textTertiary,
                    ),
                    SizedBox(width: Sizer.xs),
                    Text(
                      _formatDateTime(note.updatedAt),
                      style: AppTextStyles.labelSmall.copyWith(
                        color: isDark
                            ? AppColors.darkTextTertiary
                            : AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              if (onDelete != null) ...[
                SizedBox(width: Sizer.xs),
                GestureDetector(
                  onTap: onDelete,
                  child: Icon(
                    Icons.delete_outline,
                    size: Sizer.iconSm,
                    color: AppColors.error,
                  ),
                ),
              ],
              SizedBox(height: Sizer.xl),
              if (note.isSynced)
                Icon(
                  Icons.cloud_done,
                  size: Sizer.iconXs,
                  color: AppColors.success,
                ),
            ],
          ),
        ],
      ),
    );
  }

  /// get note background color based on tag
  Color _getNoteColor(bool isDark) {
    final baseColor = AppColors
        .noteTagColors[note.colorIndex % AppColors.noteTagColors.length];

    if (isDark) {
      return baseColor.withValues(alpha: 0.1);
    } else {
      return baseColor.withValues(alpha: 0.05);
    }
  }

  /// format date time for display
  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}
