import 'package:banca_movil_comercial/src/bloc/login_bloc/login_bloc.dart';
import 'package:banca_movil_comercial/src/bloc/login_bloc/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userController;
  final TextEditingController passwordController;

  final VoidCallback onUpdateUI;

  bool showPasswordField = false;
  bool showPassword = false;

  LoginController({
    required this.onUpdateUI,
    String initialUser = '',
    String initialPassword = '',
  }) : userController = TextEditingController(text: initialUser),
       passwordController = TextEditingController(text: initialPassword);

  void dispose() {
    userController.dispose();
    passwordController.dispose();
  }

  void toggleShowPassword() {
    showPassword = !showPassword;
    onUpdateUI();
  }

  void togglePasswordField() {
    showPasswordField = true;
    onUpdateUI();
  }

  Future<void> login(BuildContext context) async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final username = userController.text.trim();
    final password = passwordController.text.trim();

    if (!context.mounted) return;

    context.read<LoginBloc>().add(
      LoginLoadingEvent(username: username, password: password),
    );
  }
}
