import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    required this.color,
    required this.fontSize,
    this.fontWeight,
    required this.style,
  });

  final String text;
  final Color color;
  final double fontSize;
  final TextStyle style;

  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: TextAlign.center,
    );
  }
}
