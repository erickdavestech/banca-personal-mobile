import 'package:banca_movil_comercial/src/bloc/products_bloc/products_bloc.dart';
import 'package:banca_movil_comercial/src/screens/main/tabs/widget/list_titlte_products.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key, required this.onLoaded, this.diferidos});
  final Function(TransactionListModel) onLoaded;
  final RetenidosYDiferidos? diferidos;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state is DetailProductLoaded && diferidos == null) {
          return Column(
            children: List.generate(
              state.transactionListModel.transactionDetail?.length ?? 0,
              (index) {
                final item =
                    state.transactionListModel.transactionDetail![index];

                final color =
                    item.indicatorDc == IndicatorDc.CR
                        ? color07355E
                        : colorCE1228;

                final bool isCreditTransaction =
                    item.indicatorDc == IndicatorDc.CR;

                return Column(
                  children: [
                    TransactionTile(
                      title: item.narrative ?? '',
                      date:
                          item.date == null
                              ? null
                              : DateFormat("yyyy/MM/dd").format(item.date!),
                      amount: item.amount ?? 0,
                      // indicatorDc: item.indicatorDc,
                      color: color,
                      isCredit: isCreditTransaction,
                    ),
                    Divider(color: colorD9E0E6),
                  ],
                );
              },
            ),
          );
        }
        return Column(
          children: List.generate(diferidos?.diferidos.length ?? 0, (index) {
            final item = diferidos?.diferidos[index];

            return Column(
              children: [
                TransactionTile(
                  title: item?.descripcion ?? '',
                  date: item?.fechaProceso ?? '',
                  amount: item?.monto ?? 0,
                  color: color07355E,
                  isCredit: true,
                ),
                Divider(color: colorD9E0E6),
              ],
            );
          }),
        );
      },
    );
  }
}
