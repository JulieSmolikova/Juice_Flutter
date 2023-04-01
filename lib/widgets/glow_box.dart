import 'package:flutter/material.dart';

class GlowBox extends StatelessWidget {
  const GlowBox(
      {Key? key,
      required this.width,
      required this.height,
      required this.colorBox,
      required this.blurRadius})
      : super(key: key);

  final double width;
  final double height;
  final double blurRadius;
  final Color colorBox;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
        BoxShadow(
            color: colorBox, blurRadius: blurRadius, offset: const Offset(0, 0))
      ]),
    );
  }
}
