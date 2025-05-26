import 'package:bloc/bloc.dart';
import 'package:ca_mobile/src/models/beneficiario_model.dart';
import 'package:meta/meta.dart';

part 'beneficiarios_event.dart';
part 'beneficiarios_state.dart';

class BeneficiariosBloc extends Bloc<BeneficiariosEvent, BeneficiariosState> {
  Beneficiarios? destinationBeneficiario;
  Beneficiarios? selectedBeneficiario;
  BeneficiariosBloc() : super(BeneficiariosState()) {
   on<InitBeneficiario>((event, emit) {
  final initialBeneficiarios = [
    Beneficiarios(
      id: "1",
      nombre: 'Adams Lapaix Castillo',
      banco: 'Banco Nuevo',
      cuenta: '123456789',
      tipoCuenta: 'Corriente',
    ),
    Beneficiarios(
      id: "2",
      nombre: 'Stalin Bienvenido Rivas López',
      banco: 'Banco Viejo',
      cuenta: '987654321',
      tipoCuenta: 'Corriente',
    ),
  ];

  destinationBeneficiario = null;
  selectedBeneficiario = null;

  emit(state.copyWith(
    beneficiarios: initialBeneficiarios,
    destinationBeneficiario: null,
    selectedBeneficiario: null,
  ));
});
    on<AddAndSelectBeneficiarioEvent>((event, emit) {
  final updatedList = List<Beneficiarios>.from(state.beneficiarios)
    ..add(event.beneficiario);

  destinationBeneficiario = event.beneficiario;
  selectedBeneficiario = event.beneficiario;

  emit(state.copyWith(
    beneficiarios: updatedList,
    destinationBeneficiario: destinationBeneficiario,
    selectedBeneficiario: selectedBeneficiario,
  ));
});

    on<SelectBeneficiarioEvent>((event, emit) {
      emit(state.copyWith(
        destinationBeneficiario: destinationBeneficiario,
        selectedBeneficiario: event.beneficiario,
      ));
    });

    on<GetBeneficiarioToTransferEvent>((event, emit) {
      destinationBeneficiario = event.beneficiario;
      emit(state.copyWith(
        selectedBeneficiario: selectedBeneficiario,
        destinationBeneficiario: destinationBeneficiario,
      ));
    });

  on<ClearBeneficiarioSelectionEvent>((event, emit) {
  selectedBeneficiario = null;
  emit(state.copyWith(
    selectedBeneficiario: null,
    destinationBeneficiario: destinationBeneficiario, 
  ));
});
  }
}
