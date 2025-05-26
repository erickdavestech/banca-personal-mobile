part of 'transaction_bloc.dart';

@immutable
class TransactionState {
  final Product? selectedProduct;
  final Product? sourceProduct;
  final Product? destinationProduct;
  final Beneficiarios? selectedBeneficiario;


  const TransactionState({
    this.sourceProduct,
    this.destinationProduct,
    this.selectedProduct,
    this.selectedBeneficiario,

  });

  TransactionState copyWith({
    Product? sourceProduct,
    Product? destinationProduct,
    Product? selectedProduct,
    Beneficiarios? selectedBeneficiario,

  }) =>
      TransactionState(
        sourceProduct: sourceProduct,
        destinationProduct: destinationProduct,
        selectedProduct: selectedProduct,
        selectedBeneficiario: selectedBeneficiario,
        
      );
}
