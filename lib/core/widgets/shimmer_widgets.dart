import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/constants/app_colors.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;

  const ShimmerWidget({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: width,
      height: height,
      margin: margin,
      child: Shimmer.fromColors(
        baseColor: isDark
            ? AppColors.darkSurfaceVariant.withOpacity(0.3)
            : Colors.grey[300]!,
        highlightColor: isDark
            ? AppColors.darkSurfaceVariant.withOpacity(0.5)
            : Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurfaceVariant : Colors.white,
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
        ),
      ),
    );
  }
}

class NoteCardShimmer extends StatelessWidget {
  const NoteCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title shimmer
              const ShimmerWidget(
                width: double.infinity,
                height: 20,
                borderRadius: 4,
              ),
              const SizedBox(height: 12),

              // Content shimmer (3 lines)
              const ShimmerWidget(
                width: double.infinity,
                height: 16,
                borderRadius: 4,
              ),
              const SizedBox(height: 8),
              const ShimmerWidget(
                width: double.infinity,
                height: 16,
                borderRadius: 4,
              ),
              const SizedBox(height: 8),
              const ShimmerWidget(width: 200, height: 16, borderRadius: 4),
              const SizedBox(height: 16),

              // Bottom row with date and actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ShimmerWidget(width: 100, height: 14, borderRadius: 4),
                  Row(
                    children: [
                      const ShimmerWidget(
                        width: 24,
                        height: 24,
                        borderRadius: 12,
                      ),
                      const SizedBox(width: 8),
                      const ShimmerWidget(
                        width: 24,
                        height: 24,
                        borderRadius: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotesListShimmer extends StatelessWidget {
  final int itemCount;

  const NotesListShimmer({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) => const NoteCardShimmer(),
    );
  }
}

class SearchShimmer extends StatelessWidget {
  const SearchShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: const ShimmerWidget(
        width: double.infinity,
        height: 48,
        borderRadius: 24,
      ),
    );
  }
}

class StatsShimmer extends StatelessWidget {
  const StatsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const ShimmerWidget(width: 40, height: 24, borderRadius: 4),
                    const SizedBox(height: 8),
                    const ShimmerWidget(width: 80, height: 16, borderRadius: 4),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const ShimmerWidget(width: 40, height: 24, borderRadius: 4),
                    const SizedBox(height: 8),
                    const ShimmerWidget(width: 80, height: 16, borderRadius: 4),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
