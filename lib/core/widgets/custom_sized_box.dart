import 'package:flutter/material.dart';

class CustomSizedBox extends StatelessWidget {
  const CustomSizedBox({
    super.key,
    required this.size,
    this.heightParam,
    this.widthParam,
  });

  final Size size;
  final double? heightParam;
  final double? widthParam;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * heightParam!,
    );
  }
}
