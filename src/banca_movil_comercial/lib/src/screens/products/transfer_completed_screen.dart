import 'package:banca_movil_comercial/src/localization/app_localizations.dart';
import 'package:banca_movil_comercial/src/screens/main/tabs_screen.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransferCompletedScreen extends StatelessWidget {
  static const String routeName = '/transfer-completed';

  const TransferCompletedScreen({super.key});

  Widget _buildListTile(
    String title,
    String accountType,
    String line1,
    String line2,
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 0),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.w(context),
                      color: color506578,
                    ),
                  ),
                  Text(
                    accountType,
                    style: TextStyle(
                      color: color506578,
                      fontSize: 12.w(context),
                    ),
                  ),
                ],
              ),
              Text(
                line1,
                maxLines: 1,
                style: TextStyle(
                  color: color07355E,
                  fontSize: 14.w(context),
                  fontWeight: FontWeightEnum.SemiBold.fWTheme,
                ),
              ),
              Text(
                line2,
                maxLines: 2,
                style: TextStyle(
                  color: color07355E,
                  fontSize: 14.w(context),
                  fontWeight: FontWeightEnum.SemiBold.fWTheme,
                ),
              ),
            ],
          ),
          SizedBox(height: 26.h(context)),
          Divider(color: color07355E26),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final content = ModalRoute.of(context)?.settings.arguments as Map;
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey.withOpacity(0.05),
              Colors.white.withOpacity(1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.50],
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: color043371,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              height: size.height * .30,
            ),
            Positioned(
              top: -20.h(context),
              right: -5.w(context),
              child: Container(
                width: 223.w(context),
                height: 262.h(context),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(.14),
                      Colors.white.withOpacity(.005),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 0.45],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -40.h(context),
              right: -20.w(context),
              child: Container(
                width: 176.w(context),
                height: 325.h(context),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(.14),
                      Colors.white.withOpacity(.005),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 0.45],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 22,
              right: 22,
              child: Container(
                height: size.height * 0.78,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          const SizedBox(height: 65),
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            child: Text(
                              text.amountTransferred,
                              style: TextStyle(
                                fontSize: 14.w(context),
                                color: color06243E,
                                fontWeight: FontWeightEnum.Bold.fWTheme,
                              ),
                            ),
                          ),
                          Text(
                            "B/. ${num.parse(content["amount"].toString()).priceFormat}",
                            style: TextStyle(
                              fontSize: 24.w(context),
                              fontWeight: FontWeightEnum.Bold.fWTheme,
                              color: color043371,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: Text(
                              // "Martes, 21 de enero 2025",
                              DateFormat.yMMMMEEEEd(
                                preferences.uLanguaje,
                              ).format(DateTime.now()).capitalizeSentences,
                              style: TextStyle(
                                fontSize: 14.w(context),
                                color: color06243E,
                              ),
                            ),
                          ),

                          // IntrinsicWidth(
                          //   child: Container(
                          //     padding: const EdgeInsets.symmetric(
                          //       vertical: 4,
                          //       horizontal: 16,
                          //     ),
                          //     margin: const EdgeInsets.symmetric(vertical: 6),
                          //     alignment: Alignment.center,
                          //     decoration: BoxDecoration(
                          //       color: color0080F22B,
                          //       borderRadius: BorderRadius.circular(3),
                          //     ),
                          //     child: Text(
                          //       "ACH Xpress",
                          //       textAlign: TextAlign.center,
                          //       style: TextStyle(
                          //         fontSize: 12.w(context),
                          //         color: color043371,
                          //         fontWeight: FontWeightEnum.Bold.fWTheme,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 4.h(context)),
                          Divider(color: color07355E26),
                          _buildListTile(
                            "Cuenta origen:",
                            content["sourceDescription"] ?? "",
                            // "Cuenta de ahorros",
                            content["sourceName"] ?? "",

                            // "Ahorro para boda",
                            content["sourceAccount"] ?? "",

                            // "207265344",
                            context,
                          ),
                          _buildListTile(
                            "Cuenta destino:",
                            // "Cuenta Corriente",
                            content["destinationDescription"] ?? "",
                            // "Stalin Bienvenido Rivas López",
                            content["destinationName"] ?? "",
                            // "20156751 | Banco Viejo",
                            content["destinationAccount"] ?? "",
                            context,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  child: Text(
                                    text.comment,
                                    style: TextStyle(
                                      fontSize: 14.w(context),
                                      color: color506578,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    content["description"] ?? "",
                                    textAlign: TextAlign.right,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: color07355E,
                                      fontSize: 14.w(context),
                                      fontWeight:
                                          FontWeightEnum.SemiBold.fWTheme,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(text.share),
                          ),
                          SizedBox(height: 12.h(context)),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pushReplacementNamed(TabsScreen.routeName);
                            },
                            child: Text(text.goToHome),
                          ),
                          SizedBox(height: 26.h(context)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.07,
              child: Container(
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(AppImages.appTitle),
                      width: size.width * 0.40,
                    ),
                    SizedBox(height: 20.h(context)),
                    Text(
                      text.transferCompleted,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.w(context),
                        fontWeight: FontWeightEnum.Bold.fWTheme,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: (size.height * 0.78) - 57.5,
              left: 0,
              right: 0,
              child: Container(
                width: 115,
                height: 115,
                padding: const EdgeInsets.all(27.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color0080F2.withOpacity(0.20),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color0080F2,
                  ),
                  child: Icon(Icons.check, color: Colors.white, size: 45),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
