import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart'
    show AppLocalizations;

import 'package:flutter/material.dart';

import 'scan_document_screen.dart';

class ScanFaceScreen extends StatelessWidget {
  static const String routeName = '/ScanFaceScreen';

  const ScanFaceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: Image(
            width: 30.w(context),
            image: AssetImage(AppImages.backBtn),
          ),
        ),
        title: Text('${text?.scanFaceTitle}'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w(context),
          vertical: 12.h(context),
        ),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Text(
              '${text?.scanFaceMessage}',
              style: TextStyle(
                fontSize: 14.w(context),
                color: color51708E,
              ),
            ),
            SizedBox(height: 34.h(context)),
            Image(
              height: 250.h(context),
              width: 250.w(context),
              image: AssetImage(AppImages.scanFace),
            ),
            SizedBox(height: 20.h(context)),
            Container(
              padding: EdgeInsets.all(20.w(context)),
              decoration: BoxDecoration(
                color: colorF9FAFB,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${text?.recomendation}',
                    style: TextStyle(
                      fontSize: 18.w(context),
                      color: color07355E,
                      fontWeight: FontWeightEnum.Medium.fWTheme,
                    ),
                  ),
                  SizedBox(height: 14.h(context)),
                  _recomendationItem(
                    context,
                    "${text?.useLightPlace}",
                    AppImages.light,
                  ),
                  SizedBox(height: 14.h(context)),
                  _recomendationItem(
                    context,
                    "${text?.seeCamera}",
                    AppImages.eye,
                  ),
                  SizedBox(height: 14.h(context)),
                  _recomendationItem(
                    context,
                    "${text?.noUsingCap}",
                    AppImages.cap,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h(context)),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ScanDocumentScreen.routeName);
              },
              child: Text("${text?.btnCapture}"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recomendationItem(
    BuildContext context,
    String title,
    String iconPath,
  ) {
    return Row(
      children: [
        Image(
          width: 35.w(context),
          image: AssetImage(iconPath),
        ),
        SizedBox(width: 33.w(context)),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.w(context),
              color: color07355E,
            ),
          ),
        ),
      ],
    );
  }
}
