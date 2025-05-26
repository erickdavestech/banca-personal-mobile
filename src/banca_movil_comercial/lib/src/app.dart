import 'package:banca_movil_comercial/src/bloc/beneficiarios_bloc/beneficiarios_bloc.dart';
import 'package:banca_movil_comercial/src/bloc/diferidos_bloc/diferidos_bloc.dart';
import 'package:banca_movil_comercial/src/bloc/languaje/languaje_bloc.dart';
import 'package:banca_movil_comercial/src/bloc/login_bloc/login_bloc.dart';
import 'package:banca_movil_comercial/src/bloc/products_bloc/products_bloc.dart';
import 'package:banca_movil_comercial/src/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:banca_movil_comercial/src/bloc/tab/tab_bloc.dart';
import 'package:banca_movil_comercial/src/localization/app_localizations.dart';
import 'package:banca_movil_comercial/src/routes/routes.dart';
import 'package:banca_movil_comercial/src/screens/authentication/login_screen.dart';
import 'package:banca_movil_comercial/src/screens/main/tabs_screen.dart';
import 'package:banca_movil_comercial/src/screens/products/product_detail.dart';
import 'package:banca_movil_libs/models/product_model.dart';
import 'package:banca_movil_libs/preferences/preferences.dart';
import 'package:banca_movil_libs/services/product_service.dart';
import 'package:banca_movil_libs/themes/themes.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CDAAppComercial extends StatelessWidget {
  const CDAAppComercial({super.key});

  @override
  Widget build(BuildContext context) {
    String initialRoute = LoginScreen.routeName;

    if (kDebugMode) {
      print("borrar:${preferences.uToken.isEmpty}");
      // if (preferences.uToken.isEmpty) {
      //   initialRoute = LoginScreen.routeName;
      // } else {
      //   initialRoute = TabsScreen.routeName;
      // }
    } else {
      initialRoute = LoginScreen.routeName;
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => TabBloc()..add(TabChangeIndex(0))),
        BlocProvider(create: (_) => ProductsBloc(ProductsServices())),
        BlocProvider(
          create:
              (_) => LanguajeBloc()..add(LanguajeEvent(preferences.uLanguaje)),
        ),
        BlocProvider(create: (_) => TransactionBloc()),
        BlocProvider(create: (_) => BeneficiariosBloc()),
        BlocProvider(create: (_) => DiferidosBloc(ProductsServices())),
      ],
      child: BlocBuilder<LanguajeBloc, LanguajeState>(
        builder: (context, langState) {
          final localizations = AppLocalizations.of(context);

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: MaterialApp(
              title: localizations?.appTitle ?? 'Caja de Ahorros',
              scrollBehavior: CustomScrollBehavior(),
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

              // Para rutas que necesitan argumentos
              onGenerateRoute: (settings) {
                if (settings.name == ProductDetail.routeName) {
                  final product = settings.arguments as Product;
                  return MaterialPageRoute(
                    builder: (_) => ProductDetail(product: product),
                  );
                }

                return null;
              },
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.noScaling),
                  child: child!,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
