part of 'biometric_bloc.dart';

abstract class BiometricEvent {}

class StartFaceCaptureEvent extends BiometricEvent {}

class CapturaExitosaEvent extends BiometricEvent {
  final SelphiFaceResult resultado;
  CapturaExitosaEvent(this.resultado);
}

class CapturaFallidaEvent extends BiometricEvent {
  final String mensajeError;
  CapturaFallidaEvent(this.mensajeError);
}
