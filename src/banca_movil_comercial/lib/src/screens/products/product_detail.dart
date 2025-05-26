import 'package:banca_movil_comercial/src/bloc/products_bloc/products_bloc.dart';
import 'package:banca_movil_comercial/src/extensions/context_extensions.dart';
import 'package:banca_movil_comercial/src/localization/app_localizations.dart';
import 'package:banca_movil_comercial/src/screens/products/widgets/interim_construction_card.dart';
import 'package:banca_movil_comercial/src/screens/products/widgets/credit_line_card.dart';
import 'package:banca_movil_comercial/src/screens/products/widgets/factoring_card.dart';
import 'package:banca_movil_comercial/src/screens/products/widgets/leasing_card.dart';
import 'package:banca_movil_comercial/src/screens/products/widgets/loan.dart';
import 'package:banca_movil_comercial/src/screens/products/widgets/account.dart';
import 'package:banca_movil_comercial/src/screens/products/widgets/card.dart';
import 'package:banca_movil_comercial/src/screens/products/widgets/transaction_history/transaction_history_widget.dart';
import 'package:banca_movil_comercial/src/screens/widgets/loading_bar.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ProductDetail extends StatefulWidget {
  static const String routeName = '/ProductDetail';
  // const ProductDetail({super.key, this.tabIndex, this.scaffoldKey});

  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late Product product;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      product = ModalRoute.of(context)!.settings.arguments as Product;
      context.read<ProductsBloc>().add(GetDetailProduct(product));
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) => context.read<ProductsBloc>().add(GetProducts()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: context.pop,
            icon: Image(
              width: 25.w(context),
              image: AssetImage(AppImages.backBtn),
            ),
          ),
          title: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              if (state is DetailProductLoading) {
                return LoadingBar(width: 204.w(context), height: 10.h(context));
              }
              return _title(context, product);
            },
          ),
        ),
        body: Stack(
          children: [
            BlocBuilder<ProductsBloc, ProductsState>(
              buildWhen: (previous, current) {
                // if (current is DetailProductError) {
                //   if (current.message == "no_internet") {
                //     _showNoInternetModal(context, item);
                //   }
                // }

                return true;
              },
              builder: (context, state) {
                if (state is DetailProductLoading) {
                  return _LoadingWidget();
                } else if (state is DetailProductError) {
                  return Center(child: Text(state.message));
                } else if (state is DetailProductLoaded) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _card(state.product),
                        SizedBox(height: 20.h(context)),
                        SizedBox(
                          height: 110.h(context),
                          child: _optionsByProductType(context, product),
                        ),
                        SizedBox(height: 20.h(context)),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            // TODO: @Sherly send the right transaction list model
            TransactionHistoryWidget(
              product: product,
              transactionList: TransactionListModel(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title(BuildContext context, Product product) {
    final text = context.lang;
    final style = TextStyle(
      color: color07355E,
      fontSize: 16.w(context),
      fontWeight: FontWeightEnum.SemiBold.fWTheme,
    );

    final accNumber = product.accountNumber?.obtenerUltimosDigitos;
    switch (product.productTypeEnum!) {
      case ProductType.account:
        return Text("${text.accountTitle} *$accNumber", style: style);
      case ProductType.card:
        return Text("${text.creditCard} *$accNumber", style: style);
      case ProductType.loan:
        return Text.rich(
          TextSpan(
            text: "${text.loan} *$accNumber",
            style: style,
            children: [
              TextSpan(
                text: "\n${product.description?.capitalizeSentences}",
                style: TextStyle(
                  fontSize: 16.w(context),
                  color: color506578,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        );
      case ProductType.fixedTerm:
        return Text(text.fixedTermDeposit, style: style);
      case ProductType.creditCard:
        return Text(text.cardTabTitle, style: style);
      case ProductType.fixedTermDeposit:
        return Text(text.depositosTabTitle, style: style);
      case ProductType.leasing:
        return Text("${text.leasingTitle} *$accNumber", style: style);
      case ProductType.creditLine:
        return Text("${text.creditLineTitle} *$accNumber", style: style);
      case ProductType.factoring:
        return Text("${text.factoringTitle} *$accNumber", style: style);
      case ProductType.interimConstructionLine:
        return Text(
          "${text.interimConstructionTitle} *$accNumber",
          style: style,
        );
    }
  }

  Widget _card(Product product) {
    switch (product.productTypeEnum!) {
      case ProductType.account:
        return Account(product: product);
      case ProductType.card:
        return CreditCard(product: product);
      case ProductType.loan:
        return LoanCard(product: product);
      case ProductType.fixedTerm:
        return SizedBox.shrink();

      case ProductType.creditCard:
        return SizedBox.shrink();
      case ProductType.fixedTermDeposit:
        return SizedBox.shrink();
      case ProductType.leasing:
        return LeasingCard(product: product); // Crear si aún no existe
      case ProductType.creditLine:
        return CreditLineCard(product: product); // Crear si aún no existe
      case ProductType.factoring:
        return FactoringCard(product: product); // Crear si aún no existe
      case ProductType.interimConstructionLine:
        return InterimConstructionCard(
          product: product,
        ); // Crear si aún no existe
    }
  }

  Widget _optionBtn({
    required BuildContext context,
    required String text,
    required String imagePath,
    required ProductType type,
  }) {
    if (type == ProductType.card) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 18.w(context),
              vertical: 17.h(context),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: colorD9E0E6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ImageIcon(AssetImage(imagePath), color: color043371),
          ),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(fontSize: 12.w(context), color: color51708E),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
    if (type == ProductType.loan) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 62.54.w(context),
              vertical: 21.12.h(context),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: colorD9E0E6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ImageIcon(AssetImage(imagePath), color: color043371),
          ),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(fontSize: 12.w(context), color: color07355E),
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 38.w(context),
              vertical: 18.h(context),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: colorD9E0E6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ImageIcon(AssetImage(imagePath), color: color043371),
          ),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(fontSize: 12.w(context), color: color51708E),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }

  Widget _optionsByProductType(BuildContext context, Product type) {
    final text = AppLocalizations.of(context)!;

    if (type.productTypeEnum == ProductType.card) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _optionBtn(
            context: context,
            text: text.btnCardInfo,
            imagePath: AppImages.card2,
            type: ProductType.card,
          ),
          VerticalDivider(color: colorDAE1E7, endIndent: 15),
          _optionBtn(
            context: context,
            text: text.btnCardPay,
            imagePath: AppImages.cardSend,
            type: ProductType.card,
          ),
          VerticalDivider(color: colorDAE1E7, endIndent: 15),
          _optionBtn(
            context: context,
            text: text.btnCardBlock,
            imagePath: AppImages.cardLock,
            type: ProductType.card,
          ),
          VerticalDivider(color: colorDAE1E7, endIndent: 15),
          _optionBtn(
            context: context,
            text: text.btnStatusCard.capitalizeSentences,
            imagePath: AppImages.cardView,
            type: ProductType.card,
          ),
        ],
      );
    }
    if (type.productTypeEnum == ProductType.loan) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _optionBtn(
            context: context,
            text: text.listProductsLoanButtonPay,
            imagePath: AppImages.handMoney,
            type: ProductType.account,
          ),
          VerticalDivider(color: colorDAE1E7, endIndent: 15),
          _optionBtn(
            context: context,
            text: "${text.more}\n${text.options}",
            imagePath: AppImages.menu,
            type: ProductType.account,
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _optionBtn(
            context: context,
            text: text.transferenciaTitle,
            imagePath: AppImages.moneyCoinTransfer,
            type: ProductType.account,
          ),
          VerticalDivider(color: colorDAE1E7, endIndent: 15),
          _optionBtn(
            context: context,
            text: text.payService,
            imagePath: AppImages.bill,
            type: ProductType.account,
          ),
          VerticalDivider(color: colorDAE1E7, endIndent: 15),
          _optionBtn(
            context: context,
            text: "${text.more}\n${text.options}",
            imagePath: AppImages.menu,
            type: ProductType.account,
          ),
        ],
      );
    }
  }
}

class _LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
      child: Shimmer(
        duration: Duration(seconds: 2),
        child: Column(
          spacing: 20.h(context),
          children: [
            Container(
              height: 170.h(context),
              padding: EdgeInsets.symmetric(
                horizontal: 24.w(context),
                vertical: 20.h(context),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: color043371,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoadingBar(
                    width: 121.w(context),
                    height: 10.h(context),
                    color: Colors.white30,
                    radius: 4,
                  ),
                  SizedBox(height: 7.h(context)),
                  LoadingBar(
                    width: 97.w(context),
                    height: 10.h(context),
                    color: Colors.white30,
                    radius: 4,
                  ),
                  Spacer(),
                  LoadingBar(
                    width: 121.w(context),
                    height: 10.h(context),
                    color: Colors.white30,
                    radius: 4,
                  ),
                  SizedBox(height: 7.h(context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LoadingBar(
                        width: 97.w(context),
                        height: 16.h(context),
                        color: Colors.white30,
                        radius: 4,
                      ),
                      LoadingBar(
                        width: 33.w(context),
                        height: 16.h(context),
                        color: Colors.white30,
                        radius: 4,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70.h(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      LoadingBar(width: 88.w(context), height: 51.h(context)),
                      SizedBox(height: 8.h(context)),
                      LoadingBar(width: 58.w(context), height: 10.h(context)),
                    ],
                  ),
                  VerticalDivider(color: colorDAE1E7),
                  Column(
                    children: [
                      LoadingBar(width: 88.w(context), height: 51.h(context)),
                      SizedBox(height: 8.h(context)),
                      LoadingBar(width: 58.w(context), height: 10.h(context)),
                    ],
                  ),
                  VerticalDivider(color: colorDAE1E7),
                  Column(
                    children: [
                      LoadingBar(width: 88.w(context), height: 51.h(context)),
                      SizedBox(height: 8.h(context)),
                      LoadingBar(width: 58.w(context), height: 10.h(context)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
