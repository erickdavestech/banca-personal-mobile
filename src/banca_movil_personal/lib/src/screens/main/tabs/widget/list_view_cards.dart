import 'package:ca_mobile/src/bloc/diferidos_bloc/diferidos_bloc.dart';
import 'package:ca_mobile/src/bloc/products_bloc/products_bloc.dart';

import 'package:ca_mobile/src/localization/app_localizations.dart'
    show AppLocalizations;
// ignore: unused_import
import 'package:ca_mobile/src/screens/main/tabs/main_screen.dart';
import 'package:ca_mobile/src/screens/products/product_detail.dart';
import 'package:ca_mobile/src/screens/products/widgets/error_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';

class ListViewCards extends StatefulWidget {
  const ListViewCards({
    super.key,
    required this.onAddProduct,
  });

  final VoidCallback onAddProduct;

  @override
  State<ListViewCards> createState() => _ListViewCardsState();
}

class _ListViewCardsState extends State<ListViewCards>
    with TickerProviderStateMixin {
  late AppLocalizations text;
  late TabController _tabController;
  late PageController _pageController;

  late List<ProductType> _sections;
  late Map<ProductType, List<Product>> _groupedProducts;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);

    _pageController = PageController(
      viewportFraction: isTablet ? .35 : 0.47,
      keepPage: false,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    text = AppLocalizations.of(context)!;
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return LoadingWidget();
        }
        if (state is ProductsError) {
          return ErrorModal(
            message: text.products_load_error,
            imageAsset: AppImages.danger,
            onRetry: () {
              context.read<ProductsBloc>().add(GetProducts());
            },
          );
        } else if (state is ProductsLoaded) {
          _groupedProducts = _groupProductsByType(state.products);
          _sections = _groupedProducts.keys.toList();

          final products = state.products;

          int totalProducts = products.account.products.length +
              products.creditCard.products.length +
              products.loan.products.length +
              products.fixedTermDeposit.products.length;

          if (totalProducts == 1) {
            _pageController = PageController(
              viewportFraction: .9,
              keepPage: false,
            );
          } else if (totalProducts == 0) {
            _pageController = PageController();
          } else {
            _pageController = PageController(
              viewportFraction: isTablet ? .35 : 0.47,
              keepPage: false,
            );
          }

          _tabController = TabController(length: _sections.length, vsync: this);

          return Column(
            children: [
              if (_sections.isNotEmpty)
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 30.h(context),
                    width: MediaQuery.sizeOf(context).width *
                        (_sections.length / 4),
                    child: TabBar(
                      padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 50.w(context) : 0),
                      onTap: (index) {
                        int pageIndex =
                            _getFirstPageIndexOfSection(_sections[index]);
                        _pageController.animateToPage(
                          pageIndex,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      controller: _tabController,
                      indicatorColor: colorF2C94C,
                      dividerHeight: 0,
                      labelPadding: EdgeInsets.all(3),
                      labelStyle: TextStyle(
                        fontSize: isTablet ? 16.w(context) : 14.w(context),
                        fontWeight: FontWeightEnum.SemiBold.fWTheme,
                        color: Colors.white,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: isTablet ? 16.w(context) : 14.w(context),
                        color: Colors.white,
                      ),
                      tabs: [
                        if (products.account.products.isNotEmpty)
                          Tab(
                            child: Text(
                                "${AppLocalizations.of(context)?.accountTabTitle}"),
                          ),
                        if (products.creditCard.products.isNotEmpty)
                          Tab(
                            child: Text(
                                "${AppLocalizations.of(context)?.cardTabTitle}"),
                          ),
                        if (products.loan.products.isNotEmpty)
                          Tab(
                            child: Text(
                                "${AppLocalizations.of(context)?.prestamosTabTitle}"),
                          ),
                        if (products.fixedTermDeposit.products.isNotEmpty)
                          Tab(
                            child: Text(
                                "${AppLocalizations.of(context)?.depositosTabTitle}"),
                          ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: isTablet ? 28.h(context) : 16.h(context)),
              SizedBox(
                height: 200.h(context),
                child: PageView(
                  pageSnapping: false,
                  padEnds: false,
                  physics: BouncingScrollPhysics(),
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) {
                    int newTabIndex = _getSectionIndexFromPage(value);
                    if (_currentTabIndex != newTabIndex) {
                      // setState(() {
                      _currentTabIndex = newTabIndex;
                      _tabController.animateTo(_currentTabIndex,
                          curve: Curves.ease);
                      // });
                    }
                  },
                  children: [
                    ...products.account.products.map((product) {
                      product.typeDescription = text.accountTitle;
                      product.balanceTitle = text.available;
                      product.numberDescription = text.account;
                      return card(
                        context: context,
                        product: product,
                        accountType: text.account,
                        productNumberColor: color0080F2,
                        name: text.accountTitle,
                        availableTitle: text.available,
                      );
                    }),
                    ...products.creditCard.products.map((product) {
                      product.typeDescription = text.creditCard;
                      product.balanceTitle = text.available;
                      product.numberDescription = text.card;
                      return card(
                        context: context,
                        product: product,
                        accountType: text.card,
                        productNumberColor: color2E98A4,
                        imagePath: AppImages.tarjetaCredito,
                        name: text.cardTitle,
                        availableTitle: text.available,
                      );
                    }),
                    ...products.loan.products.map((product) {
                      product.typeDescription = text.loanTitle;
                      product.balanceTitle = text.loanPending;
                      product.numberDescription = text.loanTitle;
                      return card(
                          context: context,
                          product: product,
                          accountType: text.loan,
                          productNumberColor: color0080F2,
                          imagePath: AppImages.prestamo,
                          name: text.loanTitle,
                          availableTitle: text.loanPending);
                    }),
                    ...products.fixedTermDeposit.products.map((product) {
                      product.typeDescription = text.reference;
                      product.balanceTitle = text.balance;
                      product.numberDescription = text.reference;
                      return card(
                        context: context,
                        product: product,
                        accountType: text.reference,
                        productNumberColor: colorF17A4C,
                        imagePath: AppImages.plazoFijo,
                        name: text.fixedtermTitle,
                        availableTitle: text.balance,
                      );
                    }),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 12.w(context),
                      ).copyWith(
                          bottom: isTablet ? 40.h(context) : 30.h(context)),
                      padding: EdgeInsets.all(20.w(context)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: color9F9F9F.withOpacity(.25),
                            blurRadius: 10,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 10.h(context),
                        children: [
                          ImageIcon(
                            AssetImage(AppImages.addCircle),
                            color: color005199,
                            size: 20,
                          ),
                          Text(
                            AppLocalizations.of(context)!.requestProductTitle,
                            style: TextStyle(
                              fontSize: 16.w(context),
                              fontWeight: FontWeightEnum.SemiBold.fWTheme,
                              color: color005199,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return LoadingWidget();
          // return ErrorModal(
          //   message: text.products_load_error,
          //   imageAsset: AppImages.danger,
          //   onRetry: () {
          //     context.read<ProductsBloc>().add(GetProducts());
          //   },
          // );
        }
      },
    );
  }

  Widget card({
    required BuildContext context,
    required Product product,
    required String accountType,
    ProductType type = ProductType.account,
    Color productNumberColor = color0080F2,
    String imagePath = AppImages.cuentaAhorro,
    String name = "",
    required String availableTitle,
  }) {
    String? available = product.available;
    if (product.productTypeEnum == ProductType.loan) {
      available = product.balance;
    }

    if (name.toLowerCase() == product.description?.toLowerCase()) {
      product.description = "";
    }
    return GestureDetector(
      onTap: () async {
        context.read<ProductsBloc>().add(GetDetailProduct(product));

        if (product.productTypeEnum != ProductType.fixedTerm) {
          context
              .read<DiferidosBloc>()
              .add(GetDiferidos(product.accountNumber!));
        }
        await context.pushNamed(ProductDetail.routeName, arguments: product);
        Future.delayed(
          Durations.extralong4,
          () => context.read<ProductsBloc>().add(GetProducts()),
        );
      },
      child: Container(
        width: 191.w(context),
        margin: EdgeInsets.only(
          left: 12.w(context),
          bottom: isTablet ? 40.h(context) : 30.h(context),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: color9F9F9F.withOpacity(.25),
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: 12.w(context),
              top: isTablet ? 20.w(context) : 12.w(context)),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage(imagePath),
                    height: 36.h(context),
                    width: 37.w(context),
                  ),
                  SizedBox(width: 8.w(context)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "$name: ",
                            style: TextStyle(
                              fontSize: 12.w(context),
                              fontWeight: FontWeightEnum.SemiBold.fWTheme,
                              color: color1C274C,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    "${product.description?.capitalizeSentences}",
                                style: TextStyle(
                                  fontSize: 10.w(context),
                                  color: color506578,
                                ),
                                children: [],
                              ),
                            ],
                          ),
                        ),
                        // Text(
                        //   "$name:",
                        //   style: TextStyle(
                        //     fontSize: 12.w(context),
                        //     fontWeight: FontWeightEnum.SemiBold.fWTheme,
                        //     color: color1C274C,
                        //   ),
                        // ),
                        // if (!product.description.isNullOrEmpty)
                        //   Text(
                        //     "${product.description?.capitalizeSentences}",
                        //     style: TextStyle(
                        //       fontSize: 10.w(context),
                        //       color: color506578,
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w(context)),
                ],
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "No. $accountType",
                      style: TextStyle(
                        fontSize: 13.w(context),
                        color: color516578,
                      ),
                    ),
                    Text(
                      accountType == "Tarjeta"
                          ? product.accountNumber!.creditCardFormat
                          : product.accountNumber!,
                      style: TextStyle(
                        fontSize: 13.w(context),
                        fontWeight: FontWeightEnum.SemiBold.fWTheme,
                        color: productNumberColor,
                      ),
                    ),
                    SizedBox(height: 9.h(context)),
                    Text(
                      availableTitle,
                      style: TextStyle(
                        fontSize: 12.w(context),
                        color: color506578,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "B/. ${num.parse(available ?? "0").priceFormat}",
                      style: TextStyle(
                        fontSize: 18.w(context),
                        fontWeight: FontWeightEnum.Bold.fWTheme,
                        color: color06243E,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 15.h(context)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<ProductType, List<Product>> _groupProductsByType(ProductsModel products) {
    Map<ProductType, List<Product>> grouped = {};

    for (var product in products.account.products) {
      grouped.putIfAbsent(product.productTypeEnum!, () => []).add(product);
    }
    for (var product in products.creditCard.products) {
      grouped.putIfAbsent(product.productTypeEnum!, () => []).add(product);
    }
    for (var product in products.loan.products) {
      grouped.putIfAbsent(product.productTypeEnum!, () => []).add(product);
    }
    for (var product in products.fixedTermDeposit.products) {
      grouped.putIfAbsent(product.productTypeEnum!, () => []).add(product);
    }
    return grouped;
  }

  int _getSectionIndexFromPage(int pageIndex) {
    int count = 0;
    for (int i = 0; i < _sections.length; i++) {
      count += _groupedProducts[_sections[i]]!.length;
      if (pageIndex < count) return i;
    }
    return 0;
  }

  int _getFirstPageIndexOfSection(ProductType section) {
    int index = 0;
    for (ProductType type in _sections) {
      if (type == section) return index;
      index += _groupedProducts[type]!.length;
    }
    return 0;
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              4,
              (index) => Shimmer(
                colorOpacity: 1,
                duration: Duration(seconds: 2),
                child: Container(
                  height: 8.h(context),
                  width: 63.w(context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white30,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 5.h(context)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w(context)),
          child: Shimmer(
            colorOpacity: 1,
            duration: Duration(seconds: 2),
            child: Container(
              height: 3.h(context),
              width: 63.w(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.white54,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h(context)),
        SizedBox(
          height: 200.h(context),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 12.w(context)),
            scrollDirection: Axis.horizontal,
            children: List.generate(
              3,
              (index) => Container(
                width: 191.w(context),
                margin: EdgeInsets.only(
                    right: 9.w(context),
                    bottom: isTablet ? 40.h(context) : 30.h(context)),
                padding: EdgeInsets.all(20.w(context)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: color9F9F9F.withOpacity(.25),
                      blurRadius: 10,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Shimmer(
                  duration: Duration(seconds: 2),
                  colorOpacity: 1,
                  child: Column(
                    children: [
                      Row(
                        spacing: 9.w(context),
                        children: [
                          Container(
                            width: 36.w(context),
                            height: 36.w(context),
                            decoration: BoxDecoration(
                              color: colorE0E9F2,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Column(
                            spacing: 6.h(context),
                            children: List.generate(
                              2,
                              (index) => Container(
                                width: 96.w(context),
                                height: 10.w(context),
                                decoration: BoxDecoration(
                                  color: colorE0E9F2,
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    colors: [
                                      colorE0E9F2,
                                      Colors.white,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h(context)),
                      Container(
                        height: 10.w(context),
                        decoration: BoxDecoration(
                          color: colorE0E9F2,
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              colorE0E9F2,
                              Colors.white,
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 6.h(context)),
                      Container(
                        height: 10.w(context),
                        decoration: BoxDecoration(
                          color: colorE0E9F2,
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              colorE0E9F2,
                              Colors.white,
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h(context)),
                      Container(
                        height: 10.w(context),
                        decoration: BoxDecoration(
                          color: colorE0E9F2,
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              colorE0E9F2,
                              Colors.white,
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 6.h(context)),
                      Container(
                        height: 20.w(context),
                        decoration: BoxDecoration(
                          color: colorE0E9F2,
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              colorE0E9F2,
                              Colors.white,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
