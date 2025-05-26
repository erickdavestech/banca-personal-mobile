// ignore_for_file: deprecated_member_use

import 'package:banca_movil_comercial/src/localization/app_localizations.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';

class ErrorModal extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final String imageAsset;

  const ErrorModal({
    super.key,
    required this.message,
    required this.onRetry,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 24.h(context)),
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 40.w(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color9F9F9F.withOpacity(.2), // Sombra leve
            offset: Offset(0, 6),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imageAsset, width: 30.w(context), height: 30.h(context)),
          SizedBox(height: 16.h(context)),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.w(context), color: color212121),
          ),
          SizedBox(height: 24.h(context)),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onRetry,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(color: color043371, width: 1.w(context)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                text.tryAgain,
                style: TextStyle(
                  fontSize: 14.w(context),
                  fontWeight: FontWeightEnum.Medium.fWTheme,
                  color: color043371,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
