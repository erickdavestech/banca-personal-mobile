import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FixedTermCard extends StatelessWidget {
  const FixedTermCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    double calcularProgreso(DateTime inicio, DateTime fin) {
      final ahora = DateTime.now();
      if (ahora.isBefore(inicio)) return 0.0;
      if (ahora.isAfter(fin)) return 1.0;

      final totalDuracionDias = fin.difference(inicio).inSeconds;
      final progresoDias = ahora.difference(inicio).inSeconds;

      return progresoDias / totalDuracionDias;
    }

    final progressIndicator =
        calcularProgreso(product.startDate!, product.expireDate!);

    return Column(
      children: [
        Stack(children: [
          Container(
            margin: EdgeInsets.only(top: 20.h(context)),
            decoration: BoxDecoration(
              color: color064479.withOpacity(.06),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: color07355E,
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          AppImages.dpfBackground,
                          package: "banca_movil_libs",
                        ),
                      )),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 32.h(context),
                      horizontal: 28.w(context),
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
                                    text.fixedTermMonto,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(.8),
                                      fontSize: 12.w(context),
                                    ),
                                  ),
                                  Text(
                                    "B/. ${product.originalAmount?.priceFormat ?? "0.00"}",
                                    style: TextStyle(
                                      fontSize: 16.w(context),
                                      color: Colors.white,
                                      fontWeight:
                                          FontWeightEnum.SemiBold.fWTheme,
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
                                    text.fixedTermAssociatedAccount,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(.8),
                                      fontSize: 12.w(context),
                                    ),
                                  ),
                                  Text(
                                    "*${product.associatedAccount?.obtenerUltimosDigitos}",
                                    style: TextStyle(
                                      fontSize: 16.w(context),
                                      color: Colors.white,
                                      fontWeight:
                                          FontWeightEnum.SemiBold.fWTheme,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 14.h(context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    text.fixedTermStartDate,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(.8),
                                      fontSize: 12.w(context),
                                    ),
                                  ),
                                  Text(
                                    DateFormat("dd MMM yyyy").format(
                                        product.startDate ?? DateTime.now()),
                                    style: TextStyle(
                                      fontSize: 16.w(context),
                                      color: Colors.white,
                                      fontWeight:
                                          FontWeightEnum.SemiBold.fWTheme,
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
                                    text.fixedTermExpireDate,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(.8),
                                      fontSize: 12.w(context),
                                    ),
                                  ),
                                  Text(
                                    DateFormat("dd MMM yyyy").format(
                                        product.expireDate ?? DateTime.now()),
                                    style: TextStyle(
                                      fontSize: 16.w(context),
                                      color: Colors.white,
                                      fontWeight:
                                          FontWeightEnum.SemiBold.fWTheme,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 14.h(context),
                        ),
                        LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(84),
                          minHeight: 10,
                          value: progressIndicator,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          backgroundColor: Colors.white.withOpacity(.17),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 15.h(context), horizontal: 32.w(context)),
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
                        "${product.anualRate?.priceFormat}%",
                        style: TextStyle(
                          color: color005199,
                          fontWeight: FontWeightEnum.Bold.fWTheme,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ],
    );
  }
}
