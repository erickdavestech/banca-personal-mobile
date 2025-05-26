import 'package:banca_movil_comercial/src/models/beneficiario_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'beneficiarios_event.dart';
part 'beneficiarios_state.dart';

class BeneficiariosBloc extends Bloc<BeneficiariosEvent, BeneficiariosState> {
  Beneficiarios? destinationBeneficiario;
  Beneficiarios? selectedBeneficiario;
  BeneficiariosBloc() : super(BeneficiariosState()) {
    on<InitBeneficiario>((event, emit) {
      destinationBeneficiario = null;
      selectedBeneficiario = null;
      emit(
        state.copyWith(
          destinationBeneficiario: destinationBeneficiario,
          selectedBeneficiario: selectedBeneficiario,
        ),
      );
    });

    on<SelectBeneficiarioEvent>((event, emit) {
      emit(
        state.copyWith(
          destinationBeneficiario: destinationBeneficiario,
          selectedBeneficiario: event.beneficiario,
        ),
      );
    });

    on<GetBeneficiarioToTransferEvent>((event, emit) {
      destinationBeneficiario = event.beneficiario;
      emit(
        state.copyWith(
          selectedBeneficiario: selectedBeneficiario,
          destinationBeneficiario: destinationBeneficiario,
        ),
      );
    });

    on<ClearBeneficiarioSelectionEvent>((event, emit) {
      emit(
        state.copyWith(
          selectedBeneficiario: selectedBeneficiario,
          destinationBeneficiario: destinationBeneficiario,
        ),
      );
    });
  }
}
