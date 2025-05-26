import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart'
    show AppLocalizations;

import 'package:flutter/material.dart';


class ScanFaceTokenActivationScreen extends StatefulWidget {
  static const String routeName = '/ScanFaceTokenActivationScreen';

  const ScanFaceTokenActivationScreen({super.key});

  @override
  State<ScanFaceTokenActivationScreen> createState() =>
      _ScanFaceTokenActivationScreenState();
}

class _ScanFaceTokenActivationScreenState
    extends State<ScanFaceTokenActivationScreen> {
  bool _termsAndConditions = false;
  bool _biometricData = false;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: colorD5D5D5,
        excludeHeaderSemantics: true,
        title: Container(
          child: Column(
            children: [
              Text(
                text?.activateToken ?? "",
                style: TextStyle(
                  fontSize: 16.w(context),
                  fontWeight: FontWeightEnum.SemiBold.fWTheme,
                ),
              ),
            ],
          ),
        ),
        leading: IconButton(
          onPressed: context.pop,
          icon: Image(
            width: 22.w(context),
            image: AssetImage(AppImages.backBtn),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w(context),
          vertical: 12.h(context),
        ),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            SizedBox(
              height: 18.h(context),
            ),
            Text(
              '${text?.activateTokenDescription}',
              style: TextStyle(
                fontSize: 14.w(context),
                color: color07355E,
                fontWeight: FontWeightEnum.SemiBold.fWTheme,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 65.h(context)),
              child: Image(
                height: 280.h(context),
                width: 280.w(context),
                image: AssetImage(AppImages.scanFace),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Divider(),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      minVerticalPadding: 0,
                      horizontalTitleGap: 2,
                      dense: true,
                      minLeadingWidth: 0,
                      titleAlignment: ListTileTitleAlignment.top,
                      onTap: () => setState(() {
                        _termsAndConditions = !_termsAndConditions;
                      }),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 12.w(context),
                        ),
                      ),
                      leading: Checkbox.adaptive(
                        activeColor: color0080F2,
                        value: _termsAndConditions,
                        onChanged: (value) => setState(() {
                          _termsAndConditions = !_termsAndConditions;
                        }),
                      ),
                      title: Text(
                        text?.faceScreenTokenActivationScreenTerms ?? "",
                        style: TextStyle(
                          fontSize: 14.w(context),
                          color: color506578,
                        ),
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Divider(),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      minVerticalPadding: 0,
                      horizontalTitleGap: 2,
                      dense: true,
                      minLeadingWidth: 0,
                      titleAlignment: ListTileTitleAlignment.top,
                      onTap: () => setState(() {
                        _biometricData = !_biometricData;
                      }),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 12.w(context),
                        ),
                      ),
                      leading: Checkbox.adaptive(
                        activeColor: color0080F2,
                        value: _biometricData,
                        onChanged: (value) => setState(() {
                          _biometricData = !_biometricData;
                        }),
                      ),
                      title: Text(
                        text?.faceScreenTokenActivationScreenData ?? "",
                        style: TextStyle(
                          fontSize: 14.w(context),
                          color: color506578,
                        ),
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.h(context),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w(context)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: colorD5D5D5,
                ),
                onPressed: _termsAndConditions && _biometricData
                    ? () {
                        print("klk");
                      }
                    : null,
                child: Text("${text?.productTransferButton}"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
