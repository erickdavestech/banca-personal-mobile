import 'package:banca_movil_comercial/src/localization/app_localizations.dart';
import 'package:banca_movil_comercial/src/screens/authentication/widgets/error_banner.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocalizationHelper {
  static void getErrorMessage(BuildContext context, String key) {
    final localizations = AppLocalizations.of(context)!;

    String title;
    String message;
    Widget iconWidget;
    bool isBlockedUser = false;

    switch (key) {
      case "shared.blocked_account":
        title = localizations.blockedUserTitleDialog;
        message = localizations.blockedUserMessageDialog;
        iconWidget = Image.asset(
          AppImages.lockPassword,
          height: 30,
          width: 30,
          color: Colors.white,
        );
        isBlockedUser = true;
        break;

      case "shared.wrong_login_message":
        title = localizations.wrongLoginTitleDialog;
        message = "${localizations.wrongLoginTop}\n";
        iconWidget = Image.asset(AppImages.dangerIcon, height: 30, width: 30);
        break;

      default:
        title = localizations.unexpectedErrorTitle;
        message = localizations.defaultUnexpectedErrorMessage;
        iconWidget = Image.asset(AppImages.dangerIcon, height: 30, width: 30);
        break;
    }

    showCustomDialog(context, title, message, iconWidget, isBlockedUser);
  }
}

void showCustomDialog(
  BuildContext context,
  String title,
  String message,
  Widget iconWidget,
  bool isBlockedUser,
) {
  final text = AppLocalizations.of(context)!;
  showDialog(
    context: context,
    builder:
        (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 115.w(context),
                  height: 115.w(context),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color0080F2.withOpacity(0.2),
                  ),
                  child: Center(
                    child: Container(
                      width: 71.w(context),
                      height: 71.w(context),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color0080F2,
                      ),
                      child: Center(child: iconWidget),
                    ),
                  ),
                ),
                SizedBox(height: 25.h(context)),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: 18.w(context),
                    fontWeight: FontWeightEnum.ExtraBold.fWTheme,
                    color: color07355E,
                  ),

                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 11.h(context)),
                Text(
                  style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: 14.w(context),
                    color: color07355E,
                    fontWeight: FontWeightEnum.ExtraLight.fWTheme,
                  ),
                  message,
                  textAlign: TextAlign.center,
                ),
                if (!isBlockedUser) ...[
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: 14.w(context),
                        color: color07355E,
                        fontWeight: FontWeightEnum.ExtraLight.fWTheme,
                      ),
                      children: [
                        TextSpan(text: '${text.recoveryMessage} '),
                        TextSpan(
                          text: text.recoveryLink,
                          style: TextStyle(
                            color: color043371,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeightEnum.Bold.fWTheme,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () => {},
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: 20.h(context)),
                ElevatedButton(
                  onPressed: context.pop,
                  child: Text(isBlockedUser ? text.close : text.ok),
                ),
              ],
            ),
          ),
        ),
  );
}

void showTopSnackBar(BuildContext context, {String? message}) {
  final localizations = AppLocalizations.of(context)!;
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder:
        (context) => Positioned(
          top: MediaQuery.of(context).padding.top + 16,
          left: 16,
          right: 16,
          child: ErrorBanner(
            title: localizations.unexpectedErrorTitle,
            message: message ?? localizations.defaultUnexpectedErrorMessage,
            onClose: () {},
          ),
        ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
