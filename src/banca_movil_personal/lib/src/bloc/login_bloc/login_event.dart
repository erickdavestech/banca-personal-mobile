part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginLoadingEvent extends LoginEvent {}

final class LoginSuccessEvent extends LoginEvent {}
