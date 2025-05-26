import 'package:banca_movil_libs/preferences/preferences.dart';
import 'package:bloc/bloc.dart';

import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState(languageCode: preferences.uLanguaje)) {
    on<ChangeLanguage>((event, emit) {
      preferences.setLanguaje(event.languageCode);
      emit(LanguageState(languageCode: event.languageCode));
    });
  }
}
