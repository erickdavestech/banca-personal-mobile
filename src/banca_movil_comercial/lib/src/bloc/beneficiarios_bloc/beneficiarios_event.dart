part of 'beneficiarios_bloc.dart';

@immutable
sealed class BeneficiariosEvent {}

final class InitBeneficiario extends BeneficiariosEvent {}

final class SelectBeneficiarioEvent extends BeneficiariosEvent {
  final Beneficiarios beneficiario;
  SelectBeneficiarioEvent(this.beneficiario);
}

final class GetBeneficiarioToTransferEvent extends BeneficiariosEvent {
   final Beneficiarios beneficiario;
  GetBeneficiarioToTransferEvent(this.beneficiario);
}

final class ClearBeneficiarioSelectionEvent extends BeneficiariosEvent {}
