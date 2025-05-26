part of 'transaction_bloc.dart';

@immutable
sealed class TransactionEvent {}

final class GetProductFromTransferEvent extends TransactionEvent {
  final Product product;

  GetProductFromTransferEvent(this.product);
}

final class GetProductToTransferEvent extends TransactionEvent {
  final Product product;

  GetProductToTransferEvent(this.product);
}

/*final class GetBeneficiarioToTransferEvent extends TransactionEvent {
   final Beneficiarios beneficiario;
  GetBeneficiarioToTransferEvent(this.beneficiario);
}*/

final class ProductSelectedEvent extends TransactionEvent {
  final Product product;

  ProductSelectedEvent(this.product);
}

final class BeneficiarioSelectedEvent extends TransactionEvent {
  final Beneficiarios beneficiario;
  BeneficiarioSelectedEvent(this.beneficiario);
}

final class InitTransaction extends TransactionEvent {}



final class ClearSelectedEvent extends TransactionEvent {}
