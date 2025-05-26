import 'package:banca_movil_comercial/src/bloc/diferidos_bloc/diferidos_bloc.dart';
import 'package:banca_movil_comercial/src/bloc/products_bloc/products_bloc.dart';
import 'package:banca_movil_comercial/src/localization/app_localizations.dart';
import 'package:banca_movil_comercial/src/screens/products/transactions_in_progress_screen.dart';
import 'package:banca_movil_comercial/src/screens/products/widgets/transaction_list.dart';
import 'package:banca_movil_comercial/src/screens/widgets/loading_bar.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    super.key,
    required this.product,
    required this.text,
  });

  final Product product;
  final AppLocalizations text;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.53,
      minChildSize: 0.53,
      maxChildSize: 0.53,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 8),
                color: Colors.black.withOpacity(.2),
                blurRadius: 74,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 3,
                margin: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: color07355E.withOpacity(.23),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text.productDetailHistory.capitalizeSentences,
                    style: TextStyle(
                      color: color07355E,
                      fontSize: 14.w(context),
                      fontWeight: FontWeightEnum.SemiBold.fWTheme,
                    ),
                  ),
                  Text(
                    text.productDetailMoreButton,
                    style: TextStyle(
                      color: color043371,
                      fontSize: 14.w(context),
                      fontWeight: FontWeightEnum.SemiBold.fWTheme,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.w(context)),
              Expanded(
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  controller: scrollController,
                  child: Column(
                    children: [
                      if (product.productTypeEnum != ProductType.loan)
                        BlocBuilder<ProductsBloc, ProductsState>(
                          builder: (context, state) {
                            if (state is DetailProductLoading) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 20,
                                ),
                                margin: EdgeInsets.only(top: 20),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: color043371.withOpacity(.05),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    LoadingBar(
                                      width: 185.w(context),
                                      height: 10.h(context),
                                    ),
                                    LoadingBar(
                                      width: 70.w(context),
                                      height: 10.h(context),
                                    ),
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
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 20,
                                    ),
                                    margin: EdgeInsets.only(top: 20),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: color043371.withOpacity(.05),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LoadingBar(
                                          width: 185.w(context),
                                          height: 10.h(context),
                                        ),
                                        LoadingBar(
                                          width: 70.w(context),
                                          height: 10.h(context),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                return GestureDetector(
                                  onTap: () {
                                    context.read<ProductsBloc>().add(
                                      TransactionsNextPage(product, 1),
                                    );
                                    context.push(
                                      TransactionsInProgressScreen(
                                        diferidos: diferidos,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 20,
                                    ),
                                    margin: EdgeInsets.only(top: 20),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: color043371.withOpacity(.05),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          text
                                              .productDetailProccesTransactions
                                              .capitalizeSentences,
                                          style: TextStyle(
                                            color: color07355E,
                                            fontSize: 14.w(context),
                                            fontWeight:
                                                FontWeightEnum.SemiBold.fWTheme,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "B./ ${total.priceFormat}",
                                          style: TextStyle(
                                            color: color07355E,
                                            fontSize: 14,
                                            fontWeight:
                                                FontWeightEnum.SemiBold.fWTheme,
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
                        ),
                      //
                      TransactionList(
                        onLoaded: (TransactionListModel model) {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
