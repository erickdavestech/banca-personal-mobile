import 'package:banca_movil_comercial/src/bloc/diferidos_bloc/diferidos_bloc.dart';
import 'package:banca_movil_comercial/src/bloc/products_bloc/products_bloc.dart';
import 'package:banca_movil_comercial/src/bloc/tab/tab_bloc.dart';
import 'package:banca_movil_comercial/src/localization/app_localizations.dart';
import 'package:banca_movil_comercial/src/screens/main/tabs/widget/dotted_button.dart';
import 'package:banca_movil_comercial/src/screens/products/product_detail.dart';
import 'package:banca_movil_comercial/src/screens/products/widgets/error_modal.dart';
import 'package:banca_movil_comercial/src/screens/widgets/loading_bar.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ProductsScreen extends StatelessWidget {
  static const routeName = '/ProductsScreen';

  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final Map<String, List<String>> productButtons = {
      text.accountsGroupTitle: [
        text.seeMovements,
        text.listProductsAccountButtonTransfer,
      ],
      text.cardsGroupTitle: [
        text.listProductsCardButtonImportantDays,
        text.listProductsCardButtonPay,
      ],
      text.loanGroupTitle: [
        text.listProductsLoanButtonImportantDays,
        text.listProductsLoanButtonPay,
      ],
      text.leasingGroupTitle: [text.listProductsLeasingButtonPay],
      text.creditLineGroupTitle: [
        text.listProductsCreditLineButtonPay,
        text.listProductsCreditLineButtonDisbursement,
      ],
      text.factoringGroupTitle: [
        text.listProductsFactoringButtonPay,
        text.listProductsFactoringButtonDisbursement,
      ],
      text.interimConstructionGroupTitle: [
        text.listProductsInterimButtonPay,
        text.listProductsInterimButtonDisbursement,
      ],
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
        case ProductType.creditCard:
          return text.cardTabTitle;
        case ProductType.fixedTermDeposit:
          return text.depositosTabTitle;
        case ProductType.fixedTerm:
          return text.fixedTermGroupTitle;
        case ProductType.leasing:
          return text.leasingGroupTitle;
        case ProductType.creditLine:
          return text.creditLineGroupTitle;
        case ProductType.factoring:
          return text.factoringGroupTitle;
        case ProductType.interimConstructionLine:
          return text.interimConstructionGroupTitle;
      }
    }

    return Scaffold(
      backgroundColor: colorF9FAFB,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: Container(
          decoration: const BoxDecoration(
            color: color043371,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
              colors: [color043371, color043371],
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
                ...state.products.fixedTermDeposit.products,
                ...state.products.leasing.products,
                ...state.products.creditLine.products,
                ...state.products.factoring.products,
                ...state.products.interimConstructionLine.products,
              ],
              groupBy: (Product item) => getGroupTitle(item.productTypeEnum!),
              //Separador por grupos
              groupSeparatorBuilder:
                  (String groupByValue) => Padding(
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
                final buttons = getButtons(
                  getGroupTitle(item.productTypeEnum!),
                );

                if (item.productTypeEnum == ProductType.account) {
                  //TODO: @Sherly find a better way to compare this
                  final isCheckingAccount =
                      item.description?.toUpperCase() == 'CUENTA CORRIENTE';
                  item.typeDescription =
                      isCheckingAccount
                          ? text.checkingAccount
                          : text.accountTitle; // Cuenta corriente o ahorro
                  item.balanceTitle = text.availableBalance; // Saldo disponible
                  item.numberDescription = text.account; // No. Cuenta
                  item.iconPath =
                      isCheckingAccount
                          ? AppImages.checkingAccount
                          : AppImages.cuentaAhorro;
                  item.productNumberColor = color0080F2;
                } else if (item.productTypeEnum == ProductType.card) {
                  item.typeDescription = text.creditCard;
                  item.balanceTitle = text.available;
                  item.numberDescription = text.card;
                  item.iconPath = AppImages.tarjetaCredito;
                  item.productNumberColor = color2E98A4;
                } else if (item.productTypeEnum == ProductType.loan) {
                  item.typeDescription = text.loanTitle; // Préstamo
                  item.balanceTitle = text.loanPending; // Monto pendiente
                  item.numberDescription = text.loanNumber; // No. Préstamo
                  item.iconPath = AppImages.prestamos;
                  item.productNumberColor = color003DA6;
                } else if (item.productTypeEnum == ProductType.fixedTerm) {
                  item.typeDescription =
                      text.fixedDepositTitle; // Depósitos a plazo fijo
                  item.balanceTitle = text.pendingAmount; // Monto pendiente
                  item.numberDescription = text.reference; // No. Referencia
                  item.iconPath = AppImages.fixedTerm;
                  item.productNumberColor = colorF17A4C;
                } else if (item.productTypeEnum == ProductType.leasing) {
                  item.typeDescription = text.leasingTitle; // Leasing
                  item.balanceTitle = text.available; // Disponible
                  item.numberDescription = text.account; // No. Cuenta
                  item.iconPath = AppImages.leasing;
                  item.productNumberColor = color0080F2;
                } else if (item.productTypeEnum == ProductType.creditLine) {
                  item.typeDescription =
                      text.creditLineTitle; // Líneas a créditos
                  item.balanceTitle = text.pendingAmount;
                  item.numberDescription = text.loanNumber; // No. Préstamo
                  item.iconPath = AppImages.lineaCredito;
                  item.productNumberColor = color003DA6;
                } else if (item.productTypeEnum == ProductType.factoring) {
                  item.typeDescription = text.factoringTitle; // Factoring
                  item.balanceTitle = text.pendingAmount;
                  item.numberDescription = text.loanNumber; // No. Préstamo
                  item.iconPath = AppImages.factoring;
                  item.productNumberColor = color003DA6;
                } else if (item.productTypeEnum ==
                    ProductType.interimConstructionLine) {
                  item.typeDescription = text.interimConstructionTitle;
                  item.balanceTitle = text.available;
                  item.numberDescription = text.account;
                  //TODO remplazar por el Icon correcto
                  item.iconPath = AppImages.lineaCredito;
                  item.productNumberColor = color003DA6;
                }

                return GestureDetector(
                  onTap: () {
                    debugPrint("${item.name} seleccionado");

                    context.read<ProductsBloc>().add(GetDetailProduct(item));
                    context.read<DiferidosBloc>().add(
                      GetDiferidos(item.accountNumber!),
                    );
                    context
                        .read<TabBloc>()
                        .tabNavigatorKeys[AppTab.products]
                        ?.currentState
                        ?.pushNamed(ProductDetail.routeName, arguments: item);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
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
                                      // Siempre mostrar la primera línea (typeDescription)
                                      Text(
                                        "${item.typeDescription.capitalizeSentences}:",
                                        style: TextStyle(
                                          fontWeight:
                                              FontWeightEnum.SemiBold.fWTheme,
                                          fontSize: 12.w(context),
                                          color: color06243E,
                                        ),
                                      ),

                                      // Mostrar la segunda línea (description) solo si NO es interimConstructionLine
                                      if (item.productTypeEnum !=
                                          ProductType.interimConstructionLine)
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
                                    (item.productTypeEnum ==
                                                ProductType.creditCard ||
                                            item.productTypeEnum ==
                                                ProductType.card)
                                        ? item.accountNumber!.maskedCardShort
                                        : item.accountNumber ?? '',
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
                            style: const TextStyle(color: color506578),
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
              footer: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 18.w(context),
                  vertical: 31,
                ),
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
              LoadingBar(height: 10.w(context), width: 75.w(context)),
              ...List.generate(
                2,
                (index) => Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h(context),
                    horizontal: 30.w(context),
                  ),
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
                      left: BorderSide(color: colorE0E9F2, width: 6),
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
                      LoadingBar(height: 10.w(context), width: 119.w(context)),
                      SizedBox(height: 6.h(context)),
                      LoadingBar(height: 20.w(context), width: 119.w(context)),
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
                                border: Border.all(color: colorE0E9F2),
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
              LoadingBar(height: 10.w(context), width: 75.w(context)),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20.h(context),
                  horizontal: 30.w(context),
                ),
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
                    left: BorderSide(color: colorE0E9F2, width: 6),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        LoadingBar(height: 36.w(context), width: 36.w(context)),
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
                    LoadingBar(height: 10.w(context), width: 119.w(context)),
                    SizedBox(height: 6.h(context)),
                    LoadingBar(height: 20.w(context), width: 119.w(context)),
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
                              border: Border.all(color: colorE0E9F2),
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
