import 'package:flutter/material.dart';
import 'package:open_fashion/widgets/shimmer_box.dart';

class CategoriesSkeleton extends StatelessWidget {
  const CategoriesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8),
          child: Row(
            children: [
              ShimmerBox(
                width: 130,
                height: 40,
                borderRadius: BorderRadius.circular(16),
              ),
            ],
          ),
        );
      },
    );
  }
}
