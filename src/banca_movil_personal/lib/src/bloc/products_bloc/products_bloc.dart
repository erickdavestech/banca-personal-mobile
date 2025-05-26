// ignore_for_file: unused_import

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsServices productService;

  List<TransactionDetail> transactionList = [];
  List<TransactionDetail> transactionListFiltered = [];

  ProductsBloc(this.productService) : super(ProductsInitial()) {
    on<FilterTransactions>((event, emit) {
      transactionListFiltered = transactionList
          .where((tx) =>
              tx.narrative?.toLowerCase().contains(event.query.toLowerCase()) ??
              false)
          .toList();

      final currentState = state;
      if (currentState is DetailProductLoaded) {
        emit(DetailProductLoaded(
          currentState.product,
          TransactionListModel(
            transactionDetail: transactionListFiltered,
            totalCount: currentState.transactionListModel.totalCount,
            page: currentState.transactionListModel.page,
            pageSize: currentState.transactionListModel.pageSize,
          ),
        ));
      }
    });
    on<GetProducts>(getProducts);

    on<GetDetailProduct>((event, emit) async {
      emit(DetailProductLoading());
      try {
        transactionList.clear();
        transactionListFiltered.clear();
        final product =
            await productService.productDetail(product: event.product);

        TransactionListModel transactions = await _getTransactions(event);

        transactionList = transactions.transactionDetail ?? [];
        transactionListFiltered = List.from(transactionList);

        emit(DetailProductLoaded(product, transactions));
        // emit(DetailProductError("e.toString()"));
      } catch (e) {
        // if (event.product.productTypeEnum == ProductType.card) {
        //   emit(DetailProductLoaded(
        //       Product(
        //         productTypeEnum: ProductType.card,
        //         errorCode: 0,
        //         errorDescription: "",
        //         codigoTipoMensaje: "0110",
        //         codigodeEmisor: "",
        //         numerodeCuenta: "",
        //         numerodeTarjeta: "4765280307270368",
        //         saldoLocal: 0.00,
        //         pagoMinimoLocal: 0.00,
        //         pagoContadoLocal: 0.00,
        //         disponibleLocal: 3017.43,
        //         adelanto: 1500.00,
        //         dispLocalTarjeta: 3017.43,
        //         adelLocalTarjeta: 1500.00,
        //         debitosLocal: 0.00,
        //         creditosLocal: 0.00,
        //         subtSalCorteLocal: 0.00,
        //         cargosBonifLocal: 0.00,
        //         salTotCorteLocal: 0.00,
        //         saldoFPlazoLocal: 0.00,
        //         cargonoBonifLocal: 0.00,
        //         recargcuotaLocal: 0.00,
        //         totalCalcPmLocal: 0.00,
        //         saldoInternacional: -17.43,
        //         pagoMinimoInt: 0.00,
        //         pagoContadoInt: 0.00,
        //         disponibleInt: 3017.43,
        //         adelantoInt: 1500.00,
        //         dispIntTarjeta: 3017.43,
        //         adelIntTarjeta: 1500.00,
        //         debitosInt: 0.00,
        //         creditosInt: 20.00,
        //         subtSalCorteInter: 0.00,
        //         cargosBonifInter: 0.00,
        //         salTotCorteInter: 0.00,
        //         saldoFinalPlazoInter: 0.00,
        //         cargonoBonifInte: 0.00,
        //         recargcuotaInter: 0.00,
        //         totalCalcPmInter: 0.00,
        //         limiteCtaLocal: 3000.00,
        //         limiteCtaInter: 3000.00,
        //         limiteTarLocal: 10000.00,
        //         limiteTarInter: 0.00,
        //         saldoTarLocal: 0.00,
        //         saldoTarInter: 0.00,
        //         fechaCorte: DateTime.parse("2024-12-21T00:00:00.000"),
        //         fechaVencimientodelPago:
        //             DateTime.parse("2024-12-22T00:00:00.000"),
        //         nombre: "JAIME JOEL JIMENEZ MORENO",
        //         limiteEfLocal: 0.00,
        //         saldoInicialEfLocal: 0.00,
        //         debitosAplicadosEfLocal: 0.00,
        //         creditosAplicadosEfLocal: 0.00,
        //         saldoFinalEfLocal: 0.00,
        //         disponibleEfLocal: 0.00,
        //         limiteEfInter: 0.00,
        //         saldoInicialEfInter: 0.00,
        //         debitosAplicadosEfInter: 0.00,
        //         creditosAplicadosEfInter: 0.00,
        //         saldoFinalEfInter: 0.00,
        //         disponibleEfInter: 0.00,
        //         estadoCuenta: "00",
        //         estadoTarjeta: "00",
        //         estadoTarjetaDescripcion: "Activa",
        //         importevencidoLocal: 0.00,
        //         montoimporteLocal: 0.00,
        //         importevencidoInternacional: 0.00,
        //         montoimporteInternacional: 0.00,
        //         numeroExtrafinanciamiento: "",
        //         debitoTransitoLocal: 0.00,
        //         creditoTransitoLocal: 0.00,
        //         debitoTransitoInternacional: 0.00,
        //         creditoTransitoInternacional: 0.00,
        //         tasaInteresMensualLocal: "000000",
        //         tasaInteresMensualInternacional: "000000",
        //         tasaInteresMoratoriaLocal: "000000",
        //         tasaInteresMoratoriaInternacional: "000000",
        //         saldoInicialCorteLocal: 0.00,
        //         saldoInicialCorteEnInternacional: 0.00,
        //         montoUltimoPago: 7.8213E+2,
        //         fechaUltimoPago: DateTime.parse("2023-12-28T00:00:00.000"),
        //         tasaInteres: 0E+0,
        //         codigodeRespuesta: "00",
        //         descripcionCodigodeRespuesta: "Transacción Exitosa",
        //       ),
        //       TransactionListModel()));
        // } else {
        emit(DetailProductError(e.toString()));
        // }
      }
    });

    on<TransactionsNextPage>((event, emit) async {
      try {
        final transactions =
            await getTransactions(event.product, event.nextPage);
        transactionList.addAll(transactions.transactionDetail ?? []);
        transactionListFiltered.addAll(transactions.transactionDetail ?? []);
        transactions.transactionDetail = transactionList;
        emit(DetailProductLoaded(event.product, transactions));
      } catch (e) {
        emit(DetailProductError(e.toString()));
      }
    });
  }

  Future<TransactionListModel> _getTransactions(GetDetailProduct event) async {
    try {
      final transactions = await getTransactions(event.product, 1);
      return transactions;
    } on Exception {
      return TransactionListModel();
    }
  }

  Future<TransactionListModel> getTransactions(
      Product product, int pageKey) async {
    final transactions = await productService.productTransactions(
        product: product, pageOffset: pageKey);
    return transactions;
  }

  Future<void> getProducts(
    GetProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      ProductsModel products = await productService.getProducts();

      emit(ProductsLoaded(products: products));
      // emit(ProductsError(message: "e.toString()"));
    } catch (e) {
      log("$e");
      emit(ProductsError(message: e.toString()));
    }
  }
}
