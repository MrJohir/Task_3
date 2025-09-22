import 'package:flutter/material.dart';

/// app colors class for managing all colors used in the application
class AppColors {
  // primary colors
  static const Color primary = Color(0xFF2196F3);
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFFBBDEFB);
  
  // secondary colors
  static const Color secondary = Color(0xFF03DAC6);
  static const Color secondaryDark = Color(0xFF018786);
  static const Color secondaryLight = Color(0xFFB2DFDB);
  
  // surface colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF121212);
  static const Color surfaceVariant = Color(0xFFF5F5F5);
  static const Color surfaceVariantDark = Color(0xFF1E1E1E);
  
  // background colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color(0xFF121212);
  
  // text colors
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFF000000);
  static const Color onSurface = Color(0xFF1C1B1F);
  static const Color onSurfaceDark = Color(0xFFE6E1E5);
  static const Color onBackground = Color(0xFF1C1B1F);
  static const Color onBackgroundDark = Color(0xFFE6E1E5);
  
  // semantic colors
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);
  
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  // note tag colors
  static const Color noteRed = Color(0xFFFF5252);
  static const Color noteOrange = Color(0xFFFF9800);
  static const Color noteYellow = Color(0xFFFFEB3B);
  static const Color noteGreen = Color(0xFF4CAF50);
  static const Color noteBlue = Color(0xFF2196F3);
  static const Color notePurple = Color(0xFF9C27B0);
  static const Color notePink = Color(0xFFE91E63);
  static const Color noteGrey = Color(0xFF9E9E9E);
  
  // outline colors
  static const Color outline = Color(0xFF79747E);
  static const Color outlineDark = Color(0xFF938F99);
  static const Color outlineVariant = Color(0xFFCAC4D0);
  static const Color outlineVariantDark = Color(0xFF49454F);
  
  // shadow colors
  static const Color shadow = Color(0xFF000000);
  static const Color scrim = Color(0xFF000000);
  
  // divider colors
  static const Color divider = Color(0xFFE0E0E0);
  static const Color dividerDark = Color(0xFF3C3C3C);
  
  // shimmer colors
  static Color shimmerBase = Colors.grey[300]!;
  static Color shimmerBaseDark = Colors.grey[700]!;
  static Color shimmerHighlight = Colors.grey[100]!;
  static Color shimmerHighlightDark = Colors.grey[600]!;
  
  // note tag color list
  static const List<Color> noteTagColors = [
    noteRed,
    noteOrange,
    noteYellow,
    noteGreen,
    noteBlue,
    notePurple,
    notePink,
    noteGrey,
  ];
  
  /// get note tag color by index
  /// [index] - Color index from 0 to 7
  /// Returns: Color from noteTagColors list
  static Color getNoteTagColor(int index) {
    return noteTagColors[index % noteTagColors.length];
  }
  
  /// get note tag color name by index
  /// [index] - Color index from 0 to 7
  /// Returns: String name of the color
  static String getNoteTagColorName(int index) {
    const List<String> colorNames = [
      'Red',
      'Orange',
      'Yellow',
      'Green',
      'Blue',
      'Purple',
      'Pink',
      'Grey',
    ];
    return colorNames[index % colorNames.length];
  }
}