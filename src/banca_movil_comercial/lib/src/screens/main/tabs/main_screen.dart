import 'package:banca_movil_comercial/src/app.dart';
import 'package:banca_movil_comercial/src/bloc/products_bloc/products_bloc.dart';
import 'package:banca_movil_comercial/src/bloc/tab/tab_bloc.dart';
import 'package:banca_movil_comercial/src/localization/app_localizations.dart';
import 'package:banca_movil_comercial/src/screens/authentication/login_screen.dart';
import 'package:banca_movil_comercial/src/screens/main/tabs/widget/products_list_tabs_carousel.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const routeName = '/MainScreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body(context));
  }

  Widget body(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Stack(
      alignment: Alignment.topRight,
      children: [...headerBackground(context), content(context, text)],
    );
  }

  List<Widget> headerBackground(BuildContext context) => [
    Container(
      height: 250.h(context),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color043371,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
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
        width: 290,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.1),
          shape: BoxShape.circle,
        ),
      ),
    ),
  ];

  Widget content(BuildContext context, AppLocalizations text) {
    return ListView(
      physics: ClampingScrollPhysics(),
      children: [
        header(context),
        SizedBox(height: 40.h(context)),
        ProductsListTabsCarousel(onAddProduct: () {}),
        quickAccessesSection(context),
        suggestionsForYouSection(context, text.sujestion),
      ],
    );
  }
}

Widget header(BuildContext context) => Padding(
  padding: EdgeInsets.only(left: 18.w(context), right: 6.w(context)),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image(
        image: AssetImage(AppImages.caAppBar),
        width: 50.w(context),
        height: 50.w(context),
      ),
      greetingsSection(context),
      GestureDetector(
        onTap: () async {
          try {
            await AuthController.logOut();
            await preferences.delPrefs();
            context.read<TabBloc>().add(TabReset());

            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const CDAAppComercial()),
              (route) => false,
            );
          } on Exception {
            context.pop();
          }
        },
        child: Image(
          image: AssetImage(AppImages.logOut),
          width: 75.w(context),
          height: 75.w(context),
        ),
      ),
    ],
  ),
);

Widget greetingsSection(BuildContext context) {
  final userName = preferences.uName;
  final firstName = userName.split(" ").first;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "${AppLocalizations.of(context)?.welcomeUser}, $firstName",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeightEnum.SemiBold.fWTheme,
          fontSize: 20.w(context),
        ),
      ),
      Text(
        DateFormat(
          "EEEE d, MMMM y",
          preferences.uLanguaje,
        ).format(DateTime.now()).capitalize,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15.w(context),
          fontWeight: FontWeightEnum.ExtraLight.fWTheme,
        ),
      ),
    ],
  );
}

Widget quickAccessesSection(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 18.w(context)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${AppLocalizations.of(context)?.quickAccesTitle}",
              style: TextStyle(
                fontSize: 15.w(context),
                fontWeight: FontWeightEnum.SemiBold.fWTheme,
              ),
            ),
            ImageIcon(
              AssetImage(AppImages.settingsIcon),
              color: color506578,
              size: 18,
            ),
          ],
        ),
        SizedBox(height: 14.h(context)),
        BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return quickAccessesContentLoader(context);
            }
            return quickAccesses(context);
          },
        ),
        SizedBox(height: 24.h(context)),
      ],
    ),
  );
}

