import 'dart:developer';
import 'dart:io';
import 'package:banca_movil_libs/services/audit_service.dart';

import 'package:banca_movil_libs/banca_movil_libs.dart';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class ProductsServices {
  Future<ProductsModel> getProducts() async {
    try {
      //2817025
      // 1211205 // No tiene tarjetas de credito
      final response = await dioClient.get('product/${preferences.uClientID}');

      // final response = await dioClient.get('product/2817025');
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        AuditService.logEvent("Obtener productos", AuditActionType.read);
        final products = ProductsModel.fromJson(response.data);
        // products.creditCard.products.clear();
        // products.account.products.clear();

        for (var element in products.account.products) {
          element.productTypeEnum = ProductType.account;
          element.productNumberColor = color0080F2;
          element.iconPath = AppImages.ahorros;
        }
        for (var element in products.creditCard.products) {
          element.productTypeEnum = ProductType.card;
          element.productNumberColor = color2E98A4;
          element.iconPath = AppImages.tarjetaCredito;
        }
        for (var element in products.loan.products) {
          element.productTypeEnum = ProductType.loan;
          element.productNumberColor = color003DA6;
          element.iconPath = AppImages.prestamos;
        }
        for (var element in products.fixedTermDeposit.products) {
          element.productTypeEnum = ProductType.fixedTerm;
          element.productNumberColor = colorF17A4C;
          element.iconPath = AppImages.plazoFijo;
        }
        for (var element in products.leasing.products) {
          element.productTypeEnum = ProductType.leasing;
          element.productNumberColor = color0080F2;
          element.iconPath = AppImages.leasing;
        }
        for (var element in products.creditLine.products) {
          element.productTypeEnum = ProductType.creditLine;
          element.productNumberColor = colorF17A4C;
          element.iconPath = AppImages.lineaCredito;
        }
        for (var element in products.factoring.products) {
          element.productTypeEnum = ProductType.factoring;
          element.productNumberColor = color003DA6;
          element.iconPath = AppImages.factoring;
        }
        for (var element in products.interimConstructionLine.products) {
          element.productTypeEnum = ProductType.interimConstructionLine;
          element.productNumberColor = colorF2C94C;
          // TODO remplazar por el icon correcto
          element.iconPath = AppImages.factoring;
        }

        // products.loan.products.addAll(products.loan.products.toList());
        // products.loan.products.addAll(products.loan.products.toList());

        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } on DioException catch (e) {
      AuditService.logEvent(
        "Error al obtener productos",
        AuditActionType.error,
      );
      // Error de red
      if (e.error is SocketException) {
        throw 'no_internet';
      }

      log(e.error.runtimeType.toString());

      rethrow;
    }
  }

  Future<Product> productDetail({required Product product}) async {
    try {
      Response<dynamic> response;
      if (product.productTypeEnum == ProductType.card) {
        response = await dioClient.get(
          "http://apiqa.cajadeahorros.pma:7080/api/v1/tdc/9d3029cf-a124-49ee-ad1c-26e4e2938dd7",
          options: Options(headers: {"X-API-Key": "qa.9rkdfjK4k"}),
        );
      } else {
        response = await dioClient.get(
          'Product/${product.accountNumber}/detail',
          queryParameters: {
            "clientNumber": preferences.uClientID,
            "productType": "${product.productType}",
          },
        );
      }
      if (response.statusCode == 200) {
        AuditService.logEvent(
          "Obtener detalle de producto",
          AuditActionType.read,
        );
        Product productDetail = Product.fromJson(response.data);
        productDetail.productTypeEnum = product.productTypeEnum;
        if (product.productTypeEnum == ProductType.account) {
          return product;
        } else {
          return productDetail;
        }
      } else {
        throw Exception('Failed to load product detail');
      }
    } on DioException catch (e) {
      AuditService.logEvent(
        "Error al obtener detalle de producto",
        AuditActionType.error,
      );
      if (e.error is SocketException) {
        throw 'no_internet';
      }
      rethrow;
    }
  }

  Future<TransactionListModel> productTransactions({
    required Product product,
    required int pageOffset,
  }) async {
    try {
      Response<dynamic> response;

      // final now = DateTime.now();

      // final startDate = now.subtract(Duration(days: 30));

      // final dateFormat = DateFormat('yyyy-MM-dd');

      // final String startDateStr = dateFormat.format(startDate);
      // final String endDateStr = dateFormat.format(now);
      if (product.productTypeEnum == ProductType.card) {
        response = await dioClient.get(
          "http://apiqa.cajadeahorros.pma:7080/api/v1/tdc/b2a27acf-38b0-4d54-934f-e52acf41fcb5/MovimientosTarjeta",
          queryParameters: {"FI": "2023-11-01", "FF": "2023-12-30"},
          options: Options(headers: {"X-API-Key": "qa.9rkdfjK4k"}),
        );
      } else {
        final now = DateTime.now();

        // Último día del mes pasado
        // final endDate =
        //     DateTime(now.year, now.month, 1).subtract(Duration(days: 15));
        // final endDate = DateTime(now.year, now.month, now.day);

        // 180 días antes del endDate
        final startDate = now.subtract(Duration(days: 180));

        final dateFormat = DateFormat('yyyy-MM-dd');

        final String startDateStr = dateFormat.format(startDate);
        final String endDateStr = dateFormat.format(now);

        response = await dioClient.get(
          'Product/${product.accountNumber}/transaction-history',
          queryParameters: {
            "clientNumber": preferences.uClientID,
            "clientId": preferences.uClientID,
            "productType": "${product.productType}",
            "accountType": "${product.type}",
            "productName": "${product.name}",
            "startDate": startDateStr,
            "endDate": endDateStr,
            "pageOffset": "$pageOffset",
            "registriesLimit": "30",
            "transactionState": "0",
            "isInitializing": true,
          },
        );
      }
      if (response.statusCode == 200) {
        AuditService.logEvent(
          "Obtener transacciones de producto",
          AuditActionType.read,
        );
        List<TransactionDetail> transactionDetail = [];
        if (product.productTypeEnum == ProductType.card) {
          response.data["Movimientos"].forEach((element) {
            log("${element["Tipo"]}");
            transactionDetail.add(
              TransactionDetail(
                transactionDate: element["Fecha"],
                narrative: element["Descripcion"],
                amount: element["Monto"],
                transactionCode: element["Tipo"],
                indicatorDc:
                    element["Tipo"] == "C" ? IndicatorDc.CR : IndicatorDc.DB,
              ),
            );
          });
        }

        final list = TransactionListModel.fromJson(response.data);

        list.transactionDetail?.addAll(transactionDetail);

        return list;
      } else {
        throw Exception('Failed to load product transactions');
      }
    } on Exception {
      AuditService.logEvent(
        "Error al obtener transacciones de producto",
        AuditActionType.error,
      );
      rethrow;
    }
  }

  Future<RetenidosYDiferidos> getRetenidosYDiferidos({
    required String accountNumber,
  }) async {
    try {
      final response = await dioClient.get(
        "http://apiqa.cajadeahorros.pma:7080/blcomercial/v1/cuenta/$accountNumber/id/1965727/RetenidosYDiferidos",
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        AuditService.logEvent(
          "Obtener retenidos y diferidos",
          AuditActionType.read,
        );
        final diferidos = RetenidosYDiferidos.fromJson(response.data);
        diferidos.diferidos.addAll(diferidos.retenidos);
        diferidos.retenidos.clear();
        return diferidos;
      } else {
        // throw Exception('Failed to load retenidos y diferidos');
        return RetenidosYDiferidos(
          numeroCuenta: "",
          diferidos: [],
          retenidos: [],
          errorCode: 500,
          errorDescription: "",
        );
      }
    } on DioException catch (e) {
      AuditService.logEvent(
        "Error al obtener retenidos y diferidos",
        AuditActionType.error,
      );
      if (e.error is SocketException) {
        throw 'no_internet';
      }
      rethrow;
    }
  }
}
