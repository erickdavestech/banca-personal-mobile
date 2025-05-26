import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fphi_sdkmobile_core/fphi_sdkmobile_core.dart';
import 'package:fphi_sdkmobile_core/fphi_sdkmobile_core_operation_event.dart';
import 'package:fphi_sdkmobile_core/fphi_sdkmobile_core_configuration.dart';
import 'package:fphi_sdkmobile_core/fphi_sdkmobile_tracking_configuration.dart';
import 'package:fphi_sdkmobile_core/fphi_sdkmobile_tracking_operation_type.dart';
import 'core_result.dart';

/// This sample class calls the Core Plugin and launch the native widget. Return the result to the UI
class CoreWidget {
  static Future<Either<Exception, CoreResult>> closeSession(
    SdkOperationEvent event,
  ) async {
    try {
      final Map m = await FphiSdkmobileCore().closeSession();
      return Right(CoreResult.fromMap(m));
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  static Future<Either<Exception, CoreResult>> initSession({
    required String androidApiKey,
    required String iOSApiKey,
  }) async {
    try {
      final Map m = await FphiSdkmobileCore().initSession(
        widgetConfigurationJSON: CoreConfigurationInitSession(
          mLicenseUrl: "https://license.identity-platform.io",
          mLicenseApiKey: Platform.isAndroid ? androidApiKey : iOSApiKey,
          mEnableTracking: false,
          // mLocale: preferences.uLanguaje,
        ),
      );
      return Right(CoreResult.fromMap(m));
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  static Future<Either<Exception, CoreResult>> getExtraData() async {
    try {
      final Map m = await FphiSdkmobileCore().getExtraData();
      return Right(CoreResult.fromMap(m));
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  static Future<Either<Exception, CoreResult>> initOperation(
    String clientID,
  ) async {
    try {
      final Map m = await FphiSdkmobileCore().initOperation(
        widgetConfigurationJSON: TrackingConfiguration(
          mCustomerId: clientID,
          mType: TrackingOperationType.ONBOARDING,
        ),
      );
      return Right(CoreResult.fromMap(m));
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
