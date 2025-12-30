import 'package:flutter/material.dart';
import 'package:open_fashion/widgets/custome-text.dart';

class Label extends StatelessWidget {
  const Label({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return CustomeText(
      text: text.toUpperCase(),
      fontSize: 16,
      color: Color.fromRGBO(136, 136, 136, 1),
      fontWeight: FontWeight.w800,
      letterSpacing: 1,
    );
  }
}
