import 'package:flutter/material.dart';
import 'package:open_fashion/widgets/custome-text.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomeText(
          text: title.toUpperCase(),
          fontSize: 18,
          color: Colors.white,
          letterSpacing: 4,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
