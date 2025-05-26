import 'dart:math' as AppLogger;

import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:bloc/bloc.dart';

part 'biometric_event.dart';
part 'biometric_state.dart';

class BiometricBloc extends Bloc<BiometricEvent, BiometricState> {
  BiometricBloc() : super(BiometricInitial()) {
    on<StartFaceCaptureEvent>((event, emit) async {
      emit(FaceCaptureInProgress());

      final result = await SelphiFaceWidget.launchSelphiAuthenticate();

      result.fold(
        (error) => emit(FaceCaptureFailure('Face capture failed: $error')),
        (data) {
          if (data.finishStatus.toInt() == 0) {
            emit(FaceCaptureSuccess(data));
          } else {
            emit(
              FaceCaptureFailure(
                data.errorDiagnostic.isNotEmpty
                    ? data.errorDiagnostic
                    : 'Face capture was not successful.',
              ),
            );
          }
        },
      );
    });
  }
}
