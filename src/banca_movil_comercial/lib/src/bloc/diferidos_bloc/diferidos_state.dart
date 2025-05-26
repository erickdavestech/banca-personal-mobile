part of 'diferidos_bloc.dart';

@immutable
sealed class DiferidosState {}

final class DiferidosInitial extends DiferidosState {}

final class DiferidosLoading extends DiferidosState {}

final class DiferidosLoaded extends DiferidosState {
  final RetenidosYDiferidos diferidos;

  DiferidosLoaded(this.diferidos);
}

final class DiferidosError extends DiferidosState {
  final String error;

  DiferidosError(this.error);
}
