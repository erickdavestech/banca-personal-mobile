// // To parse this JSON data, do
// //
// //     final productsModel = productsModelFromJson(jsonString);

// import 'dart:convert';

// import 'package:banca_movil_libs/banca_movil_libs.dart';
// import 'package:ca_mobile/src/screens/main/tabs/main_screen.dart';
// import 'package:flutter/material.dart';

// ProductsModel productsModelFromJson(String str) =>
//     ProductsModel.fromJson(json.decode(str));

// String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

// class ProductsModel {
//   String id;
//   ProductItem account;
//   ProductItem loan;
//   ProductItem fixedTermDeposit;
//   ProductItem creditCard;

//   ProductsModel({
//     required this.id,
//     required this.account,
//     required this.loan,
//     required this.fixedTermDeposit,
//     required this.creditCard,
//   });

//   factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
//         id: json["id"],
//         account: ProductItem.fromJson(json["account"]),
//         loan: ProductItem.fromJson(json["loan"]),
//         fixedTermDeposit: ProductItem.fromJson(json["fixedTermDeposit"]),
//         creditCard: ProductItem.fromJson(json["creditCard"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "account": account.toJson(),
//         "loan": loan.toJson(),
//         "fixedTermDeposit": fixedTermDeposit.toJson(),
//         "creditCard": creditCard.toJson(),
//       };
// }

// class ProductItem {
//   double totalBalance;
//   double totalAvailable;
//   List<Product> products;

//   ProductItem({
//     required this.totalBalance,
//     required this.totalAvailable,
//     required this.products,
//   });

//   factory ProductItem.fromJson(Map<String, dynamic> json) {
//     return ProductItem(
//       totalBalance: json["totalBalance"]?.toDouble(),
//       totalAvailable: json["totalAvailable"]?.toDouble(),
//       products:
//           List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "totalBalance": totalBalance,
//         "totalAvailable": totalAvailable,
//         "products": List<dynamic>.from(products.map((x) => x.toJson())),
//       };
// }

