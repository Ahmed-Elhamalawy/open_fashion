// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomeText extends StatelessWidget {
  const CustomeText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.color = Colors.white,
    this.fontWeight = FontWeight.normal,
    this.maxLines = 1,
    this.letterSpacing,
  });
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final int maxLines;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        fontFamily: 'TenorSans',
        letterSpacing: letterSpacing,
      ),
    );
  }
}
