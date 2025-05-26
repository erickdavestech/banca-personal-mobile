import 'package:banca_movil_comercial/src/models/beneficiario_model.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  Product? sourceProduct;
  Product? destinationProduct;
  Beneficiarios? selectedBeneficiario;
  TransactionBloc() : super(TransactionState()) {
    on<ClearSelectedEvent>((event, emit) {
      emit(
        state.copyWith(
          sourceProduct: sourceProduct,
          destinationProduct: destinationProduct,
          selectedBeneficiario: selectedBeneficiario,
        ),
      );
    });
    on<InitTransaction>((event, emit) {
      sourceProduct = null;
      destinationProduct = null;
      selectedBeneficiario = null;

      emit(
        state.copyWith(
          sourceProduct: sourceProduct,
          destinationProduct: destinationProduct,
          selectedBeneficiario: selectedBeneficiario,
        ),
      );
    });
    on<ProductSelectedEvent>((event, emit) {
      emit(
        state.copyWith(
          selectedProduct: event.product,
          sourceProduct: sourceProduct,
          destinationProduct: destinationProduct,
          selectedBeneficiario: selectedBeneficiario,
        ),
      );
    });

    on<BeneficiarioSelectedEvent>((event, emit) {
      selectedBeneficiario = event.beneficiario;
      emit(state.copyWith(selectedBeneficiario: selectedBeneficiario));
    });

    on<GetProductFromTransferEvent>((event, emit) {
      sourceProduct = event.product;
      emit(
        state.copyWith(
          sourceProduct: sourceProduct,
          destinationProduct: destinationProduct,
          selectedBeneficiario: selectedBeneficiario,
        ),
      );
    });

    on<GetProductToTransferEvent>((event, emit) {
      destinationProduct = event.product;
      emit(
        state.copyWith(
          destinationProduct: destinationProduct,
          sourceProduct: sourceProduct,
          selectedBeneficiario: selectedBeneficiario,
        ),
      );
    });

    /*on<GetBeneficiarioToTransferEvent>((event, emit) {
      selectedBeneficiario = event.beneficiario;
      emit(state.copyWith(
        destinationProduct: destinationProduct,
        sourceProduct: sourceProduct,
        selectedBeneficiario: selectedBeneficiario,
      ));
    });*/
  }
}
