import 'dart:collection';

import 'package:banca_movil_comercial/src/bloc/products_bloc/products_bloc.dart';
import 'package:banca_movil_comercial/src/extensions/context_extensions.dart';
import 'package:banca_movil_comercial/src/screens/main/tabs/widget/product_card.dart';
import 'package:banca_movil_comercial/src/screens/products/widgets/error_modal.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ProductsListTabsCarousel extends StatefulWidget {
  const ProductsListTabsCarousel({super.key, required this.onAddProduct});

  final VoidCallback onAddProduct;

  @override
  State<ProductsListTabsCarousel> createState() =>
      _ProductsListTabsCarouselState();
}

class _ProductsListTabsCarouselState extends State<ProductsListTabsCarousel>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  late List<ProductType> _sections;
  late Map<ProductType, List<Product>> _groupedProducts;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 0, vsync: this); // ← inicial vacío

    _tabController.addListener(() {
      setState(() {}); // ← fuerza rebuild del TabBar para actualizar colores
    });

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

  String _getTabTitle(ProductType type) {
    switch (type) {
      case ProductType.account:
        return context.lang.accountTabTitle;
      case ProductType.creditCard:
        return context.lang.creditCard;
      case ProductType.card:
        return context.lang.cardTabTitle;
      case ProductType.loan:
        return context.lang.prestamosTabTitle;
      case ProductType.fixedTermDeposit:
      case ProductType.fixedTerm:
        return context.lang.depositosTabTitle;
      case ProductType.creditLine:
        return context.lang.creditLineGroupTitle;
      case ProductType.interimConstructionLine:
        return context.lang.interimConstructionGroupTitle;
      case ProductType.factoring:
        return context.lang.factoringGroupTitle;
      case ProductType.leasing:
        return context.lang.leasingGroupTitle;
    }
  }

  String _getTypeTitle(
    BuildContext context,
    ProductType type, {
    bool isCheckingAccount = false,
  }) {
    final text = context.lang;
    switch (type) {
      case ProductType.account:
        return isCheckingAccount ? text.checkingAccount : text.accountTitle;
      case ProductType.creditCard:
        return text.cardTitle;
      case ProductType.loan:
        return text.loanTitle;
      case ProductType.leasing:
        return text.leasingTitle;
      case ProductType.creditLine:
        return text.creditLineTitle;
      case ProductType.factoring:
        return text.factoringTitle;
      case ProductType.interimConstructionLine:
        return text.interimConstructionTitle;
      case ProductType.fixedTermDeposit:
      case ProductType.fixedTerm:
        return text.fixedtermTitle;
      case ProductType.card:
        return text.cardTitle;
    }
  }

  String _getBalanceTitle(BuildContext context, ProductType type) {
    final text = context.lang;
    switch (type) {
      case ProductType.loan:
        return text.loanPending;
      case ProductType.fixedTermDeposit:
        return text.balance;
      case ProductType.fixedTerm:
        return text.balance;
      default:
        return text.available;
    }
  }

  String _getNumberDescription(BuildContext context, ProductType type) {
    final text = context.lang;
    switch (type) {
      case ProductType.account:
        return text.account;
      case ProductType.creditCard:
        return text.creditCard;
      case ProductType.card:
        return text.card;
      case ProductType.loan:
        return text.loanTitle;
      case ProductType.leasing:
        return text.leasingTitle;
      case ProductType.creditLine:
        return text.creditLineTitle;
      case ProductType.factoring:
        return text.factoringTitle;
      case ProductType.interimConstructionLine:
        return text.interimConstructionTitle;
      case ProductType.fixedTermDeposit:
      case ProductType.fixedTerm:
        return text.fixedtermTitle;
    }
  }

  Color _getProductColor(ProductType type) {
    switch (type) {
      case ProductType.account:
      case ProductType.leasing:
        return color0080F2;
      case ProductType.card:
      case ProductType.creditCard:
        return color2E98A4;
      case ProductType.loan:
      case ProductType.creditLine:
      case ProductType.interimConstructionLine:
        return color003DA6;
      case ProductType.fixedTerm:
      case ProductType.fixedTermDeposit:
        return colorF17A4C;
      default:
        return color0080F2;
    }
  }

  String _getProductImage(ProductType type, {bool isCheckinAccount = true}) {
    switch (type) {
      case ProductType.account:
        return isCheckinAccount
            ? AppImages.checkingAccount
            : AppImages.cuentaAhorro;
      case ProductType.creditLine:
      case ProductType.interimConstructionLine:
        return AppImages.lineaCredito;
      case ProductType.factoring:
        return AppImages.factoring;
      case ProductType.creditCard:
        return AppImages.tarjetaCredito;
      case ProductType.card:
        return AppImages.tarjetaCredito;
      case ProductType.loan:
        return AppImages.prestamo;
      case ProductType.leasing:
        return AppImages.leasing;
      case ProductType.fixedTerm:
      case ProductType.fixedTermDeposit:
        return AppImages.fixedTerm;
    }
  }

  /// Está en un orden específico y debe mantenerse
  /// a menos que lo cambien con un requerimiento.
  Map<ProductType, List<Product>> _groupProductsByType(ProductsModel products) {
    // Explicitamente declarado LinkedHashMap porque el orden
    // de agrupación es importante
    // ignore: prefer_collection_literals
    final result = LinkedHashMap<ProductType, List<Product>>();

    void addToGroup(ProductType type, List<Product>? items) {
      if (items != null && items.isNotEmpty) result[type] = items;
    }

    addToGroup(ProductType.account, products.account.products);
    addToGroup(ProductType.creditCard, products.creditCard.products);
    addToGroup(
      ProductType.fixedTermDeposit,
      products.fixedTermDeposit.products,
    );
    addToGroup(ProductType.loan, products.loan.products);
    addToGroup(ProductType.creditLine, products.creditLine.products);
    addToGroup(
      ProductType.interimConstructionLine,
      products.interimConstructionLine.products,
    );
    addToGroup(ProductType.factoring, products.factoring.products);
    addToGroup(ProductType.leasing, products.leasing.products);

    return result;
  }

  Widget _buildError(BuildContext context) {
    return ErrorModal(
      message: context.lang.products_load_error,
      imageAsset: AppImages.danger,
      onRetry: () {
        context.read<ProductsBloc>().add(GetProducts());
      },
    );
  }

  PageController _getPageController(int totalProducts) {
    if (totalProducts == 1) {
      return PageController(viewportFraction: .9, keepPage: false);
    } else if (totalProducts == 0) {
      return PageController();
    } else {
      return PageController(
        viewportFraction: isTablet ? .35 : 0.47,
        keepPage: false,
      );
    }
  }

  Widget _buildTabs(BuildContext context) {
    return Container(
      height: 30.h(context),
      padding: EdgeInsets.symmetric(horizontal: 10.w(context)),
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.transparent,
        isScrollable: true,
        dividerColor: Colors.transparent,
        labelPadding: EdgeInsets.symmetric(horizontal: 4),
        tabAlignment: TabAlignment.start,
        tabs: List.generate(_sections.length, (index) {
          final isSelected = _currentTabIndex == index;
          return _buildTab(context, index, isSelected);
        }),
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
          int pageIndex = _getFirstPageIndexOfSection(_sections[index]);
          _pageController.animateToPage(
            pageIndex,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }

  Widget _buildTab(BuildContext context, int index, bool isSelected) {
    return Tab(
      child: Container(
        width:
            _sections.length < 2
                ? MediaQuery.sizeOf(context).width * (_sections.length / 2)
                : null,
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 20.w(context) : 16.w(context),
          vertical: isTablet ? 5.h(context) : 3.h(context),
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Color(0xFF004B8D),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            _getTabTitle(_sections[index]),
            style: TextStyle(
              fontSize: isTablet ? 14.w(context) : 12.w(context),
              fontWeight: FontWeightEnum.SemiBold.fWTheme,
              color: isSelected ? Color(0xFF004B8D) : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequestProductCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 12.w(context),
      ).copyWith(bottom: isTablet ? 40.h(context) : 30.h(context)),
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
        children: [
          ImageIcon(
            AssetImage(AppImages.addCircle),
            color: color043371,
            size: 20,
          ),
          SizedBox(height: 10.h(context)),
          Text(
            context.lang.requestProductTitle,
            style: TextStyle(
              fontSize: 16.w(context),
              fontWeight: FontWeightEnum.SemiBold.fWTheme,
              color: color043371,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPageView(
    BuildContext context,
    Map<ProductType, List<Product>> groupedProducts,
  ) {
    final List<Widget> productCards = [];

    for (final entry in groupedProducts.entries) {
      final type = entry.key;
      final products = entry.value;

      for (Product product in products) {
        //TODO: @Sherly find a better way to compare this
        final isCheckingAccount =
            product.description?.toUpperCase() == 'CUENTA CORRIENTE';
        product.typeDescription = _getTypeTitle(
          context,
          type,
          isCheckingAccount: isCheckingAccount,
        );
        product.balanceTitle = _getBalanceTitle(context, type);
        product.numberDescription = _getNumberDescription(context, type);
        productCards.add(
          ProductCard(
            product: product,
            accountType: product.numberDescription,
            availableTitle: product.balanceTitle,
            type: type,
            productNumberColor: _getProductColor(type),
            imagePath: _getProductImage(
              type,
              isCheckinAccount: isCheckingAccount,
            ),
            name: product.typeDescription,
          ),
        );
      }
    }

    productCards.add(_buildRequestProductCard(context));

    return SizedBox(
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
            setState(() {
              _currentTabIndex = newTabIndex;
              _tabController.animateTo(_currentTabIndex, curve: Curves.ease);
            });
          }
        },
        children: productCards,
      ),
    );
  }

  Widget _buildContent(BuildContext context, ProductsLoaded state) {
    _groupedProducts = _groupProductsByType(state.products);
    _sections = _groupedProducts.keys.toList();

    // Cuenta todos los productos dinámicamente
    int totalProducts = _groupedProducts.values.fold(
      0,
      (sum, list) => sum + list.length,
    );

    _pageController = _getPageController(totalProducts);
    _tabController = TabController(length: _sections.length, vsync: this);

    return Column(
      children: [
        if (_sections.isNotEmpty) _buildTabs(context),
        SizedBox(height: isTablet ? 28.h(context) : 16.h(context)),
        _buildPageView(context, _groupedProducts),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading) return LoadingWidget();
        if (state is ProductsError) return _buildError(context);

        if (state is ProductsLoaded) {
          return _buildContent(context, state);
        }

        return _buildError(context);
      },
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

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
                  bottom: isTablet ? 40.h(context) : 30.h(context),
                ),
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
                                    colors: [colorE0E9F2, Colors.white],
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
                            colors: [colorE0E9F2, Colors.white],
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
                            colors: [colorE0E9F2, Colors.white],
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
                            colors: [colorE0E9F2, Colors.white],
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
                            colors: [colorE0E9F2, Colors.white],
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
