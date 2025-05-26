import 'package:flutter/material.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';

class BiometricTipsBox extends StatelessWidget {
  const BiometricTipsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w(context)),
      decoration: BoxDecoration(
        color: color07355E1A,
        borderRadius: BorderRadius.circular(12.w(context)),
      ),
      child: Column(
        children: [
          _tipRow(Icons.lightbulb, "Use a well-lit environment.", context),
          SizedBox(height: 8.h(context)),
          _tipRow(
            Icons.visibility,
            "Ensure your face is fully visible.",
            context,
          ),
          SizedBox(height: 8.h(context)),
          _tipRow(Icons.no_accounts, "Avoid hats or sunglasses.", context),
        ],
      ),
    );
  }

  Widget _tipRow(IconData icon, String text, BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color043371, size: 20.w(context)),
        SizedBox(width: 8.w(context)),
        Flexible(
          child: Text(
            text,
            style: TextStyle(fontSize: 13.w(context), color: color1C274C),
          ),
        ),
      ],
    );
  }
}
