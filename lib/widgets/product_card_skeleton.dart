import 'package:flutter/material.dart';
import 'package:open_fashion/widgets/shimmer_box.dart';
import 'package:shimmer/shimmer.dart';

class ProductCardSkeleton extends StatelessWidget {
  const ProductCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Image
        ShimmerBox(
          width: double.infinity,
          height: 160,
          borderRadius: BorderRadius.circular(16),
        ),

        const SizedBox(height: 12),

        /// Title
        ShimmerBox(
          width: double.infinity,
          height: 14,
          borderRadius: BorderRadius.circular(4),
        ),
        const SizedBox(height: 5),

        /// Subtitle
        ShimmerBox(
          width: 120,
          height: 14,
          borderRadius: BorderRadius.circular(4),
        ),

        const SizedBox(height: 6),

        /// Price + Cart
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerBox(
              width: 60,
              height: 16,
              borderRadius: BorderRadius.circular(4),
            ),
            ShimmerBox(
              width: 36,
              height: 36,
              shape: BoxShape.circle,
            ),
          ],
        ),
      ],
    );
  }
}
