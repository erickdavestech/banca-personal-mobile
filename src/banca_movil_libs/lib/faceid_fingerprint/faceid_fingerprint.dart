import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuth {
  static final LocalAuthentication auth = LocalAuthentication();

  static Future<bool> get authenticate async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to continue',
      );

      return didAuthenticate;
    } on PlatformException catch (e) {
      log('Error: ${e.message}');
      return false;
    }
  }
}
