part of 'beneficiarios_bloc.dart';

class BeneficiariosState {
  Beneficiarios? destinationBeneficiario;
  Beneficiarios? selectedBeneficiario;
  List<Beneficiarios> beneficiarios = [];

  BeneficiariosState({
    this.destinationBeneficiario,
    this.selectedBeneficiario,
    this.beneficiarios = const [],
  });

  BeneficiariosState copyWith({
    Beneficiarios? destinationBeneficiario,
    Beneficiarios? selectedBeneficiario,
    List<Beneficiarios>? beneficiarios,
  }) {
    return BeneficiariosState(
        destinationBeneficiario: destinationBeneficiario,
        beneficiarios: beneficiarios ?? this.beneficiarios,
        selectedBeneficiario: selectedBeneficiario);
  }
}
