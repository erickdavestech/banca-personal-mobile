import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart';
import 'package:ca_mobile/src/screens/main/tabs_screen.dart';
import 'package:flutter/material.dart';

class FaceIdCompletedScreen extends StatefulWidget {
  const FaceIdCompletedScreen({super.key});
  static const String routeName = '/FaceIdCompletedScreen';

  @override
  State<FaceIdCompletedScreen> createState() => _FaceIdCompletedScreenState();
}

class _FaceIdCompletedScreenState extends State<FaceIdCompletedScreen> {
  bool faceIdEnable = false;
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/images/icon_border.png",
                      width: 155.w(context),
                    ),
                    Container(
                      width: 85.w(context),
                      height: 85.h(context),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color0080F2.withOpacity(0.20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color0080F2,
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 32.h(context),
                ),
                Text(
                  text.ready,
                  style: TextStyle(
                    fontSize: 14.w(context),
                    color: color06243E,
                    fontWeight: FontWeightEnum.Bold.fWTheme,
                  ),
                ),
                SizedBox(
                  height: 5.h(context),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 61.w(context)),
                  child: Text(
                    text.faceIdCompleted,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.w(context),
                      color: color506578,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
              onPressed: () {
                context.pushNamedAndRemoveUntil(TabsScreen.routeName);
              },
              child: Text(text.productTransferButton),
            ),
          ),
          SizedBox(
            height: 48.h(context),
          ),
        ],
      ),
    );
  }
}
