part of 'diferidos_bloc.dart';

@immutable
sealed class DiferidosEvent {}

final class DiferidosInitialEvent extends DiferidosEvent {}

final class GetDiferidos extends DiferidosEvent {
  final String accountNumber;

  GetDiferidos(this.accountNumber);
}
