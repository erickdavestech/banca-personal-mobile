import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';

import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserModel? user;
  LoginBloc() : super(LoginInitial()) {
    on<LoginLoadingEvent>((event, emit) => emit(LoginLoading()));

    on<LoginSuccessEvent>((event, emit) {
      try {
        final data = JwtDecoder.decode(preferences.uToken);
        user = UserModel.fromJson(data);
      } catch (e) {
        // emit(LoginError("Error decoding token"));
        log(e.toString());
      } finally {
        emit(LoginSuccess(user ?? UserModel()));
      }
    });
  }
}
