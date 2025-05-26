import 'package:banca_movil_comercial/src/localization/app_localizations.dart';
import 'package:flutter/widgets.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get lang {
    final localizations = AppLocalizations.of(this);
    if (localizations == null) {
      throw FlutterError(
        'AppLocalizations no está disponible en este contexto. '
        'Asegúrate de acceder a context.lang **después** de que el MaterialApp esté montado '
        'y que AppLocalizations.delegate esté incluido en localizationsDelegates.',
      );
    }
    return localizations;
  }
}
