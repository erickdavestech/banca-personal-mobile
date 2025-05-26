import 'package:banca_movil_comercial/src/bloc/diferidos_bloc/diferidos_bloc.dart';
import 'package:banca_movil_comercial/src/bloc/products_bloc/products_bloc.dart';
import 'package:banca_movil_comercial/src/extensions/context_extensions.dart';
import 'package:banca_movil_comercial/src/screens/widgets/loading_bar.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPendingTransactionsWidget extends StatelessWidget {
  final Product product;
  const AccountPendingTransactionsWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state is DetailProductLoading) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            margin: EdgeInsets.only(top: 20),
            width: double.infinity,
            decoration: BoxDecoration(color: color005199.withOpacity(.05)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LoadingBar(width: 185.w(context), height: 10.h(context)),
                LoadingBar(width: 70.w(context), height: 10.h(context)),
              ],
            ),
          );
        }
        return BlocBuilder<DiferidosBloc, DiferidosState>(
          builder: (context, state) {
            RetenidosYDiferidos? diferidos;

            num total = 0;

            if (state is DiferidosLoaded) {
              diferidos = state.diferidos;

              for (var element in diferidos.diferidos) {
                total += element.monto ?? 0;
              }
              for (var element in diferidos.retenidos) {
                total += element.monto ?? 0;
              }
            }

            if (state is DiferidosLoading) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                margin: EdgeInsets.only(top: 20),
                width: double.infinity,
                decoration: BoxDecoration(color: color005199.withOpacity(.05)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LoadingBar(width: 185.w(context), height: 10.h(context)),
                    LoadingBar(width: 70.w(context), height: 10.h(context)),
                  ],
                ),
              );
            }

            return GestureDetector(
              onTap: () async {
                context.read<ProductsBloc>().add(
                  TransactionsNextPage(product, 1),
                );
                // await context.push(
                //   TransactionsInProgressScreen(
                //     diferidos: diferidos,
                //   ),
                // );

                context.read<ProductsBloc>().add(GetDetailProduct(product));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                margin: EdgeInsets.only(top: 20),
                width: double.infinity,
                decoration: BoxDecoration(color: color005199.withOpacity(.05)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.lang.productDetailProccesTransactions,
                      style: TextStyle(
                        color: color07355E,
                        fontSize: 14.w(context),
                        fontWeight: FontWeightEnum.SemiBold.fWTheme,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "B./ ${total.priceFormat}",
                      style: TextStyle(
                        color: color07355E,
                        fontSize: 14,
                        fontWeight: FontWeightEnum.SemiBold.fWTheme,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: color1C274C,
                      size: 12.w(context),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
