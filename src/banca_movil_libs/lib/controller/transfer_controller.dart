import 'package:banca_movil_libs/banca_movil_libs.dart';

class TransferController {
  static final transferService = TransferService();
  static Future transferFunds({
    required String destinationAccount,
    required String originAccount,
    required String amount,
    String description = "",
  }) async {
    await transferService.transferFunds(
      destinationAccount: destinationAccount,
      originAccount: originAccount,
      amount: amount,
      description: description,
    );
  }
}
