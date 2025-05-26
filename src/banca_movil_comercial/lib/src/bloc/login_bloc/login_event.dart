import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginLoadingEvent extends LoginEvent {
  final String username;
  final String password;

  LoginLoadingEvent({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}

final class LoginSuccessEvent extends LoginEvent {
  final String token;

  LoginSuccessEvent(this.token);
}

class LoginInitialEvent extends LoginEvent {}