// class Product {
//   String? id;
//   String? accountNumber;
//   String? productCode;
//   String? line;
//   String? description;
//   String? name;
//   dynamic balance;
//   String? available;
//   String? currency;
//   num? productType;
//   String? accountType;
//   String? accountTypeDescription;
//   dynamic accountStatus;
//   String? descriptionStatus;
//   String? tokenId;
//   List<AssociatedDebitCard>? associatedDebitCards;
//   ProductType? productTypeEnum;
//   Color productNumberColor;
//   String iconPath;
//   String typeDescription;
//   String balanceTitle;
//   String contableAccount;
//   num retainedAmount;
//   dynamic denominationalName;
//   num type;
//   String numberDescription;
//   num? errorCode;
//   String? errorDescription;
//   String? codigoTipoMensaje;
//   String? codigodeEmisor;
//   String? numerodeCuenta;
//   String? numerodeTarjeta;
//   num? saldoLocal;
//   num? pagoMinimoLocal;
//   num? pagoContadoLocal;
//   num? disponibleLocal;
//   num? adelanto;
//   num? dispLocalTarjeta;
//   num? adelLocalTarjeta;
//   num? debitosLocal;
//   num? creditosLocal;
//   num? subtSalCorteLocal;
//   num? cargosBonifLocal;
//   num? salTotCorteLocal;
//   num? saldoFPlazoLocal;
//   num? cargonoBonifLocal;
//   num? recargcuotaLocal;
//   num? totalCalcPmLocal;
//   num? saldoInternacional;
//   num? pagoMinimoInt;
//   num? pagoContadoInt;
//   num? disponibleInt;
//   num? adelantoInt;
//   num? dispIntTarjeta;
//   num? adelIntTarjeta;
//   num? debitosInt;
//   num? creditosInt;
//   num? subtSalCorteInter;
//   num? cargosBonifInter;
//   num? salTotCorteInter;
//   num? saldoFinalPlazoInter;
//   num? cargonoBonifInte;
//   num? recargcuotaInter;
//   num? totalCalcPmInter;
//   num? limiteCtaLocal;
//   num? limiteCtaInter;
//   num? limiteTarLocal;
//   num? limiteTarInter;
//   num? saldoTarLocal;
//   num? saldoTarInter;
//   DateTime? fechaCorte;
//   DateTime? fechaVencimientodelPago;
//   String? nombre;
//   num? limiteEfLocal;
//   num? saldoInicialEfLocal;
//   num? debitosAplicadosEfLocal;
//   num? creditosAplicadosEfLocal;
//   num? saldoFinalEfLocal;
//   num? disponibleEfLocal;
//   num? limiteEfInter;
//   num? saldoInicialEfInter;
//   num? debitosAplicadosEfInter;
//   num? creditosAplicadosEfInter;
//   num? saldoFinalEfInter;
//   num? disponibleEfInter;
//   String? estadoCuenta;
//   String? estadoTarjeta;
//   String? estadoTarjetaDescripcion;
//   num? importevencidoLocal;
//   num? montoimporteLocal;
//   num? importevencidoInternacional;
//   num? montoimporteInternacional;
//   String? numeroExtrafinanciamiento;
//   num? debitoTransitoLocal;
//   num? creditoTransitoLocal;
//   num? debitoTransitoInternacional;
//   num? creditoTransitoInternacional;
//   String? tasaInteresMensualLocal;
//   String? tasaInteresMensualInternacional;
//   String? tasaInteresMoratoriaLocal;
//   String? tasaInteresMoratoriaInternacional;
//   num? saldoInicialCorteLocal;
//   num? saldoInicialCorteEnInternacional;
//   num? montoUltimoPago;
//   DateTime? fechaUltimoPago;
//   num? tasaInteres;
//   String? codigodeRespuesta;
//   String? descripcionCodigodeRespuesta;
//   num? balanceInArrears;
//   num? pendingAmount;
//   num? originalAmount;
//   num? nextQuote;
//   num? anualInterestRate;
//   num? missingQuotes;
//   num? paidQuotes;
//   DateTime? startDate;
//   DateTime? expireDate;
//   num? lateFeeAmount;
//   num? lastPaymentAmount;
//   num? interestPaidPreviousYear;
//   num? interestRatePaidLastYear;
//   String? hasGuarantee;
//   num? guaranteeAmount;
//   num? feciAmount;
//   num? deductionsAmount;
//   num? agreedInstallment;
//   DateTime? lastPaymentDate;
//   DateTime? nextPaymentDate;

//   double? anualRate;
//   dynamic hasCard;
//   String? associatedAccount;
//   dynamic associatedCards;
//   dynamic numOfContracts;
//   dynamic amount;
//   dynamic creditLimit;
//   dynamic availableBalance;
//   dynamic outlay;
//   dynamic availableLocal;
//   dynamic cardLimitInt;
//   dynamic cutDate;

//   dynamic minimumLocalPayment;

