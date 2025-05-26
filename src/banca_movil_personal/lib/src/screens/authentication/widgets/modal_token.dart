//import 'dart:developer';

import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart'
    show AppLocalizations;
import 'package:ca_mobile/src/screens/authentication/scan_face_screen.dart';
import 'package:ca_mobile/src/screens/authentication/widgets/modal_more_options_token.dart';
// ignore: unused_import
import 'package:ca_mobile/src/extensions/navigator.dart';
import 'package:ca_mobile/src/screens/authentication/widgets/shared_modal_widget.dart';
import 'package:flutter/services.dart';

void showTokenModal(BuildContext context) {
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
            padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 12.h(context)),
                modalHandle(context),
                SizedBox(height: 24.h(context)),
                Text(
                  text.tokenNumber,
                  style: TextStyle(
                    fontSize: 16.w(context),
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF07355E),
                  ),
                ),
                SizedBox(height: 24.h(context)),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Stack(
                    children: [
                      _Indicator(
                        initialSeconds: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h(context), horizontal: 20.w(context)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '1234 5678',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 26.w(context).clamp(18.0, 28.0),
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF07355E),
                                    letterSpacing: 7.0,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                Clipboard.setData(
                                    ClipboardData(text: '1234 5678'));
                              },
                              child: Icon(
                                Icons.copy_outlined,
                                size: 24.w(context),
                                color: Color(0xFF757581),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h(context)),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    text.generateNewToken,
                    style: TextStyle(
                      fontSize: 14.w(context),
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0080F2),
                    ),
                  ),
                ),
                SizedBox(height: 10.h(context)),
                Container(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFCDD7E1), width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    dense: true,
                    minVerticalPadding: 8.h(context),
                    contentPadding: EdgeInsets.only(
                        left: 25.w(context), right: 12.w(context)),
                    title: Text(
                      text.moreOptions,
                      style: TextStyle(
                        color: Color(0xFF506578),
                        fontSize: 14.w(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16.w(context),
                      color: Color(0xFF506578),
                    ),
                    onTap: () {
                      showMoreOptionsTokenModal(context);
                    },
                  ),
                ),
                SizedBox(height: 20.h(context)),
                Padding(
                  padding: EdgeInsets.only(
                    top: 12.h(context),
                    bottom: 20.h(context),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 18.w(context),
                        color: color1C274C.withOpacity(0.4),
                      ),
                      SizedBox(width: 8.w(context)),
                      Expanded(
                        child: Text(
                          text.tokenNotice,
                          style: TextStyle(
                            fontSize: 12.w(context),
                            color: color1C274C.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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

class _Indicator extends StatefulWidget {
  final int initialSeconds;

  const _Indicator({required this.initialSeconds});
  @override
  State<_Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<_Indicator>
    with SingleTickerProviderStateMixin {
  static const int _totalSeconds = 60;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();

    double startValue = 1.0 - (widget.initialSeconds / _totalSeconds);

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _totalSeconds),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.forward(from: 0.0); // reinicia automáticamente
        }
      });

    _controller.forward(from: startValue); // ⬅️ Arranca desde tu valor
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          double progress = 1.0 - _controller.value;
          return LinearProgressIndicator(
            // value: progress,
            value: progress,
            borderRadius: BorderRadius.circular(7),
            minHeight: 65.h(context),
            backgroundColor: const Color(0xFFF6F9FC),
            valueColor:
                AlwaysStoppedAnimation<Color>(color005199.withOpacity(.12)),
          );
        });
  }
}
