import 'package:banca_movil_comercial/src/app.dart';
import 'package:banca_movil_libs/preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show SystemChrome, SystemUiMode, SystemUiOverlay;
import 'package:intl/intl.dart';

//
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );

  await preferences.init();

  Intl.defaultLocale = preferences.uLanguaje;

  runApp(const AppWrapper());
}

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: Future.delayed(const Duration(milliseconds: 100)),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const MaterialApp(
    //         home: Scaffold(body: Center(child: CircularProgressIndicator())),
    //       );
    //     }
    return const CDAAppComercial();
    //   },
    // );
  }
}
