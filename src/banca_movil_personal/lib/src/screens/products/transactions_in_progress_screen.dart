import 'package:ca_mobile/src/localization/app_localizations.dart';
import 'package:ca_mobile/src/screens/products/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'package:banca_movil_libs/banca_movil_libs.dart';

class TransactionsInProgressScreen extends StatefulWidget {
  static const String routeName = '/transactions-in-progress';

  final RetenidosYDiferidos? diferidos;

  const TransactionsInProgressScreen({super.key, this.diferidos});

  @override
  State<TransactionsInProgressScreen> createState() =>
      _TransactionsInProgressScreenState();
}

class _TransactionsInProgressScreenState
    extends State<TransactionsInProgressScreen> {
  late ScrollController _scrollController;
  bool isLoading = false;
  int currentIndex = 1;
  int productsLenght = 0;
  int totalProducts = 0;
  num total = 0;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // _scrollController.addListener(_onScroll);

    for (var element in widget.diferidos?.diferidos ?? <Ido>[]) {
      total += element.monto ?? 0;
    }
    for (var element in widget.diferidos?.retenidos ?? <Ido>[]) {
      total += element.monto ?? 0;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // void _onScroll() {
  //   if (_scrollController.position.pixels >=
  //       _scrollController.position.maxScrollExtent * 0.8) {
  //     if (widget.product != null) {
  //       _loadMore();
  //     }
  //   }
  // }

  // Future<void> _loadMore() async {
  //   if (isLoading || productsLenght >= totalProducts) return;
  //   isLoading = true;

  //   context
  //       .read<ProductsBloc>()
  //       .add(TransactionsNextPage(widget.product!, currentIndex + 1));

  //   currentIndex++;
  // }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return PopScope(
      // onPopInvoked: (didPop) =>
      //     context.read<ProductsBloc>().add(GetDetailProduct(widget.product!)),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(72.h(context)),
          child: AppBar(
            elevation: 4,
            leading: IconButton(
              onPressed: context.pop,
              icon: Image(
                width: 25.w(context),
                image: AssetImage(AppImages.backBtn),
              ),
            ),
            title: Text(
              text.productDetailProccesTransactions,
              style: TextStyle(
                fontSize: 16.w(context),
                fontWeight: FontWeight.w500,
                color: color06243E,
              ),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(1.0),
              child: Divider(
                color: colorD5D5D5,
                thickness: 1,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                margin: EdgeInsets.only(top: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color005199.withOpacity(.05),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text.totalTransactionAmount,
                      style: TextStyle(
                        color: color07355E,
                        fontSize: 14.w(context),
                        fontWeight: FontWeightEnum.SemiBold.fWTheme,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "B./ ${total.priceFormat} ",
                      style: TextStyle(
                          color: color07355E,
                          fontSize: 14,
                          fontWeight: FontWeightEnum.SemiBold.fWTheme),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.w(context),
              ),
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  children: [
                    if (widget.diferidos != null)
                      TransactionList(
                        diferidos: widget.diferidos!,
                        onLoaded: (TransactionListModel model) {
                          totalProducts = model.totalCount ?? 0;
                          productsLenght = model.transactionDetail?.length ?? 0;
                          isLoading = false;
                        },
                      ),
                    if (isLoading)
                      Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
