import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:ca_mobile/src/screens/authentication/scan_face_token_activation_screen.dart';
import 'package:flutter/material.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart'
    show AppLocalizations;
import 'package:ca_mobile/src/screens/authentication/widgets/shared_modal_widget.dart';
import 'package:ca_mobile/src/screens/authentication/scan_face_screen.dart';

void showActivateTokenModal(BuildContext context) {
  final text = AppLocalizations.of(context)!;

  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.59,
        maxChildSize: 0.59,
        minChildSize: 0.59,
        builder: (_, controller) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 12.h(context)),
                modalHandle(context),
                SizedBox(height: 24.h(context)),
                Text(
                  text.token,
                  style: TextStyle(
                    fontSize: 16.w(context),
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF07355E),
                  ),
                ),
                SizedBox(height: 24.h(context)),
                Image.asset(
                  'assets/images/lock-password-svgrepo-updated-com.png',
                  width: 62.w(context),
                  height: 62.w(context),
                ),
                SizedBox(height: 24.h(context)),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14.w(context),
                        color: Color(0xFF07355E),
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                            text: text.activateTokenDisclaimer
                                .split('Token Caja de Ahorros')[0]),
                        TextSpan(
                          text: 'Token Caja de Ahorros',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        TextSpan(
                            text: text.activateTokenDisclaimer
                                .split('Token Caja de Ahorros')[1]),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32.h(context)),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      context.pushNamed(
                        ScanFaceTokenActivationScreen.routeName,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color005199,
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 45.h(context)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      text.activateTokenButton,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.w(context),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 43.h(context)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    color: color07355E.withOpacity(.12),
                    thickness: 1,
                  ),
                ),
                SizedBox(height: 12.h(context)),
                bottomOptionsBar(
                  context,
                  promoText: text.drawerServicePromotion,
                  tokenText: text.token,
                  userText: text.newUser,
                  onTapPromo: () {},
                  onTapToken: () {
                    Navigator.pop(context);
                  },
                  onTapUser: () {
                    context.pushNamed(ScanFaceScreen.routeName);
                  },
                  promoIconPath: AppImages.bookmarksIconPath,
                  tokenIconPath: AppImages.tokenIconPath,
                  userIconPath: AppImages.userIconPath,
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
