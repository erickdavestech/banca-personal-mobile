import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:dartz/dartz.dart';
import 'package:fphi_sdkmobile_selphid/fphi_sdkmobile_selphid_configuration.dart';
import 'package:fphi_sdkmobile_selphid/fphi_sdkmobile_selphid.dart';
import 'package:fphi_sdkmobile_selphid/fphi_sdkmobile_selphid_document_side.dart';
import 'package:fphi_sdkmobile_selphid/fphi_sdkmobile_selphid_document_type.dart';
import 'package:fphi_sdkmobile_selphid/fphi_sdkmobile_selphid_scan_mode.dart';
import 'package:fphi_sdkmobile_selphid/fphi_sdkmobile_selphid_timeout.dart';

/// This sample class calls the Selphi Plugin and launch the native widget. Return the result to the UI
class SelphIDWidget {
  static Future<Either<Exception, SelphIDResult>> launchSelphIDCapture(
    bool front,
  ) async {
    try {
      final Map r = await FphiSdkmobileSelphid().startSelphIDWidget(
        resourcesPath: resourcesPathSelphid,
        widgetConfigurationJSON: createStandardConfiguration(front),
      );
      return Right(SelphIDResult.fromMap(r));
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  /// Sample of standard plugin configuration
  static SelphIDConfiguration createStandardConfiguration(bool front) {
    SelphIDConfiguration configurationWidget = SelphIDConfiguration(
      mDocumentType:
          SelphIDDocumentType
              .DT_IDCARD, // IDCard, Passport, DriverLic or ForeignCard
      mScanMode: SelphIDScanMode.CAP_MODE_GENERIC,
      mTimeout: SelphIDTimeout.T_LONG,
      mShowPreviousTip: false,
      mDocumentSide:
          front ? SelphIDDocumentSide.DT_FRONT : SelphIDDocumentSide.DT_BACK,
      // mLocale: preferences.uLanguaje,
      mTutorialOnly: false,
      mVibrationEnabled: true,
      mShowResultAfterCapture: false,
      mShowDiagnostic: false,
      mShowTutorial: false,
      mWizardMode: false,
    );

    return configurationWidget;
  }
}
