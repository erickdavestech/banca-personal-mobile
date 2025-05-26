import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart';
import 'package:flutter/material.dart';

class LocalizationHelper {
  static void getErrorMessage(BuildContext context, String key) {
    final localizations = AppLocalizations.of(context)!;

    String title;
    String message;
    Widget iconWidget; // Cambiado de IconData a Widget

    switch (key) {
      case "shared.wrong_login_message":
        title = "Tus datos no coinciden";
        message = localizations.wrongLoginMessage;
        iconWidget = Image.asset(
          AppImages.dangerIcon,
          height: 30,
          width: 30,
        );
        break;
      case "shared.blocked_account":
        title = "Usuario Bloqueado";
        message = localizations.blockedUserMessage;
        iconWidget = Image.asset(
          AppImages.lockPassword,
          height: 30,
          width: 30,
          color: Colors.white,
        );
        break;
      default:
        title = "Error";
        message = localizations.defaultLoginMessageError;
        iconWidget = Image.asset(
          AppImages.dangerIcon,
          height: 30,
          width: 30,
          color: Colors.white,
        );
        break;
    }

    showCustomDialog(context, title, message, iconWidget);
  }
}

void showCustomDialog(
    BuildContext context, String title, String message, Widget iconWidget) {
  final text = AppLocalizations.of(context)!;
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Contenedor del círculo más grande
            Container(
              width: 115.w(context),
              height: 115.w(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color0080F2.withOpacity(0.2),
              ),
              child: Center(
                // Contenedor del círculo más pequeño
                child: Container(
                  width: 71.w(context),
                  height: 71.w(context),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color0080F2,
                  ),
                  child: Center(
                    child: iconWidget,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25.h(context)),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.w(context),
                fontWeight: FontWeightEnum.SemiBold.fWTheme,
                color: color07355E,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 11.h(context)),
            Text(
              message,
              style: TextStyle(
                fontSize: 14.w(context),
                color: color07355E,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: context.pop,
              child: Text(text.close),
            ),
          ],
        ),
      ),
    ),
  );
}
