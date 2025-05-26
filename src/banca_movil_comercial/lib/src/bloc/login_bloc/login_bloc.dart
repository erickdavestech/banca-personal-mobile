import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserModel? user;
  LoginBloc() : super(LoginInitial()) {
    on<LoginLoadingEvent>((event, emit) async {
      emit(LoginLoading());

      try {
        final user = await AuthController.loginUser(
          event.username,
          event.password,
        );
        await preferences.setName(user.user?.name ?? '');
        emit(LoginSuccess(user));
      } catch (e) {
        final message = e.toString().replaceFirst('Exception: ', '');
        emit(LoginFailure(message));
      }
    });

    on<LoginInitialEvent>((event, emit) {
      emit(LoginInitial());
    });

    on<LoginSuccessEvent>((event, emit) {
      try {
        final data = JwtDecoder.decode(event.token);
        user = UserModel.fromJson(data);
      } finally {
        emit(LoginSuccess(user ?? UserModel()));
      }
    });
  }
}
