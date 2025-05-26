import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:ca_mobile/src/bloc/login_bloc/login_bloc.dart';

import 'package:ca_mobile/src/localization/app_localizations.dart'
    show AppLocalizations;
import 'package:ca_mobile/src/screens/configurations/faceid_configuration_screen.dart';
import 'package:ca_mobile/src/screens/languaje/languaje_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomMainDrawer extends StatelessWidget {
  const CustomMainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Drawer(
      backgroundColor: Colors.white,
      width: isTablet ? 390.w(context) : 331.w(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
      ),
      child: ListTileTheme(
        data: ListTileThemeData(
          contentPadding: EdgeInsets.zero,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w(context)),
          child: SafeArea(
            child: Column(
              children: [
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginSuccess) {
                      return Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color8FB1ED,
                            ),
                            child: Center(
                              child: Text(
                                preferences.uName.substring(0, 1).toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeightEnum.SemiBold.fWTheme,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // "${state.user.user?.name}",
                                preferences.uName.capitalize,
                                style: TextStyle(
                                  fontWeight: FontWeightEnum.SemiBold.fWTheme,
                                  fontSize: 16.w(context),
                                  color: color07355E,
                                ),
                              ),
                              Text(
                                text.mainDrawerDataTitle,
                                style: TextStyle(
                                  color: color07355E,
                                  fontSize: 14.w(context),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                SizedBox(height: isTablet ? 20.w(context) : 10.h(context)),
                Divider(
                  color: Colors.grey.withOpacity(0.5),
                ),
                SizedBox(height: isTablet ? 20.w(context) : 10.h(context)),
                _menuOption(context,
                    text: text.mainDrawerNotifications,
                    onTap: () {},
                    iconPath: AppImages.notifications),
                SizedBox(height: isTablet ? 15.w(context) : 0),
                _menuOption(context,
                    text: text.mainDraweToken,
                    onTap: () {},
                    iconPath: AppImages.tokenIconPath),
                SizedBox(height: isTablet ? 15.w(context) : 0),
                _menuOption(context,
                    text: text.mainDraweBiometry,
                    onTap: () {},
                    iconPath: AppImages.biometryIcon),
                SizedBox(height: isTablet ? 15.w(context) : 0),
                _menuOption(context,
                    text: text.mainDraweLanguage,
                    onTap: () => context.pushNamed(LanguajeScreen.routeName),
                    iconPath: AppImages.languageIcon),
                SizedBox(height: isTablet ? 15.w(context) : 0),
                _menuOption(context,
                    text: text.mainDrawerBeneficiary,
                    onTap: () {},
                    iconPath: AppImages.beneficiaries),
                SizedBox(height: isTablet ? 15.w(context) : 0),
                _menuOption(context,
                    text: text.mainDraweCards,
                    onTap: () {},
                    iconPath: AppImages.lossCardIconPath),
                SizedBox(height: isTablet ? 15.w(context) : 0),
                _menuOption(context,
                    text: text.mainDrawePreferredAccount,
                    onTap: () {},
                    iconPath: AppImages.preferredAcountIcon),
                SizedBox(height: isTablet ? 15.w(context) : 0),
                _menuOption(context,
                    text: text.mainDraweSettings,
                    onTap: () {},
                    iconPath: AppImages.settingsIcon),
                SizedBox(height: isTablet ? 15.w(context) : 0),
                _menuOption(context,
                    text: text.mainDraweQuickAccess,
                    onTap: () =>
                        context.pushNamed(FaceIdConfigurationScreen.routeName),
                    iconPath: AppImages.quickAccessIcon),
                SizedBox(height: isTablet ? 15.w(context) : 0),
                _menuOption(context,
                    text: text.mainDraweFindUs,
                    onTap: () {},
                    iconPath: AppImages.findUsIcon),
                SizedBox(height: isTablet ? 15.w(context) : 0),
                _menuOption(context,
                    text: text.mainDraweUserService,
                    onTap: () {},
                    iconPath: AppImages.callCenterIconPath),
                SizedBox(height: isTablet ? 15.w(context) : 0),
                _menuOption(context,
                    text: text.mainDraweTermsConditions,
                    onTap: () {},
                    iconPath: AppImages.terminosCondicionesIcon),
                Spacer(),
                Divider(
                  color: Colors.grey.withOpacity(0.5),
                ),
                SizedBox(height: 20),
                Text(
                  "${text.version} 0.1.0",
                  style: TextStyle(
                    color: color07355E.withOpacity(.8),
                    fontSize: 12.w(context),
                  ),
                ),
                SizedBox(height: isTablet ? 35 : 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuOption(
    BuildContext context, {
    required String text,
    required VoidCallback onTap,
    required String iconPath,
  }) {
    return GestureDetector(
      onTap: () {
        context.pop();
        onTap();
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(bottom: 32.h(context)),
        child: Row(
          children: [
            Image(
              image: AssetImage(iconPath),
              height: isTablet ? 30.h(context) : 20.h(context),
              width: isTablet ? 30.w(context) : 20.w(context),
            ),
            SizedBox(width: 20.w(context)),
            Text(
              text,
              style: TextStyle(
                color: color07355E,
                fontSize: isTablet ? 16.w(context) : 14.w(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
