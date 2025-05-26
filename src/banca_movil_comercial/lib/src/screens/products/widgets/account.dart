// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:banca_movil_comercial/src/localization/app_localizations.dart';
import 'package:banca_movil_comercial/src/screens/products/widgets/modal_card_data.dart';
import 'package:banca_movil_comercial/src/screens/products/widgets/validatior_screen.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  final Product product;

  const Account({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context);
    final card = product.associatedDebitCards?.where(
      (element) => element.cardStatus == 1,
    );
    return Container(
      decoration: BoxDecoration(
        color: color064479.withOpacity(.06),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 170.h(context),
            width: double.infinity,
            decoration: BoxDecoration(
              color: card?.firstOrNull == null ? color1370C2 : color043371,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 25.h(context),
                    horizontal: 32.w(context),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (card?.firstOrNull != null)
                        Row(
                          children: [
                            Image(
                              image: AssetImage(AppImages.caAppBar),
                              width: 36.w(context),
                              height: 36.w(context),
                            ),
                            SizedBox(width: 10.w(context)),
                            Text.rich(
                              TextSpan(
                                text: '${text?.debitCard}',
                                style: TextStyle(
                                  color: colorF9FAFB,
                                  fontSize: 14.w(context),
                                  fontWeight: FontWeightEnum.SemiBold.fWTheme,
                                ),
                                children: [
                                  // TextSpan(
                                  //   text: 'Ahorro para boda',
                                  //   style: TextStyle(
                                  //     color: colorF9FAFB,
                                  //     fontSize: 14.w(context),
                                  //     fontWeight: FontWeightEnum.Thin.fWTheme,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      Spacer(),
                      Text(
                        "${text?.available}",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.w(context),
                        ),
                      ),
                      Text(
                        "B/. ${num.parse(product.available ?? '0').priceFormat}",
                        style: TextStyle(
                          fontSize: 20.w(context),
                          color: Colors.white,
                          fontWeight: FontWeightEnum.SemiBold.fWTheme,
                        ),
                      ),
                    ],
                  ),
                ),
                if (card?.firstOrNull != null)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.all(22.w(context)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "*${card?.firstOrNull?.cardNumber.obtenerUltimosDigitos}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.w(context),
                              fontWeight: FontWeightEnum.Medium.fWTheme,
                            ),
                          ),
                          // if (card.cardNumber.getCardType == CreditCardTypes.visa)
                          // Image(
                          //   image: AssetImage(AppImages.visa),
                          //   height: 35,
                          // ),
                          // if (card.cardNumber.getCardType ==
                          //     CreditCardTypes.mastercard)
                          Image(
                            image: AssetImage(AppImages.masterCard),
                            height: 35,
                          ),
                        ],
                      ),
                    ),
                  ),
                Positioned(
                  right: -100,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.05),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  right: -80,
                  top: 50,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.05),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // if (card?.firstOrNull != null)
          GestureDetector(
            onTap:
                card?.firstOrNull == null
                    ? null
                    : () async {
                      // if (!kDebugMode) {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        isDismissible: false,
                        enableDrag: false,
                        builder:
                            (_) =>
                                ValidandoTokenLoader(title: text!.validating),
                      );
                      await Future.delayed(const Duration(seconds: 3));
                      context.pop();
                      // }
                      showCardDataModal(context);
                    },
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15.h(context),
                horizontal: 32.w(context),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    card?.firstOrNull == null
                        ? "${text?.requestDebitCard}"
                        : "${text?.btnCardInfoLine}",
                    style: TextStyle(
                      color: color506578,
                      fontSize: 14.w(context),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 18.w(context)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
