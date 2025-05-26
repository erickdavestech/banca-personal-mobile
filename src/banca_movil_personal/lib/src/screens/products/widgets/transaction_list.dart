import 'package:ca_mobile/src/bloc/products_bloc/products_bloc.dart';
import 'package:ca_mobile/src/screens/main/tabs/widget/list_titlte_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
    required this.onLoaded,
    this.diferidos,
  });
  final Function(TransactionListModel) onLoaded;
  final RetenidosYDiferidos? diferidos;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state is DetailProductLoaded && diferidos == null) {
          final transactions =
              state.transactionListModel.transactionDetail ?? [];

          if (transactions.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.noResultsFound,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }

          return Column(
            children: List.generate(
              transactions.length,
              (index) {
                final item = transactions[index];

                final color = item.indicatorDc == IndicatorDc.CR
                    ? color07355E
                    : colorCE1228;

                return Column(
                  children: [
                    TransactionTile(
                      title: item.narrative ?? '',
                      date: item.date == null
                          ? null
                          : DateFormat("yyyy/MM/dd").format(item.date!),
                      amount: item.amount ?? 0,
                      color: color,
                    ),
                    Divider(color: colorD9E0E6),
                  ],
                );
              },
            ),
          );
        }

        return Column(
          children: List.generate(
            diferidos?.diferidos.length ?? 0,
            (index) {
              final item = diferidos?.diferidos[index];

              return Column(
                children: [
                  TransactionTile(
                    title: item?.descripcion ?? '',
                    date: item?.fechaProceso ?? '',
                    amount: item?.monto ?? 0,
                    color: color07355E,
                  ),
                  Divider(color: colorD9E0E6),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

// class _LoadingWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Shimmer(
//       colorOpacity: 1,
//       duration: Duration(seconds: 2),
//       child: Column(
//         spacing: 20.h(context),
//         children: List.generate(
//           5,
//           (index) => Column(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   LoadingBar(
//                     width: 42.w(context),
//                     height: 42.w(context),
//                   ),
//                   SizedBox(width: 20.w(context)),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     spacing: 12.h(context),
//                     children: [
//                       LoadingBar(
//                         width: 150.w(context),
//                         height: 10.w(context),
//                       ),
//                       LoadingBar(
//                         width: 75.w(context),
//                         height: 10.w(context),
//                       ),
//                     ],
//                   ),
//                   Spacer(),
//                   LoadingBar(
//                     width: 64.w(context),
//                     height: 10.w(context),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20.h(context),
//               ),
//               Divider(
//                 height: 0,
//                 color: colorD9E0E6,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
