import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';

class ErrorBanner extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onClose;

  const ErrorBanner({
    super.key,
    required this.title,
    required this.message,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEFF0),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Image.asset(
            AppImages.danger,
            width: 25.w(context),
            height: 25.h(context),
          ),
          SizedBox(width: 12.w(context)),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 18.w(context), color: color06243E),
                children: [
                  TextSpan(
                    text: title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: message),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: onClose,
            child: const Icon(Icons.close, size: 18, color: color06243E),
          ),
        ],
      ),
    );
  }
}
