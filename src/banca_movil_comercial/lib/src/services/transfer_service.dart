import 'package:banca_movil_libs/helpers/network_util.dart' show dioClient;
import 'package:banca_movil_libs/preferences/preferences.dart';

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
      } else {
        throw Exception('Transfer failed: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
