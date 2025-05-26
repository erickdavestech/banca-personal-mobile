import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:dartz/dartz.dart';
import 'package:fphi_sdkmobile_selphi/fphi_sdkmobile_selphi_configuration.dart';
import 'package:fphi_sdkmobile_selphi/fphi_sdkmobile_selphi.dart';
import 'package:fphi_sdkmobile_selphi/fphi_sdkmobile_selphi_compress_format.dart';
import 'package:fphi_sdkmobile_selphi/fphi_sdkmobile_selphi_liveness_mode.dart';

/// This sample class calls the Selphi Plugin and launch the native widget. Return the result to the UI
class SelphiFaceWidget {
  static Future<Either<Exception, SelphiFaceResult>>
  launchSelphiAuthenticate() async {
    try {
      final Map r = await FphiSdkmobileSelphi().startSelphiFaceWidget(
        resourcesPath: resourcesPath,
        widgetConfigurationJSON: createStandardConfiguration(),
      );
      return Right(SelphiFaceResult.fromMap(r));
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  /// Sample of standard plugin configuration
  static SelphiFaceConfiguration createStandardConfiguration() {
    return SelphiFaceConfiguration(
      mVibrationEnabled: true,
      mLivenessMode: SelphiFaceLivenessMode.LM_PASSIVE,
      mEnableGenerateTemplateRaw: true,
      mTemplateRawOptimized: true,
      mShowDiagnostic: true,
      mShowResultAfterCapture: true,
      mFullscreen: true,
      mCompressFormat: SelphiCompressFormat.T_JPEG,
      mJPGQuality: 0.95,
    );
  }

  static Future<Either<Exception, SelphiFaceResult>> setSelphiFlow() async {
    try {
      final Map r = await FphiSdkmobileSelphi().setSelphiFlow();
      return Right(SelphiFaceResult.fromMap(r));
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
