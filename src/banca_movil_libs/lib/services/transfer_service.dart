import 'dart:developer';

import 'package:banca_movil_libs/helpers/network_util.dart';
import 'package:banca_movil_libs/preferences/preferences.dart';
import 'package:banca_movil_libs/services/audit_service.dart';

class TransferService {
  Future<void> transferFunds({
    required String destinationAccount,
    required String originAccount,
    required String amount,
    required String description,
  }) async {
    // Implement the transfer logic here
    // This is just a placeholder implementation
    try {
      final response = await dioClient.post(
        'Transfer/${preferences.uClientID}/local',
        data: {
          "amount": amount,
          "description": description,
          "destinationAccount": destinationAccount,
          "originAccount": originAccount,
        },
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        AuditService.logEvent(
          "Transferencia realizada",
          AuditActionType.transfer,
        );
        log('Transfer successful: ${response.data}');
      } else {
        throw Exception(
          response.data["errorKey"] ??
              'Transfer failed: ${response.statusCode}',
        );
      }
    } catch (e) {
      AuditService.logEvent(
        "Error al realizar transferencia",
        AuditActionType.error,
      );
      rethrow;
    }
  }
}
