import 'package:flutter/material.dart';

class SeeMoreButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  const SeeMoreButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.textColor,
    required this.fontSize,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      // 🔥 Ajusta el ancho automáticamente para evitar overflow
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 8), // 🔥 Ajuste del padding
          tapTargetSize: MaterialTapTargetSize
              .shrinkWrap, // 🔥 Evita expansión innecesaria
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize, // 🔥 Mantiene w(context)
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
