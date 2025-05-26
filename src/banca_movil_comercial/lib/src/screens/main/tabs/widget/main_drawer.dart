import 'package:banca_movil_comercial/src/bloc/login_bloc/login_bloc.dart';
import 'package:banca_movil_comercial/src/bloc/login_bloc/login_state.dart';
import 'package:banca_movil_comercial/src/localization/app_localizations.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Asegúrate de tener los assets definidos en AppImages como antes

class CustomMainDrawer extends StatelessWidget {
  const CustomMainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Drawer(
      backgroundColor: Colors.white,
      width: isTablet ? 390.w(context) : 331.w(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15.h(context)),
                        _buildDrawerHeader(
                          context,
                          state.user.user?.name ?? "Usuario Testing",
                        ), // NUEVO COMPONENTE
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              SizedBox(height: 20.h(context)),
              Divider(color: Colors.grey.withOpacity(0.5)),
              SizedBox(height: 10.h(context)),

              _menuOption(
                context,
                text: 'Mis Datos',
                iconPath: AppImages.userIconPath,
              ),
              _menuOption(
                context,
                text: 'Tarjetas',
                iconPath: AppImages.lossCardIconPath,
              ),
              _menuOption(
                context,
                text: 'Token',
                iconPath: AppImages.tokenIconPath,
              ),
              _menuOption(
                context,
                text: 'Biometría',
                iconPath: AppImages.biometryIcon,
              ),
              _menuOption(
                context,
                text: 'Acceso Rápido',
                iconPath: AppImages.quickAccessIcon,
              ),
              _menuOption(
                context,
                text: 'Notificaciones',
                iconPath: AppImages.notificacionDrawer,
              ),
              _menuOption(
                context,
                text: 'Alertas',
                iconPath: AppImages.warningIcon,
              ),
              _menuOption(
                context,
                text: 'Idioma',
                iconPath: AppImages.languageIcon,
              ),
              _menuOption(
                context,
                text: 'Ubícanos',
                iconPath: AppImages.findUsIcon,
              ),
              _menuOption(
                context,
                text: 'Atención al cliente',
                iconPath: AppImages.callCenterIconPath,
              ),
              _menuOption(
                context,
                text: 'Términos y Condiciones',
                iconPath: AppImages.terminosCondicionesIcon,
              ),
              const Spacer(),
              Divider(color: Colors.grey.withOpacity(0.5)),
              SizedBox(height: 10),
              Text(
                "${text.version} 0.1.0",
                style: TextStyle(
                  color: color07355E.withOpacity(.8),
                  fontSize: 12.w(context),
                ),
              ),
              SizedBox(height: 15.h(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context, String? name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Usuario
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                AppImages
                    .wepsys, // Reemplaza con el avatar del usuario si lo tienes
                width: 45.w(context),
                height: 45.w(context),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w(context)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? '',
                  style: TextStyle(
                    fontSize: 14.w(context),
                    fontWeight: FontWeightEnum.Bold.fWTheme,
                    color: color07355E,
                  ),
                ),
                Text(
                  "Autorizador",
                  style: TextStyle(
                    fontSize: 12.w(context),
                    color: const Color(0xFF5D7690),
                    fontWeight: FontWeightEnum.SemiBold.fWTheme,
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 12.h(context)),

        Divider(color: Colors.grey.withOpacity(0.4)),

        SizedBox(height: 10.h(context)),

        // "Mis empresas" + engranaje
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Mis empresas',
              style: TextStyle(
                color: color07355E,
                fontSize: 14.w(context),
                fontWeight: FontWeightEnum.Bold.fWTheme,
              ),
            ),
            Image.asset(
              AppImages.wepsys, // ícono engranaje visual
              height: 18.h(context),
              width: 18.w(context),
            ),
          ],
        ),

        SizedBox(height: 12.h(context)),

        // Empresas
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _companyIcon(context, AppImages.wepsys, 'Wepsys\nLATAM'),
            SizedBox(width: 35.w(context)),
            _companyIcon(context, AppImages.revolt, 'Revolt\nEnterprise'),
            SizedBox(width: 35.w(context)),
            _companyIcon(context, AppImages.eco, 'EcoProducts\nPanama'),
          ],
        ),

        SizedBox(height: 5.h(context)),

        // Divider(color: Colors.grey.withOpacity(0.4)),
      ],
    );
  }

  Widget _companyIcon(BuildContext context, String path, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(2.w(context)),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.withOpacity(0.4)),
          ),
          child: ClipOval(
            child: Image.asset(
              path,
              height: 45.h(context),
              width: 45.w(context),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 6.h(context)),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.w(context),
            height: 1.2,
            color: color07355E,
            fontWeight: FontWeightEnum.Medium.fWTheme,
          ),
        ),
      ],
    );
  }

  Widget _menuOption(
    BuildContext context, {
    required String text,
    required String iconPath,
  }) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(bottom: 24.h(context)),
        child: Row(
          children: [
            Image.asset(iconPath, height: 20.h(context), width: 20.w(context)),
            SizedBox(width: 20.w(context)),
            Text(
              text,
              style: TextStyle(
                color: color07355E,
                fontSize: 14.w(context),
                fontWeight: FontWeightEnum.Medium.fWTheme,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _companyIcon(BuildContext context, String path) {
  //   return Column(
  //     children: [
  //       ClipRRect(
  //         borderRadius: BorderRadius.circular(10),
  //         child: Image.asset(
  //           path,
  //           height: 50.h(context),
  //           width: 35.w(context),
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //       SizedBox(height: 4.h(context)),
  //       Text(
  //         "Empresa", // Puedes reemplazar por el nombre real si lo tienes
  //         style: TextStyle(
  //           fontSize: 10.w(context),
  //           color: color07355E,
  //           fontWeight: FontWeightEnum.SemiBold.fWTheme,
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
