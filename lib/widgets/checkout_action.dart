import 'package:flutter/material.dart';
import 'package:open_fashion/widgets/custome-text.dart';

class CheckoutAction extends StatelessWidget {
  const CheckoutAction({
    super.key,
    required this.mainText,
    this.subText,
    required this.icon,
  });
  final String mainText;
  final String? subText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      decoration: BoxDecoration(
        color: Color.fromRGBO(245, 245, 245, 1),
        borderRadius: BorderRadius.circular(44),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomeText(
            text: mainText,
            fontSize: 16,
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w600,
          ),
          Row(
            children: [
              if (subText != null) ...[
                CustomeText(
                  text: subText!.toUpperCase(),
                  fontSize: 14,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(width: 20),
              ],
              Icon(icon, color: Colors.grey.shade800, size: 25),
            ],
          ),
        ],
      ),
    );
  }
}
