import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetChecker {
  /// Check the internet connection status
  static StreamSubscription<InternetStatus> checkConnection(
    VoidCallback onDisconnect,
  ) {
    return InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          log("Internet status: $status");
          // The internet is now connected
          break;
        case InternetStatus.disconnected:
          log("Internet status: $status");

          onDisconnect();
          // The internet is now disconnected
          break;
      }
    });
  }

  /// Check the internet connection status
  static Future<bool> get hasInternetAccess async {
    return await InternetConnection().hasInternetAccess;
  }


}
