// ignore_for_file: deprecated_member_use

import 'package:banca_movil_comercial/src/extensions/navigator.dart';
import 'package:banca_movil_comercial/src/localization/app_localizations.dart';
import 'package:banca_movil_libs/extensions/sizer.dart';
import 'package:banca_movil_libs/themes/app_images.dart';
import 'package:banca_movil_libs/themes/colors.dart';
import 'package:banca_movil_libs/themes/themes.dart';
import 'package:flutter/material.dart';

import '../authentication/scan_face_screen.dart';

Future<dynamic> modalContacts(BuildContext context, AppLocalizations? text) {
  return showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    useSafeArea: true,
    isScrollControlled: true,
    constraints: BoxConstraints(maxWidth: isTablet ? 800.w(context) : 430),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: isTablet ? Radius.circular(30) : Radius.circular(20),
      ),
    ),
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 125.h(context) : 56.w(context),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 30.h(context)),

                Text(
                  "${text?.modalTitle}",
                  style: TextStyle(
                    color: color07355E,
                    fontSize: isTablet ? 20.w(context) : 16.w(context),
                    fontWeight: FontWeightEnum.Medium.fWTheme,
                  ),
                ),
                SizedBox(height: 60.h(context)),

                // Opciones de contacto
                GridView.count(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.9,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage(AppImages.callCenterIconPath),
                            height: isTablet ? 24.w(context) : 20,
                            width: isTablet ? 24.w(context) : 20,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${text?.modalCallCenter}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: color07355E,
                              fontSize:
                                  isTablet ? 17.w(context) : 14.w(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage(AppImages.andreaChatIconPath),
                            height: isTablet ? 24.w(context) : 20,
                            width: isTablet ? 24.w(context) : 20,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${text?.modalChatAndrea}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: color07355E,
                              fontSize:
                                  isTablet ? 17.w(context) : 14.w(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage(AppImages.lossCardIconPath),
                            height: isTablet ? 24.w(context) : 20,
                            width: isTablet ? 24.w(context) : 20,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${text?.modalLossTarget}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: color07355E,
                              fontSize:
                                  isTablet ? 17.w(context) : 14.w(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage(
                              AppImages.internationalCallIconPath,
                            ),
                            height: isTablet ? 24.w(context) : 20,
                            width: isTablet ? 24.w(context) : 20,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${text?.modalInternationalContact}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: color07355E,
                              fontSize:
                                  isTablet ? 17.w(context) : 14.w(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h(context)),
          Divider(),
          _bottomWidget(context),
          SizedBox(height: isTablet ? 10.h(context) : 0),
        ],
      );
    },
  );
}

Widget _bottomWidget(BuildContext context) {
  final text = AppLocalizations.of(context);
  return Container(
    height: 100.h(context),
    padding: EdgeInsets.symmetric(vertical: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Contacto
        _bottomOption(
          context,
          text: "${text?.contact}",
          iconPath: AppImages.contactIconPath,
          onTap: context.pop,
          color: color0080F2,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: isTablet ? 25 : 8),
          child: VerticalDivider(color: color07355E.withOpacity(.12)),
        ),
        // Token
        _bottomOption(
          context,
          text: "${text?.token}",
          iconPath: AppImages.tokenIconPath,
          onTap: () {},
        ),

        Padding(
          padding: EdgeInsets.symmetric(vertical: isTablet ? 25 : 8),
          child: VerticalDivider(color: color07355E.withOpacity(.12)),
        ),
        // New User
        _bottomOption(
          context,
          text: "${text?.newUser}",
          iconPath: AppImages.userIconPath,
          onTap: () {
            context.pop();
            context.pushNamed(ScanFaceScreen.routeName);
          },
        ),
      ],
    ),
  );
}

Widget _bottomOption(
  BuildContext context, {
  required String text,
  required VoidCallback onTap,
  required String iconPath,
  Color? color,
}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image(
          image: AssetImage(iconPath),
          color: color ?? color07355E,
          height: isTablet ? 25.w(context) : 20,
          width: isTablet ? 25.w(context) : 20,
        ),
        SizedBox(height: 4.w(context)),
        Text(
          text,
          style: TextStyle(
            fontSize: isTablet ? 18.w(context) : 14.w(context),
            color: color ?? color07355E,
          ),
        ),
      ],
    ),
  );
}
