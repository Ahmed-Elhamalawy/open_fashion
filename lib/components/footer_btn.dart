import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:open_fashion/components/custome-text.dart';

class FooterBtn extends StatelessWidget {
  const FooterBtn(
      {super.key,
      required this.text,
      this.icon,
      this.textColor = Colors.black,
      this.fillColor = Colors.white,
      this.iconColor = Colors.black});
  final String text;
  final IconData? icon;
  final Color textColor;
  final Color fillColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: fillColor, borderRadius: BorderRadius.circular(20)),
      height: 60,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, color: iconColor, size: 30),
            Gap(24),
          ],
          CustomeText(
            text: text,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
        ],
      ),
    );
  }
}
