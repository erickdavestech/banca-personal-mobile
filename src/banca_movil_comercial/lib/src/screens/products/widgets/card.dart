import 'dart:developer';

import 'package:banca_movil_comercial/src/localization/app_localizations.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final progressIndicator = (1 -
            (product.disponibleLocal ?? 0) / (product.limiteCtaLocal ?? 0))
        .clamp(0.0, 1.0);

    log("progressIndicator: $progressIndicator");

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color064479.withOpacity(.06),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: color043371,
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [color043371, color0080F2],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 18.h(context),
                horizontal: 23.w(context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(AppImages.caAppBar),
                        width: 36.w(context),
                        height: 36.w(context),
                      ),
                      SizedBox(width: 10.w(context)),
                      Text(
                        'Visa Clásica',
                        style: TextStyle(
                          color: colorF9FAFB,
                          fontSize: 14.w(context),
                          fontWeight: FontWeightEnum.SemiBold.fWTheme,
                        ),
                      ),
                      Spacer(),
                      Image(
                        image: AssetImage(AppImages.visa),
                        height: 16.w(context),
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 27.h(context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        text.available,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.w(context),
                        ),
                      ),
                      Text(
                        text.limit,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.w(context),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "B/. ${product.disponibleLocal?.priceFormat}",
                        style: TextStyle(
                          fontSize: 18.w(context),
                          color: Colors.white,
                          fontWeight: FontWeightEnum.SemiBold.fWTheme,
                        ),
                      ),
                      Text(
                        "B/. ${product.limiteCtaLocal?.priceFormat}",
                        style: TextStyle(
                          fontSize: 18.w(context),
                          color: Colors.white,
                          fontWeight: FontWeightEnum.SemiBold.fWTheme,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h(context)),
                  LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(84),
                    minHeight: 8.h(context),
                    value: progressIndicator,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    backgroundColor: Colors.white.withOpacity(.17),
                  ),
                  SizedBox(height: 23.h(context)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 6.h(context),
                      horizontal: 12.w(context),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          text.detailCardImportantDay,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.w(context),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 12.w(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            margin: EdgeInsets.only(top: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: color07355E.withAlpha(26)),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text.detailCardPoints,
                  style: TextStyle(
                    color: color506578,
                    fontSize: 14.w(context),
                    fontWeight: FontWeightEnum.Medium.fWTheme,
                  ),
                ),
                Spacer(),
                Text(
                  "1,200 ${text.detailCardPointsTitle}",
                  style: TextStyle(
                    color: color07355E,
                    fontSize: 14,
                    fontWeight: FontWeightEnum.SemiBold.fWTheme,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  color: color1C274C,
                  size: 12.w(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
