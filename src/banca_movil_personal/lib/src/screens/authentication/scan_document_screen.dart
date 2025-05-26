import 'dart:math';

import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart'
    show AppLocalizations;
import 'package:flutter/material.dart';

class ScanDocumentScreen extends StatefulWidget {
  static const String routeName = '/ScanDocumentScreen';

  const ScanDocumentScreen({super.key});

  @override
  State<ScanDocumentScreen> createState() => _ScanDocumentScreenState();
}

class _ScanDocumentScreenState extends State<ScanDocumentScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _flipAnimation = Tween<double>(
            begin: 0, end: 3.14159) // 180 degrees in radians
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flip() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

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
        title: Text('${text?.scanDocumentTitle}'),
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
              '${text?.scanDocumentMessage}',
              style: TextStyle(
                fontSize: 14.w(context),
                color: color51708E,
              ),
            ),
            SizedBox(height: 44.h(context)),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(_flipAnimation.value),
                child: Stack(
                  children: [
                    // Widget que se muestra cuando está "en el frente"
                    _flipAnimation.value < pi / 2
                        ? Image(
                            width: double.infinity,
                            height: 210.h(context),
                            image: AssetImage(AppImages.cedulaFrente),
                            fit: BoxFit.fill,
                          )
                        : SizedBox(
                            width: double.infinity,
                            height: 210.h(context),
                          ),
                    // Widget que se muestra cuando está "en el reverso"
                    _flipAnimation.value >= pi / 2
                        ? Image(
                            width: double.infinity,
                            height: 210.h(context),
                            image: AssetImage(AppImages.cedulaDorso),
                            fit: BoxFit.fill,
                          )
                        : SizedBox(
                            width: double.infinity,
                            height: 210.h(context),
                          ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.h(context)),
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
                    "${text?.documentMustBeLegible}",
                    AppImages.eye,
                  ),
                  SizedBox(height: 14.h(context)),
                  _recomendationItem(
                    context,
                    "${text?.noUsingItems}",
                    AppImages.cap,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h(context)),
            ElevatedButton(
              onPressed: () {
                _flip();
              },
              child: Text("${text?.btnTakePhoto}"),
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