//   Product({
//     this.id,
//     this.accountNumber,
//     this.productCode,
//     this.line,
//     this.description,
//     this.name,
//     this.balance,
//     this.available,
//     this.currency,
//     this.productType,
//     this.accountType,
//     this.accountTypeDescription,
//     this.accountStatus,
//     this.descriptionStatus,
//     this.tokenId,
//     this.associatedDebitCards,
//     this.productTypeEnum,
//     this.productNumberColor = Colors.black,
//     this.iconPath = '',
//     this.typeDescription = '',
//     this.balanceTitle = '',
//     this.contableAccount = '',
//     this.retainedAmount = 0,
//     this.denominationalName,
//     this.type = 0,
//     this.numberDescription = '',
//     this.errorCode,
//     this.errorDescription,
//     this.codigoTipoMensaje,
//     this.codigodeEmisor,
//     this.numerodeCuenta,
//     this.numerodeTarjeta,
//     this.saldoLocal,
//     this.pagoMinimoLocal,
//     this.pagoContadoLocal,
//     this.disponibleLocal,
//     this.adelanto,
//     this.dispLocalTarjeta,
//     this.adelLocalTarjeta,
//     this.debitosLocal,
//     this.creditosLocal,
//     this.subtSalCorteLocal,
//     this.cargosBonifLocal,
//     this.salTotCorteLocal,
//     this.saldoFPlazoLocal,
//     this.cargonoBonifLocal,
//     this.recargcuotaLocal,
//     this.totalCalcPmLocal,
//     this.saldoInternacional,
//     this.pagoMinimoInt,
//     this.pagoContadoInt,
//     this.disponibleInt,
//     this.adelantoInt,
//     this.dispIntTarjeta,
//     this.adelIntTarjeta,
//     this.debitosInt,
//     this.creditosInt,
//     this.subtSalCorteInter,
//     this.cargosBonifInter,
//     this.salTotCorteInter,
//     this.saldoFinalPlazoInter,
//     this.cargonoBonifInte,
//     this.recargcuotaInter,
//     this.totalCalcPmInter,
//     this.limiteCtaLocal,
//     this.limiteCtaInter,
//     this.limiteTarLocal,
//     this.limiteTarInter,
//     this.saldoTarLocal,
//     this.saldoTarInter,
//     this.fechaCorte,
//     this.fechaVencimientodelPago,
//     this.nombre,
//     this.limiteEfLocal,
//     this.saldoInicialEfLocal,
//     this.debitosAplicadosEfLocal,
//     this.creditosAplicadosEfLocal,
//     this.saldoFinalEfLocal,
//     this.disponibleEfLocal,
//     this.limiteEfInter,
//     this.saldoInicialEfInter,
//     this.debitosAplicadosEfInter,
//     this.creditosAplicadosEfInter,
//     this.saldoFinalEfInter,
//     this.disponibleEfInter,
//     this.estadoCuenta,
//     this.estadoTarjeta,
//     this.estadoTarjetaDescripcion,
//     this.importevencidoLocal,
//     this.montoimporteLocal,
//     this.importevencidoInternacional,
//     this.montoimporteInternacional,
//     this.numeroExtrafinanciamiento,
//     this.debitoTransitoLocal,
//     this.creditoTransitoLocal,
//     this.debitoTransitoInternacional,
//     this.creditoTransitoInternacional,
//     this.tasaInteresMensualLocal,
//     this.tasaInteresMensualInternacional,
//     this.tasaInteresMoratoriaLocal,
//     this.tasaInteresMoratoriaInternacional,
//     this.saldoInicialCorteLocal,
//     this.saldoInicialCorteEnInternacional,
//     this.montoUltimoPago,
//     this.fechaUltimoPago,
//     this.tasaInteres,
//     this.codigodeRespuesta,
//     this.descripcionCodigodeRespuesta,
//     this.balanceInArrears,
//     this.pendingAmount,
//     this.originalAmount,
//     this.nextQuote,
//     this.anualInterestRate,
//     this.missingQuotes,
//     this.paidQuotes,
//     this.startDate,
//     this.expireDate,
//     this.lateFeeAmount,
//     this.lastPaymentAmount,
//     this.interestPaidPreviousYear,
//     this.interestRatePaidLastYear,
//     this.hasGuarantee,
//     this.guaranteeAmount,
//     this.feciAmount,
//     this.deductionsAmount,
//     this.agreedInstallment,
//     this.lastPaymentDate,
//     this.nextPaymentDate,
//     this.anualRate,
//     this.hasCard,
//     this.amount,
//     this.associatedAccount,
//     this.associatedCards,
//     this.availableBalance,
//     this.availableLocal,
//     this.cardLimitInt,
//     this.cutDate,
//     this.minimumLocalPayment,
//     this.outlay,
//     this.creditLimit,
//     this.numOfContracts,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"] ?? '',
//         accountNumber: json["accountNumber"] ?? '',
//         productCode: json["productCode"] ?? '',
//         line: json["line"] ?? '',
//         description: json["description"] ?? '',
//         name: json["name"] ?? '',
//         balance: json["balance"] ?? 0,
//         available: json["available"] ?? '',
//         currency: json["currency"] ?? '',
//         productType: json["productType"] ?? 0,
//         accountType: json["accountType"] ?? '',
//         accountTypeDescription: json["accountTypeDescription"] ?? '',
//         accountStatus: json["accountStatus"] ?? '',
//         descriptionStatus: json["descriptionStatus"] ?? '',
//         tokenId: json["tokenId"] ?? '',
//         associatedDebitCards: json["associatedDebitCards"] == null
//             ? []
//             : List<AssociatedDebitCard>.from(
//                 json["associatedDebitCards"].map(
//                   (x) => AssociatedDebitCard.fromJson(x),
//                 ),
//               ),
//         contableAccount: json["contableAccount"] ?? '',
//         retainedAmount: json["retainedAmount"] ?? 0,
//         denominationalName: json["denominationalName"] ?? '',
//         type: json["type"] ?? 0,
//         errorCode: json["errorCode"],
//         errorDescription: json["errorDescription"],
//         codigoTipoMensaje: json["CodigoTipoMensaje"],
//         codigodeEmisor: json["CodigodeEmisor"],
//         numerodeCuenta: json["NumerodeCuenta"],
//         numerodeTarjeta: json["NumerodeTarjeta"],
//         saldoLocal: json["SaldoLocal"],
//         pagoMinimoLocal: json["PagoMinimoLocal"],
//         pagoContadoLocal: json["PagoContadoLocal"],
//         disponibleLocal: json["DisponibleLocal"],
//         adelanto: json["Adelanto"],
//         dispLocalTarjeta: json["DispLocalTarjeta"],
//         adelLocalTarjeta: json["AdelLocalTarjeta"],
//         debitosLocal: json["DebitosLocal"],
//         creditosLocal: json["CreditosLocal"],
//         subtSalCorteLocal: json["SubtSalCorteLocal"],
//         cargosBonifLocal: json["CargosBonifLocal"],
//         salTotCorteLocal: json["SalTotCorteLocal"],
//         saldoFPlazoLocal: json["SaldoFPlazoLocal"],
//         cargonoBonifLocal: json["CargonoBonifLocal"],
//         recargcuotaLocal: json["RecargcuotaLocal"],
//         totalCalcPmLocal: json["TotalCalcPMLocal"],
//         saldoInternacional: json["SaldoInternacional"],
//         pagoMinimoInt: json["PagoMinimoInt"],
//         pagoContadoInt: json["PagoContadoInt"],
//         disponibleInt: json["DisponibleInt"],
//         adelantoInt: json["AdelantoInt"],
//         dispIntTarjeta: json["DispIntTarjeta"],
//         adelIntTarjeta: json["AdelIntTarjeta"],
//         debitosInt: json["DebitosInt"],
//         creditosInt: json["CreditosInt"],
//         subtSalCorteInter: json["SubtSalCorteInter"],
//         cargosBonifInter: json["CargosBonifInter"],
//         salTotCorteInter: json["SalTotCorteInter"],
//         saldoFinalPlazoInter: json["SaldoFinalPlazoInter"],
//         cargonoBonifInte: json["CargonoBonifInte"],
//         recargcuotaInter: json["RecargcuotaInter"],
//         totalCalcPmInter: json["TotalCalcPMInter"],
//         limiteCtaLocal: json["LimiteCtaLocal"],
//         limiteCtaInter: json["LimiteCtaInter"],
//         limiteTarLocal: json["LimiteTarLocal"],
//         limiteTarInter: json["LimiteTarInter"],
//         saldoTarLocal: json["SaldoTarLocal"],
//         saldoTarInter: json["SaldoTarInter"],
//         fechaCorte: json["FechaCorte"] == null
//             ? null
//             : DateTime.parse(json["FechaCorte"]),
//         fechaVencimientodelPago: json["FechaVencimientodelPago"] == null
//             ? null
//             : DateTime.parse(json["FechaVencimientodelPago"]),
//         nombre: json["Nombre"],
//         limiteEfLocal: json["LimiteEFLocal"],
//         saldoInicialEfLocal: json["SaldoInicialEFLocal"],
//         debitosAplicadosEfLocal: json["DebitosAplicadosEFLocal"],
//         creditosAplicadosEfLocal: json["CreditosAplicadosEFLocal"],
//         saldoFinalEfLocal: json["SaldoFinalEFLocal"],
//         disponibleEfLocal: json["DisponibleEFLocal"],
//         limiteEfInter: json["LimiteEFInter"],
//         saldoInicialEfInter: json["SaldoInicialEFInter"],
//         debitosAplicadosEfInter: json["DebitosAplicadosEFInter"],
//         creditosAplicadosEfInter: json["CreditosAplicadosEFInter"],
//         saldoFinalEfInter: json["SaldoFinalEFInter"],
//         disponibleEfInter: json["DisponibleEFInter"],
//         estadoCuenta: json["EstadoCuenta"],
//         estadoTarjeta: json["EstadoTarjeta"],
//         estadoTarjetaDescripcion: json["EstadoTarjetaDescripcion"],
//         importevencidoLocal: json["ImportevencidoLocal"],
//         montoimporteLocal: json["MontoimporteLocal"],
//         importevencidoInternacional: json["ImportevencidoInternacional"],
//         montoimporteInternacional: json["MontoimporteInternacional"],
//         numeroExtrafinanciamiento: json["NumeroExtrafinanciamiento"],
//         debitoTransitoLocal: json["DebitoTransitoLocal"],
//         creditoTransitoLocal: json["CreditoTransitoLocal"],
//         debitoTransitoInternacional: json["DebitoTransitoInternacional"],
//         creditoTransitoInternacional: json["CreditoTransitoInternacional"],
//         tasaInteresMensualLocal: json["TasaInteresMensualLocal"],
//         tasaInteresMensualInternacional:
//             json["TasaInteresMensualInternacional"],
//         tasaInteresMoratoriaLocal: json["TasaInteresMoratoriaLocal"],
//         tasaInteresMoratoriaInternacional:
//             json["TasaInteresMoratoriaInternacional"],
//         saldoInicialCorteLocal: json["SaldoInicialCorteLocal"],
//         saldoInicialCorteEnInternacional:
//             json["SaldoInicialCorteEnInternacional"],
//         montoUltimoPago: json["MontoUltimoPago"],
//         fechaUltimoPago: json["FechaUltimoPago"] == null
//             ? null
//             : DateTime.parse(json["FechaUltimoPago"]),
//         tasaInteres: json["TasaInteres"],
//         codigodeRespuesta: json["CodigodeRespuesta"],
//         descripcionCodigodeRespuesta: json["DescripcionCodigodeRespuesta"],
//         balanceInArrears: json["balanceInArrears"],
//         pendingAmount: json["pendingAmount"],
//         originalAmount: json["originalAmount"],
//         nextQuote: json["nextQuote"],
//         anualInterestRate: json["anualInterestRate"],
//         missingQuotes: json["missingQuotes"],
//         paidQuotes: json["paidQuotes"],
//         startDate: json["startDate"] == null
//             ? null
//             : DateTime.parse(json["startDate"]),
//         expireDate: json["expireDate"] == null
//             ? null
//             : DateTime.parse(json["expireDate"]),
//         lateFeeAmount: json["lateFeeAmount"],
//         lastPaymentAmount: json["lastPaymentAmount"],
//         interestPaidPreviousYear: json["interestPaidPreviousYear"],
//         interestRatePaidLastYear: json["interestRatePaidLastYear"],
//         hasGuarantee: json["hasGuarantee"],
//         guaranteeAmount: json["guaranteeAmount"],
//         feciAmount: json["feciAmount"],
//         deductionsAmount: json["deductionsAmount"],
//         agreedInstallment: json["agreedInstallment"],
//         lastPaymentDate: json["lastPaymentDate"] == null
//             ? null
//             : DateTime.parse(json["lastPaymentDate"]),
//         nextPaymentDate: json["nextPaymentDate"] == null
//             ? null
//             : DateTime.parse(json["nextPaymentDate"]),
//         anualRate: json["anualRate"],
//         hasCard: json["hasCard"],
//         associatedAccount: json["associatedAccount"],
//         associatedCards: json["associatedCards"],
//         numOfContracts: json["numOfContracts"],
//         amount: json["amount"],
//         creditLimit: json["creditLimit"],
//         availableBalance: json["availableBalance"],
//         availableLocal: json["availableLocal"],
//         cardLimitInt: json["cardLimitInt"],
//         cutDate: json["cutDate"],
//         minimumLocalPayment: json["minimumLocalPayment"],
//         outlay: json["outlay"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "accountNumber": accountNumber,
//         "productCode": productCode,
//         "line": line,
//         "description": description,
//         "name": name,
//         "balance": balance,
//         "available": available,
//         "currency": currency,
//         "productType": productType,
//         "accountType": accountType,
//         "accountTypeDescription": accountTypeDescription,
//         "accountStatus": accountStatus,
//         "descriptionStatus": descriptionStatus,
//         "tokenId": tokenId,
//         "associatedDebitCards": List<dynamic>.from(
//           associatedDebitCards!.map((x) => x.toJson()),
//         ),
//         "contableAccount": contableAccount,
//         "retainedAmount": retainedAmount,
//         "denominationalName": denominationalName,
//         "type": type,
//         "errorCode": errorCode,
//         "errorDescription": errorDescription,
//         "CodigoTipoMensaje": codigoTipoMensaje,
//         "CodigodeEmisor": codigodeEmisor,
//         "NumerodeCuenta": numerodeCuenta,
//         "NumerodeTarjeta": numerodeTarjeta,
//         "SaldoLocal": saldoLocal,
//         "PagoMinimoLocal": pagoMinimoLocal,
//         "PagoContadoLocal": pagoContadoLocal,
//         "DisponibleLocal": disponibleLocal,
//         "Adelanto": adelanto,
//         "DispLocalTarjeta": dispLocalTarjeta,
//         "AdelLocalTarjeta": adelLocalTarjeta,
//         "DebitosLocal": debitosLocal,
//         "CreditosLocal": creditosLocal,
//         "SubtSalCorteLocal": subtSalCorteLocal,
//         "CargosBonifLocal": cargosBonifLocal,
//         "SalTotCorteLocal": salTotCorteLocal,
//         "SaldoFPlazoLocal": saldoFPlazoLocal,
//         "CargonoBonifLocal": cargonoBonifLocal,
//         "RecargcuotaLocal": recargcuotaLocal,
//         "TotalCalcPMLocal": totalCalcPmLocal,
//         "SaldoInternacional": saldoInternacional,
//         "PagoMinimoInt": pagoMinimoInt,
//         "PagoContadoInt": pagoContadoInt,
//         "DisponibleInt": disponibleInt,
//         "AdelantoInt": adelantoInt,
//         "DispIntTarjeta": dispIntTarjeta,
//         "AdelIntTarjeta": adelIntTarjeta,
//         "DebitosInt": debitosInt,
//         "CreditosInt": creditosInt,
//         "SubtSalCorteInter": subtSalCorteInter,
//         "CargosBonifInter": cargosBonifInter,
//         "SalTotCorteInter": salTotCorteInter,
//         "SaldoFinalPlazoInter": saldoFinalPlazoInter,
//         "CargonoBonifInte": cargonoBonifInte,
//         "RecargcuotaInter": recargcuotaInter,
//         "TotalCalcPMInter": totalCalcPmInter,
//         "LimiteCtaLocal": limiteCtaLocal,
//         "LimiteCtaInter": limiteCtaInter,
//         "LimiteTarLocal": limiteTarLocal,
//         "LimiteTarInter": limiteTarInter,
//         "SaldoTarLocal": saldoTarLocal,
//         "SaldoTarInter": saldoTarInter,
//         "FechaCorte":
//             "${fechaCorte!.year.toString().padLeft(4, '0')}-${fechaCorte!.month.toString().padLeft(2, '0')}-${fechaCorte!.day.toString().padLeft(2, '0')}",
//         "FechaVencimientodelPago":
//             "${fechaVencimientodelPago!.year.toString().padLeft(4, '0')}-${fechaVencimientodelPago!.month.toString().padLeft(2, '0')}-${fechaVencimientodelPago!.day.toString().padLeft(2, '0')}",
//         "Nombre": nombre,
//         "LimiteEFLocal": limiteEfLocal,
//         "SaldoInicialEFLocal": saldoInicialEfLocal,
//         "DebitosAplicadosEFLocal": debitosAplicadosEfLocal,
//         "CreditosAplicadosEFLocal": creditosAplicadosEfLocal,
//         "SaldoFinalEFLocal": saldoFinalEfLocal,
//         "DisponibleEFLocal": disponibleEfLocal,
//         "LimiteEFInter": limiteEfInter,
//         "SaldoInicialEFInter": saldoInicialEfInter,
//         "DebitosAplicadosEFInter": debitosAplicadosEfInter,
//         "CreditosAplicadosEFInter": creditosAplicadosEfInter,
//         "SaldoFinalEFInter": saldoFinalEfInter,
//         "DisponibleEFInter": disponibleEfInter,
//         "EstadoCuenta": estadoCuenta,
//         "EstadoTarjeta": estadoTarjeta,
//         "EstadoTarjetaDescripcion": estadoTarjetaDescripcion,
//         "ImportevencidoLocal": importevencidoLocal,
//         "MontoimporteLocal": montoimporteLocal,
//         "ImportevencidoInternacional": importevencidoInternacional,
//         "MontoimporteInternacional": montoimporteInternacional,
//         "NumeroExtrafinanciamiento": numeroExtrafinanciamiento,
//         "DebitoTransitoLocal": debitoTransitoLocal,
//         "CreditoTransitoLocal": creditoTransitoLocal,
//         "DebitoTransitoInternacional": debitoTransitoInternacional,
//         "CreditoTransitoInternacional": creditoTransitoInternacional,
//         "TasaInteresMensualLocal": tasaInteresMensualLocal,
//         "TasaInteresMensualInternacional": tasaInteresMensualInternacional,
//         "TasaInteresMoratoriaLocal": tasaInteresMoratoriaLocal,
//         "TasaInteresMoratoriaInternacional": tasaInteresMoratoriaInternacional,
//         "SaldoInicialCorteLocal": saldoInicialCorteLocal,
//         "SaldoInicialCorteEnInternacional": saldoInicialCorteEnInternacional,
//         "MontoUltimoPago": montoUltimoPago,
//         "FechaUltimoPago":
//             "${fechaUltimoPago!.year.toString().padLeft(4, '0')}-${fechaUltimoPago!.month.toString().padLeft(2, '0')}-${fechaUltimoPago!.day.toString().padLeft(2, '0')}",
//         "TasaInteres": tasaInteres,
//         "CodigodeRespuesta": codigodeRespuesta,
//         "DescripcionCodigodeRespuesta": descripcionCodigodeRespuesta,
//         "balanceInArrears": balanceInArrears,
//         "pendingAmount": pendingAmount,
//         "originalAmount": originalAmount,
//         "nextQuote": nextQuote,
//         "anualInterestRate": anualInterestRate,
//         "missingQuotes": missingQuotes,
//         "paidQuotes": paidQuotes,
//         "startDate":
//             "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
//         "expireDate":
//             "${expireDate!.year.toString().padLeft(4, '0')}-${expireDate!.month.toString().padLeft(2, '0')}-${expireDate!.day.toString().padLeft(2, '0')}",
//         "lateFeeAmount": lateFeeAmount,
//         "lastPaymentAmount": lastPaymentAmount,
//         "interestPaidPreviousYear": interestPaidPreviousYear,
//         "interestRatePaidLastYear": interestRatePaidLastYear,
//         "hasGuarantee": hasGuarantee,
//         "guaranteeAmount": guaranteeAmount,
//         "feciAmount": feciAmount,
//         "deductionsAmount": deductionsAmount,
//         "agreedInstallment": agreedInstallment,
//         "lastPaymentDate":
//             "${lastPaymentDate!.year.toString().padLeft(4, '0')}-${lastPaymentDate!.month.toString().padLeft(2, '0')}-${lastPaymentDate!.day.toString().padLeft(2, '0')}",
//         "nextPaymentDate":
//             "${nextPaymentDate!.year.toString().padLeft(4, '0')}-${nextPaymentDate!.month.toString().padLeft(2, '0')}-${nextPaymentDate!.day.toString().padLeft(2, '0')}",
//       };
// }

// class AssociatedDebitCard {
//   String id;
//   String cardType;
//   int cardStatus;
//   String tokenId;
//   String cardNumber;
//   String cardName;

//   AssociatedDebitCard({
//     required this.id,
//     required this.cardType,
//     required this.cardStatus,
//     required this.tokenId,
//     required this.cardNumber,
//     required this.cardName,
//   });

//   factory AssociatedDebitCard.fromJson(Map<String, dynamic> json) =>
//       AssociatedDebitCard(
//         id: json["id"],
//         cardType: json["cardType"],
//         cardStatus: json["cardStatus"],
//         tokenId: json["tokenId"],
//         cardNumber: json["cardNumber"],
//         cardName: json["cardName"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "cardType": cardType,
//         "cardStatus": cardStatus,
//         "tokenId": tokenId,
//         "cardNumber": cardNumber,
//         "cardName": cardName,
//       };
// }
