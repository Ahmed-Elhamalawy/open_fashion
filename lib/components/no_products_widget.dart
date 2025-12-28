import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../components/custome-text.dart';

class NoProductsWidget extends StatelessWidget {
  const NoProductsWidget({
    super.key,
    this.message = 'No products found',
    this.icon = Icons.search_off,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const Gap(20),
            CustomeText(
              text: message,
              fontSize: 18,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.bold,
            ),
            const Gap(10),
            CustomeText(
              text: 'Try adjusting your filters or search again.',
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ],
        ),
      ),
    );
  }
}
