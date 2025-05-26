import 'dart:developer';

import 'package:banca_movil_comercial/src/localization/app_localizations.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';

class LoanCard extends StatelessWidget {
  const LoanCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    // (product.pendingAmount ?? 0) /
    //                         (product.originalAmount ?? 1),

    final progressIndicator = (1 -
            (product.pendingAmount ?? 0) / (product.originalAmount ?? 0))
        .clamp(0.0, 1.0);

    log("progressIndicator: $progressIndicator");

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color064479.withOpacity(.06),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color064479,
                  borderRadius: BorderRadius.circular(24),
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
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  text.loanShare,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(.8),
                                    fontSize: 12.w(context),
                                  ),
                                ),
                                Text(
                                  "B/. ${product.nextQuote?.priceFormat}",
                                  style: TextStyle(
                                    fontSize: 16.w(context),
                                    color: Colors.white,
                                    fontWeight: FontWeightEnum.SemiBold.fWTheme,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  text.status,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(.8),
                                    fontSize: 12.w(context),
                                  ),
                                ),
                                Text(
                                  "${product.accountStatus}",
                                  style: TextStyle(
                                    fontSize: 16.w(context),
                                    color: Colors.white,
                                    fontWeight: FontWeightEnum.SemiBold.fWTheme,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h(context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  text.loanPending,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(.8),
                                    fontSize: 12.w(context),
                                  ),
                                ),
                                Text(
                                  "B/. ${product.pendingAmount?.priceFormat}",
                                  style: TextStyle(
                                    fontSize: 16.w(context),
                                    color: Colors.white,
                                    fontWeight: FontWeightEnum.SemiBold.fWTheme,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  text.loanOriginal,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(.8),
                                    fontSize: 12.w(context),
                                  ),
                                ),
                                Text(
                                  "B/. ${product.originalAmount?.priceFormat}",
                                  style: TextStyle(
                                    fontSize: 16.w(context),
                                    color: Colors.white,
                                    fontWeight: FontWeightEnum.SemiBold.fWTheme,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h(context)),
                      LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(84),
                        minHeight: 10,
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
                          color: color0B5A8A,
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
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 15.h(context),
                  horizontal: 32.w(context),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text.loanRate,
                      style: TextStyle(
                        color: color506578,
                        fontSize: 14.w(context),
                      ),
                    ),
                    Text(
                      "${product.anualInterestRate?.priceFormat}%",
                      style: TextStyle(
                        color: color043371,
                        fontWeight: FontWeightEnum.Bold.fWTheme,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
