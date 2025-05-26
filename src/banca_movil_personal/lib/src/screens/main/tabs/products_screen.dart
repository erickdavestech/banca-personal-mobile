import 'package:ca_mobile/src/bloc/diferidos_bloc/diferidos_bloc.dart';
import 'package:ca_mobile/src/bloc/products_bloc/products_bloc.dart';

import 'package:ca_mobile/src/localization/app_localizations.dart';
import 'package:ca_mobile/src/screens/main/tabs/widget/dotted_button.dart';
import 'package:ca_mobile/src/screens/products/product_detail.dart';
import 'package:ca_mobile/src/screens/products/widgets/error_modal.dart';
import 'package:ca_mobile/src/screens/widgets/loading_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';

class ProductsScreen extends StatelessWidget {
  static const routeName = '/ProductsScreen';

  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final Map<String, List<String>> productButtons = {
      text.accountsGroupTitle: [
        text.listProductsAccountButtonPay,
        text.listProductsAccountButtonTransfer
      ], // pagar y transferir
      text.cardsGroupTitle: [
        text.listProductsCardButtonImportantDays,
        text.listProductsCardButtonPay
      ], // fechas importantes y pagar
      text.loanGroupTitle: [text.listProductsLoanButtonPay], //pagar cuota
    };

    List<Widget> getButtons(String productType) {
      return productButtons[productType]?.map((text) {
            return Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: color07355E.withOpacity(.26)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.w(context),
                    fontWeight: FontWeightEnum.SemiBold.fWTheme,
                    color: color506578,
                  ),
                ),
              ),
            );
          }).toList() ??
          [];
    }

    String getGroupTitle(ProductType type) {
      switch (type) {
        case ProductType.account:
          return text.accountsGroupTitle;
        case ProductType.card:
          return text.cardsGroupTitle;
        case ProductType.loan:
          return text.loanGroupTitle;
        case ProductType.fixedTerm:
          return text.fixedTermGroupTitle;
        default:
          return text.accountsGroupTitle;
      }
    }

    return Scaffold(
      backgroundColor: colorF9FAFB,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: Container(
          decoration: const BoxDecoration(
            color: color005199,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
              colors: [color005199, color005199],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            fit: StackFit.loose,
            children: [
              SizedBox(
                height: 155.h(context),
                child: Padding(
                  padding: EdgeInsets.only(left: 18, right: 5, top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        text.listProductsTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.w(context),
                          fontWeight: FontWeightEnum.Medium.fWTheme,
                        ),
                      ),
                      IconButton(
                        icon: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.2),
                            shape: BoxShape.circle,
                          ),
                          child: ImageIcon(
                            AssetImage(AppImages.settingsIcon),
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          // Acción del botón de configuración
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -30,
                right: -40,
                child: Container(
                  width: 245,
                  height: 245,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: -50,
                right: -40,
                child: Container(
                  width: 200,
                  height: 325,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return _LoadingWidget();
          } else if (state is ProductsError) {
            return Align(
              alignment: Alignment.topCenter,
              child: ErrorModal(
                message: text.products_load_error,
                imageAsset: AppImages.danger,
                onRetry: () {
                  context.read<ProductsBloc>().add(GetProducts());
                },
              ),
            );
          } else if (state is ProductsLoaded) {
            return GroupedListView<Product, String>(
              sort: false,
              elements: [
                ...state.products.account.products,
                ...state.products.creditCard.products,
                ...state.products.loan.products,
                ...state.products.fixedTermDeposit.products
              ],
              groupBy: (Product item) => getGroupTitle(item.productTypeEnum!),
              //Separador por grupos
              groupSeparatorBuilder: (String groupByValue) => Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    groupByValue,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16.w(context),
                      fontWeight: FontWeightEnum.Bold.fWTheme,
                      color: color080C3A,
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, Product item) {
                final buttons =
                    getButtons(getGroupTitle(item.productTypeEnum!));

                if (item.productTypeEnum == ProductType.account) {
                  item.typeDescription = text.accountTitle;
                  item.balanceTitle = text.available;
                  item.numberDescription = text.account;
                } else if (item.productTypeEnum == ProductType.card) {
                  item.typeDescription = text.creditCard;
                  item.balanceTitle = text.available;
                  item.numberDescription = text.card;
                } else if (item.productTypeEnum == ProductType.loan) {
                  item.typeDescription = text.loanTitle;
                  item.balanceTitle = text.loanPending;
                  item.numberDescription = text.loanTitle;
                } else if (item.productTypeEnum == ProductType.fixedTerm) {
                  item.typeDescription = text.reference;
                  item.balanceTitle = text.balance;
                  item.numberDescription = text.reference;
                }

                return GestureDetector(
                  onTap: () {
                    debugPrint("${item.name} seleccionado");

                    context.read<ProductsBloc>().add(GetDetailProduct(item));
                    context
                        .read<DiferidosBloc>()
                        .add(GetDiferidos(item.accountNumber!));

                    context.pushNamed(ProductDetail.routeName, arguments: item);
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: color9F9F9F.withOpacity(.1),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                      border: Border(
                        left: BorderSide(
                          color: item.productNumberColor,
                          width: 6,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image(
                                image: AssetImage(item.iconPath),
                                width: 37.w(context),
                                height: 36.h(context),
                              ),
                              SizedBox(width: 8.w(context)),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 49.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${item.typeDescription.capitalizeSentences}:",
                                        style: TextStyle(
                                          fontWeight:
                                              FontWeightEnum.SemiBold.fWTheme,
                                          fontSize: 12.w(context),
                                          color: color06243E,
                                        ),
                                      ),
                                      Text(
                                        "${item.description?.capitalizeSentences}",
                                        style: TextStyle(
                                          fontSize: 12.w(context),
                                          color: color506578,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "No. ${item.numberDescription}",
                                    style: TextStyle(
                                      color: color506578,
                                      fontSize: 12.w(context),
                                    ),
                                  ),
                                  Text(
                                    item.typeDescription == text.card
                                        ? item.accountNumber!.creditCardFormat
                                        : item.accountNumber!,
                                    style: TextStyle(
                                      color: item.productNumberColor,
                                      fontSize: 12.w(context),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            item.balanceTitle,
                            style: const TextStyle(
                              color: color506578,
                            ),
                          ),
                          Text(
                            'B/. ${num.parse(item.productTypeEnum == ProductType.loan ? item.balance : item.available ?? "0").priceFormat}',
                            style: TextStyle(
                              fontSize: 18.w(context),
                              fontWeight: FontWeightEnum.SemiBold.fWTheme,
                              color: color06243E,
                            ),
                          ),
                          if (buttons.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 10.w(context),
                              children: buttons,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
              // useStickyGroupSeparators: false,
              // floatingHeader: true,
              footer: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 18.w(context), vertical: 31),
                child: CustomPaint(
                  painter: DashedBorderPainter(
                    borderRadius: 10,
                    dashWidth: 8,
                    dashSpace: 8,
                    strokeWidth: 2,
                    color: color506578.withOpacity(.26),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage(AppImages.addCircle),
                          width: 20.w(context),
                          height: 20.h(context),
                          color: color506578,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          text.listProductsButton,
                          style: TextStyle(
                            color: color506578,
                            fontSize: 14,
                            fontWeight: FontWeightEnum.Medium.fWTheme,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w(context)),
      child: Shimmer(
        colorOpacity: 1,
        duration: Duration(seconds: 2),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            spacing: 14.h(context),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox.shrink(),
              LoadingBar(
                height: 10.w(context),
                width: 75.w(context),
              ),
              ...List.generate(
                2,
                (index) => Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 20.h(context), horizontal: 30.w(context)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: color9F9F9F.withOpacity(.1),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    border: Border(
                      left: BorderSide(
                        color: colorE0E9F2,
                        width: 6,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          LoadingBar(
                            height: 36.w(context),
                            width: 36.w(context),
                          ),
                          SizedBox(width: 8.w(context)),
                          Column(
                            spacing: 6.h(context),
                            children: [
                              LoadingBar(
                                height: 10.h(context),
                                width: 119.w(context),
                              ),
                              LoadingBar(
                                height: 10.h(context),
                                width: 119.w(context),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            spacing: 6.h(context),
                            children: [
                              LoadingBar(
                                height: 10.h(context),
                                width: 119.w(context),
                              ),
                              LoadingBar(
                                height: 10.h(context),
                                width: 96.w(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h(context)),
                      LoadingBar(
                        height: 10.w(context),
                        width: 119.w(context),
                      ),
                      SizedBox(height: 6.h(context)),
                      LoadingBar(
                        height: 20.w(context),
                        width: 119.w(context),
                      ),
                      SizedBox(height: 15.h(context)),
                      Row(
                        spacing: 22.w(context),
                        children: List.generate(
                          2,
                          (index) => Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 14.h(context),
                                horizontal: 50.w(context),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: colorE0E9F2,
                                ),
                              ),
                              child: LoadingBar(
                                height: 10.w(context),
                                width: 80.w(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox.shrink(),
              LoadingBar(
                height: 10.w(context),
                width: 75.w(context),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: 20.h(context), horizontal: 30.w(context)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: color9F9F9F.withOpacity(.1),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                  border: Border(
                    left: BorderSide(
                      color: colorE0E9F2,
                      width: 6,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        LoadingBar(
                          height: 36.w(context),
                          width: 36.w(context),
                        ),
                        SizedBox(width: 8.w(context)),
                        Column(
                          spacing: 6.h(context),
                          children: [
                            LoadingBar(
                              height: 10.h(context),
                              width: 119.w(context),
                            ),
                            LoadingBar(
                              height: 10.h(context),
                              width: 119.w(context),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          spacing: 6.h(context),
                          children: [
                            LoadingBar(
                              height: 10.h(context),
                              width: 119.w(context),
                            ),
                            LoadingBar(
                              height: 10.h(context),
                              width: 96.w(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h(context)),
                    LoadingBar(
                      height: 10.w(context),
                      width: 119.w(context),
                    ),
                    SizedBox(height: 6.h(context)),
                    LoadingBar(
                      height: 20.w(context),
                      width: 119.w(context),
                    ),
                    SizedBox(height: 15.h(context)),
                    Row(
                      spacing: 22.w(context),
                      children: List.generate(
                        2,
                        (index) => Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 16.h(context),
                              horizontal: 50.w(context),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: colorE0E9F2,
                              ),
                            ),
                            child: LoadingBar(
                              height: 10.w(context),
                              width: 80.w(context),
                            ),
                          ),
                        ),
                      ),
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
