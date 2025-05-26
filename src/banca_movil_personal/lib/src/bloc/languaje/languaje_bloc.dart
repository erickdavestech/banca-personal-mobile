import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'languaje_event.dart';
part 'languaje_state.dart';

class LanguajeBloc extends Bloc<LanguajeEvent, LanguajeState> {
  LanguajeBloc() : super(LanguajeState(languajeCode: preferences.uLanguaje)) {
    on<LanguajeEvent>((event, emit) {
      // preferences.languaje = event.languajeCode;
      preferences.setLanguaje(event.languajeCode);
      emit(state.copyWith(languageCode: event.languajeCode));
    });
  }
}
