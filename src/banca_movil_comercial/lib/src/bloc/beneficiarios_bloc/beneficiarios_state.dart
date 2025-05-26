part of 'beneficiarios_bloc.dart';

class BeneficiariosState {
  Beneficiarios? destinationBeneficiario;
  Beneficiarios? selectedBeneficiario;

  BeneficiariosState({this.destinationBeneficiario, this.selectedBeneficiario});

  BeneficiariosState copyWith({
    Beneficiarios? destinationBeneficiario,
    Beneficiarios? selectedBeneficiario,
  }) {
    return BeneficiariosState(
      destinationBeneficiario: destinationBeneficiario,
      selectedBeneficiario: selectedBeneficiario,
    );
  }
}
