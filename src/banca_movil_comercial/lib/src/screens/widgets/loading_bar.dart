import 'package:banca_movil_libs/themes/colors.dart';
import 'package:flutter/material.dart';

class LoadingBar extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Color color;

  const LoadingBar({
    super.key,
    required this.width,
    required this.height,
    this.radius = 10,
    this.color = colorE0E9F2,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
