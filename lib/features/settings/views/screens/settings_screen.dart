import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_3/core/common/styles/global_text_style.dart';
import 'package:task_3/core/common/widgets/custom_app_bar.dart';
import 'package:task_3/core/common/widgets/custom_card.dart';
import 'package:task_3/core/utils/constants/app_colors.dart';
import 'package:task_3/core/utils/constants/app_texts.dart';
import 'package:task_3/core/utils/constants/sizer.dart';
import 'package:task_3/features/settings/controllers/theme_controller.dart';

/// settings screen for app configuration
class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final ThemeController themeController = Get.put<ThemeController>(
    ThemeController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.settings),
      body: ListView(
        padding: EdgeInsets.all(Sizer.paddingMd),
        children: [
          _buildThemeSection(themeController),
          SizedBox(height: Sizer.md),
          _buildAboutSection(),
        ],
      ),
    );
  }

  /// build theme configuration section
  Widget _buildThemeSection(ThemeController themeController) {
    return CustomCard(
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Appearance', style: AppTextStyles.titleMedium),
          SizedBox(height: Sizer.md),
          Obx(
            () => SwitchListTile(
              title: Text(AppTexts.darkMode, style: AppTextStyles.bodyLarge),
              subtitle: Text(
                'Switch between light and dark theme',
                style: AppTextStyles.bodySmall,
              ),
              value: themeController.isDarkMode,
              onChanged: (_) => themeController.toggleTheme(),
              activeColor: AppColors.primary,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  /// build about section
  Widget _buildAboutSection() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppTexts.about, style: AppTextStyles.titleMedium),
          SizedBox(height: Sizer.md),
          _buildInfoRow('App Name', AppTexts.appName),
          SizedBox(height: Sizer.sm),
          _buildInfoRow('Version', AppTexts.appVersion),
          SizedBox(height: Sizer.sm),
          _buildInfoRow('Features', 'Note taking with offline sync'),
        ],
      ),
    );
  }

  /// build information row
  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(flex: 3, child: Text(value, style: AppTextStyles.bodyMedium)),
      ],
    );
  }
}
