import 'package:banca_movil_comercial/src/extensions/context_extensions.dart';
import 'package:banca_movil_comercial/src/extensions/scroll_extensions.dart';
import 'package:banca_movil_comercial/src/screens/products/widgets/transaction_history/account/account_pending_transactions_widget.dart';
import 'package:banca_movil_comercial/src/screens/products/widgets/transaction_history/single_transaction_item_widget.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';

class TransactionHistoryWidget extends StatefulWidget {
  final Product product;
  final TransactionListModel transactionList;

  const TransactionHistoryWidget({
    super.key,
    required this.product,
    required this.transactionList,
  });

  @override
  State<TransactionHistoryWidget> createState() =>
      _TransactionHistoryWidgetState();
}

class _TransactionHistoryWidgetState extends State<TransactionHistoryWidget> {
  late final bool showPendingTransactionsButton =
      widget.product.productTypeEnum == ProductType.card ||
      widget.product.productTypeEnum == ProductType.account;

  // TODO: @Sherly remove this one and take the one from the widget when implemented the request
  late TransactionListModel transactionList;
  TransactionListModel getFakeTransactionList() {
    return TransactionListModel(
      transactionDetail: [
        TransactionDetail(
          amount: -500.00,
          date: DateTime.parse("2024-12-10T00:00:00Z"),
          transactionDate: DateTime.parse("2024-12-10T00:00:00Z"),
          narrative: "Pago de Servicios",
          reference: "REF123456",
          transactionCode: "TRX001",
          userName: "Juan Pérez",
          branch: 101,
          bank: "Banco Popular",
          indicatorDc: IndicatorDc.DB,
        ),
        TransactionDetail(
          amount: 1500.00,
          date: DateTime.parse("2024-12-09T00:00:00Z"),
          transactionDate: DateTime.parse("2024-12-09T00:00:00Z"),
          narrative: "Depósito Nómina",
          reference: "REF987654",
          transactionCode: "TRX002",
          userName: "Juan Pérez",
          branch: 101,
          bank: "Banco Popular",
          indicatorDc: IndicatorDc.CR,
        ),
        TransactionDetail(
          amount: -250.00,
          date: DateTime.parse("2024-12-08T00:00:00Z"),
          transactionDate: DateTime.parse("2024-12-08T00:00:00Z"),
          narrative: "Compra Supermercado",
          reference: "SUP345678",
          transactionCode: "TRX003",
          userName: "Juan Pérez",
          branch: 101,
          bank: "Banco Popular",
          indicatorDc: IndicatorDc.DB,
        ),
        TransactionDetail(
          amount: -120.00,
          date: DateTime.parse("2024-12-07T00:00:00Z"),
          transactionDate: DateTime.parse("2024-12-07T00:00:00Z"),
          narrative: "Pago Netflix",
          reference: "NETFLIX0912",
          transactionCode: "TRX004",
          userName: "Juan Pérez",
          branch: 101,
          bank: "Banco Popular",
          indicatorDc: IndicatorDc.DB,
        ),
        TransactionDetail(
          amount: 300.00,
          date: DateTime.parse("2024-12-06T00:00:00Z"),
          transactionDate: DateTime.parse("2024-12-06T00:00:00Z"),
          narrative: "Transferencia Recibida",
          reference: "TRF456789",
          transactionCode: "TRX005",
          userName: "Juan Pérez",
          branch: 101,
          bank: "Banco Popular",
          indicatorDc: IndicatorDc.CR,
        ),
      ],
      totalCount: 5,
      page: 1,
      pageSize: 5,
    );
  }

  @override
  void initState() {
    transactionList = getFakeTransactionList();
    super.initState();
  }

  double getSheetSizeByProductType() {
    if (widget.product.productTypeEnum == ProductType.card) {
      return 0.45;
    } else if (widget.product.productTypeEnum == ProductType.loan) {
      return 0.51;
    }
    return 0.65;
  }

  /// TODO: Sherly implement this
  Future<void> fetchTransactions() async {}

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: getSheetSizeByProductType(),
      minChildSize: getSheetSizeByProductType(),
      maxChildSize: getSheetSizeByProductType(),
      builder: (context, scrollController) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w(context),
                vertical: 10.h(context),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 8),
                    color: color07355E.withOpacity(.18),
                    blurRadius: 74,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // DRAG HANDLE
                  Center(
                    child: Container(
                      width: 60.w(context),
                      height: 4.h(context),
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      decoration: BoxDecoration(
                        color: color07355E.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  // HEADING
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.lang.productDetailHistory,
                          style: TextStyle(
                            color: color07355E,
                            fontSize: 14,
                            fontWeight: FontWeightEnum.SemiBold.fWTheme,
                          ),
                        ),

                        // VIEW MORE BTN
                        InkWell(
                          onTap: () async {},
                          child: Text(
                            context.lang.productDetailMoreButton,
                            style: TextStyle(
                              color: color005199,
                              fontSize: 14, // <<< NO uses .w(context) aquí
                              fontWeight: FontWeightEnum.SemiBold.fWTheme,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.w(context)),

                  if (showPendingTransactionsButton)
                    AccountPendingTransactionsWidget(product: widget.product),
                  SizedBox(height: 15.w(context)),

                  Expanded(
                    flex: 4,
                    child: ListView(
                      physics: SmoothClampingScrollPhysics(),
                      controller: scrollController,
                      children: [
                        ...transactionList.transactionDetail!.map(
                          (e) => SingleTransactionItem(
                            transactionType:
                                e.indicatorDc == IndicatorDc.DB
                                    ? TransactionType.debit
                                    : TransactionType.credit,
                            transactionDetail: e,
                            isFromCardTransaction:
                                !widget
                                    .product
                                    .associatedDebitCards
                                    .isNullOrEmpty,
                            // TODO: @Sherly, ask and set this dinamically
                            cardNumber:
                                !widget
                                        .product
                                        .associatedDebitCards
                                        .isNullOrEmpty
                                    ? widget
                                        .product
                                        .associatedDebitCards!
                                        .first
                                        .cardNumber
                                    : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
