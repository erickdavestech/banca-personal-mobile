part of 'languaje_bloc.dart';

@immutable
class LanguajeState {
  final String languajeCode;

  const LanguajeState({required this.languajeCode});

  LanguajeState copyWith({
    String? languageCode,
  }) {
    return LanguajeState(
      languajeCode: languageCode ?? languajeCode,
    );
  }
}
