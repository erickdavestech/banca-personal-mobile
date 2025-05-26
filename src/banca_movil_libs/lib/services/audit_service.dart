import 'dart:developer';

import 'package:banca_movil_libs/banca_movil_libs.dart';

enum AuditActionType {
  // Define the action types for audit logging.
  // These can be used to categorize different types of actions in the application.
  unknown, // 0
  create, // 1
  read, // 2
  modificate, // 3
  delete, // 4
  login, // 5
  logout, // 6
  error, // 7
  specific, // 8
  deviceTrust, // 9
  resourceValidation, // 10
  transfer, // 11
  register, // 12
  userNameRecovery, // 13
}

class AuditService {
  // This class is responsible for handling audit logs and related operations.
  // It can be used to log user actions, errors, and other important events in the application.

  // Add methods and properties as needed for your audit logging requirements.
  // For example:
  static Future<void> logEvent(
    String action,
    AuditActionType actionType,
  ) async {
    try {
      final response = await dioClient.post(
        "Audits/${preferences.uClientID}",
        data: {
          "action": action,
          "actionType": actionType.index,
          "channel": 4,
        }, //channel 4 es para comercial
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        // Successfully logged the event.
        log('Audit event logged successfully.');
      } else {
        // Handle the error response.
        log('Failed to log audit event: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors that occur during logging.
      log('Error logging audit event: $e');
    }
  }
}
