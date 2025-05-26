import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';


class ValidandoTokenLoader extends StatelessWidget {
  static const String routeName = '/validando-token-loader';

  final String title;

  const ValidandoTokenLoader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              colorB5D0FA,
              colorDFE4F7,
              colorEAEDF8,
              colorF2FBF8,
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.loader,
                width: 300.w(context),
                height: 300.h(context),
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 50),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 54, vertical: 14),
                decoration: BoxDecoration(
                  color: color0080F2.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.w(context),
                    color: color005199,
                    fontWeight: FontWeightEnum.SemiBold.fWTheme,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
