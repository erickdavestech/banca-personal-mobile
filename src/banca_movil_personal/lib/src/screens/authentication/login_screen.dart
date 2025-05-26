import 'dart:convert';

import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:ca_mobile/src/bloc/login_bloc/login_bloc.dart';
import 'package:ca_mobile/src/screens/widgets/localization_helper.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart'
    show AppLocalizations;
import 'package:ca_mobile/src/screens/main/tabs_screen.dart';
import 'package:ca_mobile/src/screens/authentication/widgets/drawer.dart';
import 'package:ca_mobile/src/screens/authentication/scan_face_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:ca_mobile/src/screens/authentication/widgets/modal_token.dart';
import 'package:ca_mobile/src/screens/authentication/widgets/modal_activate_token.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/LoginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _userController;
  late TextEditingController _passwordController;
  bool _showRegisterDeviceDialog = false;
  bool firstTime = true;

  bool _showPasswordField = false;
  bool _showPassword = false;

  String image1 = "";
  String image2 = "";
  @override
  void initState() {
    _userController = TextEditingController(
      text: kDebugMode
          ? "Wellington01"
          : preferences.uFaceIdEnabled
              ? preferences.uUsuarioFaceID
              : "",
    );
    _passwordController =
        TextEditingController(text: kDebugMode ? "Caja@12345" : "");

    _showRegisterDeviceDialog = preferences.uDeviceRegistered == false;

    // _biometric();

      // if (_showRegisterDeviceDialog && firstTime) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRegisterDeviceDialog(context);
    });
    setState(() {
      firstTime = false;
    });
    // }
    super.initState();
  }

  final int _steps = 0;

  // _biometric() async {
  //   final initResult = await CoreWidget.initSession(
  //     androidApiKey: "v3vQa6XhpgmmO6Bvoc2mn2Kfiwz0APXVYYMkFa1R",
  //     iOSApiKey: "mzkU5xwi1XBnWdAE89G3rYpE5VPXPsQITJfMMi3n",
  //   );

  //   log("Init result: $initResult");

  //   final operationResult = await CoreWidget.initOperation("123456");

  //   log("Operation result: $operationResult");

  //   final launchSelphiAuthenticate =
  //       await SelphIDWidget.launchSelphIDCapture(true);

  //   image1 = launchSelphiAuthenticate.fold(
  //     (l) => "",
  //     (r) {
  //       log("SelphID result: ${r.toMap()}");
  //       return r.frontDocumentImage;
  //     },
  //   );

  //   final launchSelphiAuthenticate2 =
  //       await SelphIDWidget.launchSelphIDCapture(false);

  //   image2 = launchSelphiAuthenticate2.fold(
  //     (l) => "",
  //     (r) {
  //       log("SelphID result: ${r.toMap()}");
  //       return r.backDocumentImage;
  //     },
  //   );

  //   setState(() {});

  //   log("Launch result: $launchSelphiAuthenticate");
  //   if (_steps >= 1) return;
  //   _steps++;
  // }

  @override
  void dispose() {
    super.dispose();
    _userController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context);
  
    return Scaffold(
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        actions: [
          Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: Image(
                image: AssetImage(AppImages.hamburgerIconPath),
              ),
            );
          }),
        ],
      ),
      body: ListView(
        physics: ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Padding(
            padding: EdgeInsets.all(isTablet ? 115.h(context) : 16.h(context)),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage(AppImages.caIconPath),
                    height: isTablet ? 153.31.h(context) : 132.h(context),
                  ),
                  SizedBox(
                    height: 50.h(context),
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: _userController,
                    scrollPadding: EdgeInsets.all(50),
                    decoration: InputDecoration(
                      hintText: "${AppLocalizations.of(context)?.formUsuario}",
                      prefixIcon: IconButton(
                        padding: isTablet
                            ? EdgeInsets.symmetric(vertical: 20)
                            : null,
                        onPressed: null,
                        icon: Image(
                          height: 20,
                          width: 20,
                          image: AssetImage(AppImages.userIconPath),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu usuario';
                      }
                      return null;
                    },
                  ),
                  AnimatedCrossFade(
                    firstChild: SizedBox.shrink(),
                    secondChild: Column(
                      children: [
                        if (_showPasswordField)
                          SizedBox(
                            height: 16.h(context),
                          ),
                        if (_showPasswordField)
                          TextFormField(
                            controller: _passwordController,
                            scrollPadding: EdgeInsets.all(100),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !_showPassword,
                            decoration: InputDecoration(
                              hintText:
                                  "${AppLocalizations.of(context)?.formPassword}",
                              prefixIcon: IconButton(
                                padding: isTablet
                                    ? EdgeInsets.symmetric(vertical: 20)
                                    : null,
                                onPressed: null,
                                icon: Image(
                                  width: 20,
                                  height: 20,
                                  image: AssetImage(AppImages.lockPassword),
                                ),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                                icon: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: ImageIcon(
                                    AssetImage(_showPassword
                                        ? AppImages.openEye
                                        : AppImages.akarEyeClosed),
                                    color: color1C274C,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa tu contraseña';
                              }
                              if (value.length < 8) {
                                return 'La contraseña debe tener al menos 8 caracteres';
                              }
                              return null;
                            },
                          ),
                      ],
                    ),
                    crossFadeState: _showPasswordField
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: Durations.medium4,
                  ),
                  SizedBox(height: 40.h(context)),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return CircularProgressIndicator.adaptive();
                      }
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: isTablet
                                ? Size(double.infinity, 50.h(context))
                                : Size(double.infinity, 55.h(context))),
                        onPressed: () async {
                          final validate = _formKey.currentState?.validate();
                          if (validate == true) {
                            if (!(await InternetChecker.hasInternetAccess)) {
                              showTopSnackBar(context,
                                  title: text?.noInternet ?? "",
                                  message: text?.noInternetMessage ?? "");
                              return;
                            }
                            try {
                              context
                                  .read<LoginBloc>()
                                  .add(LoginLoadingEvent());
                              if (_showPasswordField) {
                                await AuthController.loginUser(
                                  _userController.text.trim(),
                                  _passwordController.text.trim(),
                                );

                                context.pushNamedAndRemoveUntil(
                                    TabsScreen.routeName);
                              } else {
                                await AuthController.validateUserNameExists(
                                    _userController.text.trim(),
                                    channel: 2);

                                setState(() => _showPasswordField = true);
                              }
                            } catch (e) {
                              final errKey =
                                  e.toString().replaceAll("Exception: ", "");
                              if (errKey == "shared.wrong_login_message" ||
                                  errKey == "shared.blocked_account") {
                                LocalizationHelper.getErrorMessage(
                                    context, errKey);
                              } else {
                                showTopSnackBar(
                                  context,
                                  title: "Ocurrió un error inesperado.",
                                  message: "Por favor, inténtalo de nuevo.",
                                );
                              }
                            } finally {
                              if (!kDebugMode) {
                                _passwordController.clear();
                              }
                              context
                                  .read<LoginBloc>()
                                  .add(LoginSuccessEvent());
                            }
                          }
                        },
                        child: Text("${text?.btnLogin}"),
                      );
                    },
                  ),
                  SizedBox(height: 15.h(context)),
                  TextButton(
                    onPressed: () {},
                    child: Text("${text?.btnForgotPassword}"),
                  ),
                  SizedBox(height: 100.h(context)),
                  GestureDetector(
                    onTap: () async {
                      try {
                        if (!preferences.uFaceIdEnabled) {
                          showTopSnackBar(
                            context,
                            title: text?.faceIdLoginAlertTitle ??
                                "No tienes configurado Face ID o huella digital.",
                            message: text?.faceIdLoginAlertDescription ??
                                "Inicia sesión con tus credenciales y activa esta opción en acceso rápido.",
                            color: colorD3EAFF,
                            iconPath: AppImages.infoCircleAlert,
                          );
                          return;
                        }
                        final validate = await BiometricAuth.authenticate;

                        if (validate) {
                          if (!(await InternetChecker.hasInternetAccess)) {
                            showTopSnackBar(context,
                                title: text?.noInternet ?? "",
                                message: text?.noInternetMessage ?? "");
                            return;
                          }

                          context.read<LoginBloc>().add(LoginLoadingEvent());
                          await AuthController.loginUser(
                            // preferences.uUsuarioFaceID,
                            _userController.text.trim(),
                            preferences.uPassword,
                          );

                          context.pushNamedAndRemoveUntil(TabsScreen.routeName);
                        }
                      } on Exception {
                        showTopSnackBar(
                          context,
                          title: "Ocurrió un error inesperado.",
                          message: "Por favor, inténtalo de nuevo.",
                        );
                      } finally {
                        context.read<LoginBloc>().add(LoginSuccessEvent());
                      }
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
                          "${text?.biometryText}",
                          style: TextStyle(
                            fontSize: 14.w(context),
                            color: color005199,
                            fontWeight: FontWeightEnum.Medium.fWTheme,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          if (image1.isNotEmpty)
            Image(
              image: MemoryImage(base64Decode(image1)),
              height: 100,
            ),
          if (image1.isNotEmpty)
            Image(
              image: MemoryImage(base64Decode(image2)),
              height: 100,
            ),
          SizedBox(height: 75.h(context)),
          SizedBox(
            height: 70.h(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Contacto
                _bottomOption(
                  context,
                  text: "${text?.drawerServicePromotion}",
                  iconPath: AppImages.bookmarksIconPath,
                  onTap: () {},
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: VerticalDivider(
                    color: color07355E.withOpacity(.12),
                  ),
                ),
                // Token
                _bottomOption(
                  context,
                  text: "${text?.token}",
                  iconPath: AppImages.tokenIconPath,
                  onTap: () {
                    //showTokenModal(context);
                    showActivateTokenModal(context);
                  },
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: VerticalDivider(
                    color: color07355E.withOpacity(.12),
                  ),
                ),
                // New User
                _bottomOption(
                  context,
                  text: "${text?.newUser}",
                  iconPath: AppImages.userIconPath,
                  onTap: () {
                    context.pushNamed(ScanFaceScreen.routeName);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showRegisterDeviceDialog(
      BuildContext context) {
    final language = AppLocalizations.of(context);
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: color07355E.withOpacity(0.70),
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          // Título con imagen e ícono

          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 95.w(context),
                height: 95.h(context),
                child: Image.asset(AppImages.alertClose),
              ),
              SizedBox(height: 18.h(context)),
              Text(
                language?.registerDeviceAlertTitle ?? "Registrar dispositivo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.w(context),
                  fontWeight: FontWeightEnum.Bold.fWTheme,
                  color: color07355E,
                ),
              ),
            ],
          ),
          // Contenido explicativo
          contentPadding: EdgeInsets.only(
            top: 8.h(context),
            left: 8.h(context),
            right: 8.h(context),
            bottom: 30.h(context),
          ),
          content: Text(
            language?.registerDeviceAlertDescription ??
                "¿Deseas registrar este dispositivo como de confianza para facilitar futuros accesos?",
            style: TextStyle(
              fontSize: 16.w(context),
              color: color07355E,
            ),
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            OutlinedButton(
              onPressed: () {
                preferences.setDeviceRegistered(true);
                context.pop();
              },
              style: OutlinedButton.styleFrom(
                fixedSize: Size(137.w(context), 50.h(context)),
              ),
              child: Text(
                language?.no ?? "No",
                style: TextStyle(
                  fontSize: 12.w(context),
                  fontWeight: FontWeightEnum.Bold.fWTheme,
                  color: color516578,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                preferences.setDeviceRegistered(true);
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(137.w(context), 50.h(context)),
                backgroundColor: color005199,
              ),
              child: Text(
                language?.yes ?? "Si",
                style: TextStyle(
                  fontSize: 12.w(context),
                  fontWeight: FontWeightEnum.Bold.fWTheme,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showTopSnackBar(
    BuildContext context, {
    required String title,
    required String message,
    Color? color,
    String? iconPath,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 16,
        left: 16,
        right: 16,
        child: ErrorBanner(
          title: title,
          message: message,
          onClose: () {},
          color: color,
          iconPath: iconPath,
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  Widget _bottomOption(
    BuildContext context, {
    required String text,
    required VoidCallback onTap,
    required String iconPath,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: AssetImage(iconPath),
            color: color07355E,
            height: isTablet ? 25.w(context) : 20,
            width: isTablet ? 25.w(context) : 20,
          ),
          SizedBox(height: 4.w(context)),
          Text(
            text,
            style: TextStyle(
              fontSize: isTablet ? 18.w(context) : 14.w(context),
              color: color07355E,
            ),
          ),
        ],
      ),
    );
  }
}

class ErrorBanner extends StatefulWidget {
  final String title;
  final String message;
  final VoidCallback? onClose;
  final Color? color;
  final String? iconPath;

  const ErrorBanner({
    super.key,
    required this.title,
    required this.message,
    this.onClose,
    this.color,
    this.iconPath,
  });

  @override
  State<ErrorBanner> createState() => _ErrorBannerState();
}

class _ErrorBannerState extends State<ErrorBanner> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return !isVisible
        ? SizedBox()
        : Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: widget.color ?? const Color(0xFFFFEFF0),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                if (widget.iconPath == null)
                  Image.asset(
                    widget.iconPath ?? AppImages.danger,
                    width: 25.w(context),
                    height: 25.h(context),
                  )
                else
                  Icon(
                    Icons.info_outline,
                    size: 25.w(context),
                    color: color005199,
                  ),
                SizedBox(width: 12.w(context)),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14.w(context),
                        color: color06243E,
                      ),
                      children: [
                        TextSpan(
                          text: "${widget.title}\n",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: widget.message,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isVisible = false;
                    });
                    if (widget.onClose != null) {
                      widget.onClose!();
                    }
                  },
                  child: const Icon(Icons.close, size: 18, color: color06243E),
                )
              ],
            ),
          );
  }
}
