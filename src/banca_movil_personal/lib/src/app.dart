import 'package:ca_mobile/src/bloc/beneficiarios_bloc/beneficiarios_bloc.dart';
import 'package:ca_mobile/src/bloc/diferidos_bloc/diferidos_bloc.dart';
import 'package:ca_mobile/src/bloc/languaje/languaje_bloc.dart';
import 'package:ca_mobile/src/bloc/login_bloc/login_bloc.dart';
import 'package:ca_mobile/src/bloc/products_bloc/products_bloc.dart';
import 'package:ca_mobile/src/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart';
import 'package:ca_mobile/src/routes/routes.dart';
import 'package:ca_mobile/src/screens/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'bloc/tab/tab_bloc.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';

class CajaDeAhorros extends StatelessWidget {
  const CajaDeAhorros({super.key});

  @override
  Widget build(BuildContext context) {
    String initialRoute = LoginScreen.routeName;

    // if (kDebugMode) {
    //   if (preferences.uToken.isEmpty) {
    //     initialRoute = LoginScreen.routeName;
    //   } else {
    //     initialRoute = TabsScreen.routeName;
    //   }
    // } else {
    //   initialRoute = LoginScreen.routeName;
    // }
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => TabBloc()..add(TabChangeIndex(0))),
        BlocProvider(create: (_) => ProductsBloc(ProductsServices())),
        BlocProvider(
          create: (_) =>
              LanguajeBloc()..add(LanguajeEvent(preferences.uLanguaje)),
        ),
        BlocProvider(create: (_) => TransactionBloc()),
        BlocProvider(create: (_) => BeneficiariosBloc()),
        BlocProvider(create: (_) => DiferidosBloc(ProductsServices())),
      ],
      child: BlocBuilder<LanguajeBloc, LanguajeState>(
        builder: (context, langState) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: MaterialApp(
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: TextScaler.noScaling),
                  child: child!,
                );
              },
              scrollBehavior: MyCustomScrollBehavior(),
              title: "Caja de Ahorros Personal",
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale(langState.languajeCode),
              theme: themeData(context),
              darkTheme: themeData(context),
              initialRoute: initialRoute,
              routes: getAppRoutes,
            ),
          );
        },
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child; // Elimina el efecto de rebote
  }
}
