part of 'biometric_bloc.dart';

abstract class BiometricState {}

class BiometricInitial extends BiometricState {}

class FaceCaptureInProgress extends BiometricState {}

class FaceCaptureSuccess extends BiometricState {
  final SelphiFaceResult result;
  FaceCaptureSuccess(this.result);
}

class FaceCaptureFailure extends BiometricState {
  final String message;
  FaceCaptureFailure(this.message);
}
