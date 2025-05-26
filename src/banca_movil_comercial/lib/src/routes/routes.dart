import 'package:banca_movil_comercial/src/screens/authentication/widgets/face_capture_page.dart';
import 'package:banca_movil_comercial/src/screens/languaje/languaje_screen.dart';
import 'package:banca_movil_comercial/src/screens/main/list_products_transfer_screen.dart';
import 'package:banca_movil_comercial/src/screens/main/tabs/main_screen.dart';
import 'package:banca_movil_comercial/src/screens/main/tabs/products_screen.dart';
import 'package:banca_movil_comercial/src/screens/main/tabs/request_screen.dart';
import 'package:banca_movil_comercial/src/screens/products/interbank_transfer.dart';
import 'package:banca_movil_comercial/src/screens/products/list_beneficiario_transfer_screen.dart';
import 'package:banca_movil_comercial/src/screens/products/transactions_in_progress_screen.dart';
import 'package:banca_movil_comercial/src/screens/products/transfer_completed_screen.dart';
import 'package:banca_movil_comercial/src/screens/products/transferencia_page.dart';
import 'package:banca_movil_comercial/src/screens/products/widgets/validatior_screen.dart';
import 'package:flutter/material.dart';

import '../screens/authentication/login_screen.dart';
import '../screens/authentication/scan_document_screen.dart';
import '../screens/authentication/scan_face_screen.dart';
import '../screens/main/tabs_screen.dart';

/// Para registrar rutas que no necesitan argumentos, para las que sí
/// ir a banca_movil_comercial/lib/src/app.dart en onGenerateRoute
Map<String, WidgetBuilder> get getAppRoutes => <String, WidgetBuilder>{
  LoginScreen.routeName: (_) => LoginScreen(),
  ScanFaceScreen.routeName: (_) => ScanFaceScreen(),
  ScanDocumentScreen.routeName: (_) => ScanDocumentScreen(),
  MainScreen.routeName: (_) => MainScreen(),
  TabsScreen.routeName: (_) => TabsScreen(),
  ProductsScreen.routeName: (_) => ProductsScreen(),
  RequestScreen.routeName: (_) => RequestScreen(),
  TransactionsInProgressScreen.routeName: (_) => TransactionsInProgressScreen(),
  LanguajeScreen.routeName: (_) => LanguajeScreen(),
  TransferBetweenAccountsScreen.routeName:
      (_) => TransferBetweenAccountsScreen(),
  ProductsTransferScreen.routeName: (_) => ProductsTransferScreen(),
  BeneficiariosTransferScreen.routeName: (_) => BeneficiariosTransferScreen(),
  InterbankScreen.routeName: (_) => InterbankScreen(),
  TransferCompletedScreen.routeName: (_) => TransferCompletedScreen(),
  ValidandoTokenLoader.routeName: (_) => ValidandoTokenLoader(title: ""),
  FaceCapturePage.routeName: (_) => const FaceCapturePage(),
};
