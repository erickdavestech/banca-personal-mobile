import 'package:banca_movil_comercial/src/bloc/login_bloc/login_bloc.dart';
import 'package:banca_movil_comercial/src/bloc/login_bloc/login_event.dart';
import 'package:banca_movil_comercial/src/bloc/login_bloc/login_state.dart';
import 'package:banca_movil_comercial/src/extensions/context_extensions.dart';

import 'package:banca_movil_comercial/src/screens/authentication/login_controller.dart';
import 'package:banca_movil_comercial/src/screens/authentication/login_theme.dart';
import 'package:banca_movil_comercial/src/screens/authentication/widgets/drawer.dart';
import 'package:banca_movil_comercial/src/screens/authentication/widgets/face_capture_page.dart';
import 'package:banca_movil_comercial/src/screens/authentication/widgets/login_option_group.dart';
import 'package:banca_movil_comercial/src/screens/authentication/widgets/token_modal/token_modal.dart';
import 'package:banca_movil_comercial/src/screens/main/tabs_screen.dart';
import 'package:banca_movil_comercial/src/screens/widgets/localization_helper.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/LoginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginController controller;

  @override
  void initState() {
    super.initState();
    controller = LoginController(
      onUpdateUI: () => setState(() {}),
      initialUser: '',
      initialPassword: '',
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: LoginDrawer(),
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: Image(image: AssetImage(AppImages.hamburgerIconPath)),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(isTablet ? 115.h(context) : 16.h(context)),
        children: [
          Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(AppImages.caIconPath),
                  height: isTablet ? 153.31.h(context) : 132.h(context),
                ),
                SizedBox(height: 50.h(context)),
                usernameField(),
                passwordField(),
                SizedBox(height: 40.h(context)),
                loginButton(),
                SizedBox(height: 15.h(context)),
                TextButton(
                  onPressed: () {},
                  child: Text(context.lang.btnForgotPassword),
                ),
                SizedBox(height: 100.h(context)),
                faceId(),
              ],
            ),
          ),
          SizedBox(height: 75.h(context)),
        ],
      ),
      bottomNavigationBar: Container(
        padding: LoginTheme.bottomOptionRowPadding,
        height: 80.h(context),
        child: LoginOptionsGroup(
          isTablet: isTablet,
          items: [
            // TODO: Solo tienen que crear el widget, como de costumbre
            // y ponerlo como child
            LoginOptionItem(
              title: context.lang.drawerServicePromotion,
              icon: AppImages.bookmarksIconPath,
              child: const SizedBox.shrink(),
            ),

            LoginOptionItem(
              title: context.lang.token,
              icon: AppImages.tokenIconPath,
              child: TokenModal(),
            ),

            // TODO: Solo tienen que crear el widget, como de costumbre
            // y ponerlo como child
            LoginOptionItem(
              title: context.lang.newUser,
              icon: AppImages.userIconPath,
              child: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget usernameField() => TextFormField(
    controller: controller.userController,
    decoration: InputDecoration(
      hintText: context.lang.formUsuario,
      prefixIcon: IconButton(
        onPressed: null,
        icon: Image(
          image: AssetImage(AppImages.userIconPath),
          height: LoginTheme.fieldPrefixIconSize,
          width: LoginTheme.fieldPrefixIconSize,
        ),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return context.lang.enterUsername;
      }
      return null;
    },
    onChanged: (value) {
      if (value.isNotEmpty && !controller.showPasswordField) {
        controller.togglePasswordField();
      }
    },
  );

  Widget passwordField() => AnimatedCrossFade(
    firstChild: const SizedBox.shrink(),
    secondChild: Column(
      children: [
        if (controller.showPasswordField) SizedBox(height: 16.h(context)),
        if (controller.showPasswordField)
          TextFormField(
            controller: controller.passwordController,
            obscureText: !controller.showPassword,
            decoration: InputDecoration(
              hintText: context.lang.formPassword,
              prefixIcon: IconButton(
                onPressed: null,
                icon: Image(
                  image: AssetImage(AppImages.lockPassword),
                  width: LoginTheme.fieldPrefixIconSize,
                  height: LoginTheme.fieldPrefixIconSize,
                ),
              ),
              suffixIcon: IconButton(
                onPressed: controller.toggleShowPassword,
                icon: Padding(
                  padding: LoginTheme.eyeIconPadding,
                  child: ImageIcon(
                    AssetImage(
                      controller.showPassword
                          ? AppImages.openEye
                          : AppImages.akarEyeClosed,
                    ),
                    color: color1C274C,
                    size: LoginTheme.eyeIconSize,
                  ),
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return context.lang.enterPassword;
              }
              if (value.length < LoginTheme.minPasswordLength) {
                return context.lang.passwordMinLength;
              }
              return null;
            },
          ),
      ],
    ),
    crossFadeState:
        controller.showPasswordField
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
    duration: Durations.medium4,
  );

  Widget loginButton() => BlocConsumer<LoginBloc, LoginState>(
    listener: (context, state) {
      if (state is LoginSuccess) {
        context.pushNamedAndRemoveUntil(TabsScreen.routeName);

        return;
      }

      if (state is LoginFailure) {
        final error = state.message;
        if (error == 'shared.blocked_account' ||
            error == 'shared.wrong_login_message') {
          LocalizationHelper.getErrorMessage(context, error);
        } else {
          showTopSnackBar(context);
        }
        controller.userController.clear();
        controller.passwordController.clear();
        setState(() => controller.showPasswordField = false);
        context.read<LoginBloc>().add(LoginInitialEvent());
      }
    },
    builder: (context, state) {
      if (state is LoginLoading) {
        return CircularProgressIndicator.adaptive();
      }

      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize:
              isTablet
                  ? Size(double.infinity, 50.h(context))
                  : Size(double.infinity, 55.h(context)),
        ),
        onPressed: () async => controller.login(context),
        child: Text(context.lang.btnLogin),
      );
    },
  );

  Widget faceId() => GestureDetector(
    onTap: () async {
      final result = await SelphiFaceWidget.launchSelphiAuthenticate();

      result.fold(
        (error) {
          print("🚫 Error en biometría facial: $error");
          // aquí puedes mostrar un SnackBar o modal si deseas
        },
        (data) {
          if (data.finishStatus.toInt() == 0) {
            print("✅ Biometría facial exitosa");
            print("📄 Resultado: ${data.toMap()}");
            context.pushNamedAndRemoveUntil(FaceCapturePage.routeName);
            // TODO: Aquí podrías continuar con navegación o validación
            // Navigator.pushNamed(context, FaceCapturePage.routeName);
          } else {
            print("⚠️ Fallo en biometría: ${data.errorDiagnostic}");
          }
        },
      );
    },
    child: Column(
      spacing: 10.h(context),
      children: [
        Image.asset(
          AppImages.faceId,
          width: 45.w(context),
          height: 44.h(context),
        ),
        Text(
          context.lang.biometryText,
          style: TextStyle(
            fontSize: 14.w(context),
            color: color043371,
            fontWeight: FontWeightEnum.Medium.fWTheme,
          ),
        ),
      ],
    ),
  );
}
