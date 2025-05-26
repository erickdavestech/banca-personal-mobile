import 'package:ca_mobile/src/screens/authentication/scan_face_token_activation_screen.dart';
import 'package:ca_mobile/src/screens/configurations/faceid_configuration_screen.dart';
import 'package:ca_mobile/src/screens/configurations/faceid_completed_screen.dart';
import 'package:ca_mobile/src/screens/languaje/languaje_screen.dart';
import 'package:ca_mobile/src/screens/main/list_products_transfer_screen.dart';
import 'package:ca_mobile/src/screens/main/tabs/main_screen.dart';
import 'package:ca_mobile/src/screens/main/tabs/products_screen.dart';
import 'package:ca_mobile/src/screens/main/tabs/request_screen.dart';
import 'package:ca_mobile/src/screens/products/interbank_transfer.dart';
import 'package:ca_mobile/src/screens/products/list_beneficiario_transfer_screen.dart';
import 'package:ca_mobile/src/screens/products/product_detail.dart';
import 'package:ca_mobile/src/screens/products/transactions_in_progress_screen.dart';
import 'package:ca_mobile/src/screens/products/transfer_completed_screen.dart';
import 'package:ca_mobile/src/screens/products/transferencia_page.dart';
import 'package:ca_mobile/src/screens/products/widgets/create_beneficiary_screen.dart';
import 'package:ca_mobile/src/screens/products/widgets/validatior_screen.dart';
import 'package:ca_mobile/src/screens/products/transactions_list_extended.dart';
import 'package:flutter/material.dart';

import '../screens/authentication/login_screen.dart';
import '../screens/authentication/scan_document_screen.dart';
import '../screens/authentication/scan_face_screen.dart';
import '../screens/main/tabs_screen.dart';

Map<String, WidgetBuilder> get getAppRoutes => <String, WidgetBuilder>{
      LoginScreen.routeName: (_) => LoginScreen(),
      ScanFaceScreen.routeName: (_) => ScanFaceScreen(),
      ScanDocumentScreen.routeName: (_) => ScanDocumentScreen(),
      MainScreen.routeName: (_) => MainScreen(),
      TabsScreen.routeName: (_) => TabsScreen(),
      ProductsScreen.routeName: (_) => ProductsScreen(),
      ProductDetail.routeName: (_) => ProductDetail(),
      RequestScreen.routeName: (_) => RequestScreen(),
      TransactionsInProgressScreen.routeName: (_) =>
          TransactionsInProgressScreen(),
      LanguajeScreen.routeName: (_) => LanguajeScreen(),
      TransferBetweenAccountsScreen.routeName: (_) =>
          TransferBetweenAccountsScreen(),
      ProductsTransferScreen.routeName: (_) => ProductsTransferScreen(),
      BeneficiariosTransferScreen.routeName: (_) =>
          BeneficiariosTransferScreen(),
      InterbankScreen.routeName: (_) => InterbankScreen(),
      TransferCompletedScreen.routeName: (_) => TransferCompletedScreen(),
      ValidandoTokenLoader.routeName: (_) => ValidandoTokenLoader(title: ""),
      FaceIdConfigurationScreen.routeName: (_) => FaceIdConfigurationScreen(),
      FaceIdCompletedScreen.routeName: (_) => FaceIdCompletedScreen(),
      TransactionListExtended.routeName: (_) => const TransactionListExtended(),
      ScanFaceTokenActivationScreen.routeName: (_) =>
          const ScanFaceTokenActivationScreen(),
      CreateBeneficiaryScreen.routeName: (_) => CreateBeneficiaryScreen(),
    };
