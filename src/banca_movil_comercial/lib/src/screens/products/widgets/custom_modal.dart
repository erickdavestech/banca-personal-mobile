import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';

class CustomModal extends StatelessWidget {
  final Widget child;

  const CustomModal({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: screenHeight * 0.85),
      padding: EdgeInsets.only(
        // left: 20.w(context),
        // right: 20.w(context),
        top: 24.h(context),
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32.w(context)),
        ),
      ),
      child: child,
    );
  }
}