Widget quickAccessesContentLoader(BuildContext context) => Container(
  margin: EdgeInsets.symmetric(horizontal: 12.0.w(context)),
  child: Shimmer(
    colorOpacity: 1,
    duration: Duration(seconds: 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        4,
        (index) => Column(
          spacing: 10.h(context),
          children: [
            Container(
              height: 67.h(context),
              width: 70.w(context),
              decoration: BoxDecoration(
                color: colorE0E9F2,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
              height: 10.h(context),
              width: 58.w(context),
              decoration: BoxDecoration(
                color: colorE0E9F2,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);

Widget quickAccesses(BuildContext context) => Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    quickAccessOption(
      context,
      text: "${AppLocalizations.of(context)?.transferenciaTitle}",
      onTap: () {},
      iconPath:
          isTablet ? AppImages.transferIconTablet : AppImages.transferIcon,
    ),
    quickAccessOption(
      context,
      text: "${AppLocalizations.of(context)?.recargaTitle}",
      onTap: () {},
      iconPath: isTablet ? AppImages.recargaIconTablet : AppImages.recargaIcon,
    ),
    quickAccessOption(
      context,
      text: "${AppLocalizations.of(context)?.loan}",
      onTap: () {},
      iconPath: isTablet ? AppImages.recargaIconTablet : AppImages.recargaIcon,
    ),
    quickAccessOption(
      context,
      text: "${AppLocalizations.of(context)?.token}",
      onTap: () {},
      // TODO: Add Missing token icon for tablet
      iconPath:
          isTablet
              ? AppImages.tokenQuickAccessIcon
              : AppImages.tokenQuickAccessIcon,
    ),
  ],
);

Widget quickAccessOption(
  BuildContext context, {
  required String text,
  required VoidCallback onTap,
  required String iconPath,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image(
            image: AssetImage(iconPath),
            fit: BoxFit.cover,
            height: isTablet ? 72.h(context) : 70.h(context),
            width: isTablet ? 156.w(context) : 67.w(context),
          ),
        ),
        SizedBox(height: 4.w(context)),
        Text(
          text,
          style: TextStyle(fontSize: 13.w(context), color: color212121),
        ),
      ],
    ),
  );
}

Widget suggestionsForYouSection(BuildContext context, String title) {
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 18.w(context)),
        child: Text(
          title,
          style: TextStyle(
            color: color1C274C,
            fontSize: 15.w(context),
            fontWeight: FontWeightEnum.SemiBold.fWTheme,
          ),
        ),
      ),
      SizedBox(height: 13.h(context)),
      BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 12.0.w(context)),
              child: Shimmer(
                colorOpacity: 1,
                duration: Duration(seconds: 2),
                child: Container(
                  height: isTablet ? 180.h(context) : 170.h(context),
                  decoration: BoxDecoration(
                    color: colorE0E9F2,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            );
          }
          return CarouselWidget();
        },
      ),
    ],
  );
}

enum ProductType { account, loan, card, fixedTerm }

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final int _totalPages = 3; // Cambia según el número de ítems
  int _currentIndex = 0;

  final PageController _carousellController = PageController();

  @override
  void initState() {
    super.initState();

    _startAutoSlide();
  }

  void _startAutoSlide() {
    Future.delayed(Duration(seconds: 10), () {
      if (_carousellController.hasClients) {
        if (_currentIndex == _totalPages - 1) {
          // Simula el cambio al siguiente, pero regresa al primero
          _carousellController.animateToPage(
            0,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _carousellController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
      _startAutoSlide(); // Llamado recursivo para mantener el ciclo
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isTablet ? 180.h(context) : 170.h(context),
      padding: EdgeInsets.symmetric(horizontal: 18.w(context)),
      margin: EdgeInsets.only(bottom: 60.h(context)),
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              controller: _carousellController,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Image(
                    image: AssetImage(
                      isTablet
                          ? AppImages.sliderImageTablet
                          : AppImages.sliderImage,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Image(
                    image: AssetImage(
                      isTablet
                          ? AppImages.sliderImageTablet
                          : AppImages.sliderImage,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Image(
                    image: AssetImage(
                      isTablet
                          ? AppImages.sliderImageTablet
                          : AppImages.sliderImage,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          if (_totalPages > 1)
            Padding(
              padding: EdgeInsets.only(bottom: 5.h(context)),
              child: AnimatedSmoothIndicator(
                count: _totalPages,
                effect: ExpandingDotsEffect(
                  activeDotColor: Colors.white,
                  dotColor: Colors.white54,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
                activeIndex: _currentIndex,
              ),
            ),
        ],
      ),
    );
  }
}
