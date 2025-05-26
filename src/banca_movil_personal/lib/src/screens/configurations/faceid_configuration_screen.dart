import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart';
import 'package:ca_mobile/src/screens/configurations/faceid_completed_screen.dart';
import 'package:flutter/material.dart';

class FaceIdConfigurationScreen extends StatefulWidget {
  const FaceIdConfigurationScreen({super.key});
  static const String routeName = '/FaceIdConfigurationScreen';

  @override
  State<FaceIdConfigurationScreen> createState() =>
      _FaceIdConfigurationScreenState();
}

class _FaceIdConfigurationScreenState extends State<FaceIdConfigurationScreen> {
  bool faceIdEnable = false;

  @override
  void initState() {
    faceIdEnable = preferences.uFaceIdEnabled;
    super.initState();
  }

  // List<LanguajesModel> list = [
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: colorD5D5D5,
        title: Text(text.faceidConfigurationScreenTitile),
        leading: IconButton(
          onPressed: context.pop,
          icon: Image(
            width: 30.w(context),
            image: AssetImage(AppImages.backBtn),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 26.w(context),
          vertical: 30.h(context),
        ),
        child: Column(
          children: [
            Text(
              text.faceidConfigurationScreenDescription,
              style: TextStyle(
                fontSize: 14.w(context),
                fontWeight: FontWeightEnum.SemiBold.fWTheme,
                color: color07355E,
              ),
            ),
            SizedBox(
              height: 16.h(context),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: color0051990A,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 16),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 16.h(context)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            text.faceIdLabel,
                            style: TextStyle(
                              fontSize: 14.w(context),
                              color: color07355E,
                              fontWeight: FontWeightEnum.Bold.fWTheme,
                            ),
                          ),
                          Switch.adaptive(
                            value: faceIdEnable,
                            onChanged: (value) async {
                              if (!faceIdEnable) {
                                final validate =
                                    await BiometricAuth.authenticate;

                                if (!validate) return;
                              }
                              preferences.setFaceIdEnabled(value);

                              setState(() {
                                faceIdEnable = value;
                              });
                              if (faceIdEnable) {
                                preferences
                                    .setUsuarioFaceID(preferences.uUsuario);
                                context.pushNamedAndRemoveUntil(
                                    FaceIdCompletedScreen.routeName);
                              } else {
                                preferences.setUsuarioFaceID("");
                              }
                            },
                            trackOutlineColor: WidgetStateColor.resolveWith(
                              (states) {
                                return color506578;
                              },
                            ),
                            trackColor: WidgetStateColor.resolveWith(
                              (states) {
                                if (states.contains(MaterialState.selected)) {
                                  return color005199;
                                }
                                return color506578;
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: color07355E1A,
                    ),
                    Text(
                      text.faceIdDisclaimer,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 12.w(context),
                        color: color506578,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
