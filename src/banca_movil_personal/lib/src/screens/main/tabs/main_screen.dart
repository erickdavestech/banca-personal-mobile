import 'package:ca_mobile/src/bloc/login_bloc/login_bloc.dart';
import 'package:ca_mobile/src/bloc/products_bloc/products_bloc.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart';

import 'package:ca_mobile/src/screens/authentication/login_screen.dart';
import 'package:ca_mobile/src/screens/main/tabs/widget/list_view_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const routeName = '/MainScreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildHeader(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          height: 250.h(context),
          width: double.infinity,
          decoration: BoxDecoration(
            color: color005199,
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
        _body(context, text),
      ],
    );
  }

  Widget _body(BuildContext context, AppLocalizations text) {
    return ListView(
      physics: ClampingScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.only(left: 18.w(context), right: 6.w(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: AssetImage(AppImages.caAppBar),
                width: 55.w(context),
                height: 55.w(context),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoginSuccess) {
                        return Text(
                          "${AppLocalizations.of(context)?.welcomeUser}, ${preferences.uName.capitalize}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeightEnum.SemiBold.fWTheme,
                            fontSize: 18.w(context),
                          ),
                        );
                      }

                      return Text(
                        "${AppLocalizations.of(context)?.welcomeUser}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeightEnum.SemiBold.fWTheme,
                          fontSize: 20.w(context),
                        ),
                      );
                    },
                  ),
                  Text(
                    DateFormat("EEEE d, MMMM y", preferences.uLanguaje)
                        .format(DateTime.now())
                        .capitalize,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.w(context),
                      fontWeight: FontWeightEnum.ExtraLight.fWTheme,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  showLogOutDialog(context);
                },
                child: Image(
                  image: AssetImage(AppImages.logOut),
                  width: 75.w(context),
                  height: 75.w(context),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h(context)),
        ListViewCards(
          onAddProduct: () {},
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${AppLocalizations.of(context)?.quickAccesTitle}",
                style: TextStyle(
                    fontSize: 15.w(context),
                    fontWeight: FontWeightEnum.SemiBold.fWTheme),
              ),
              ImageIcon(
                AssetImage(AppImages.settingsIcon),
                color: color506578,
                size: 18,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 14.h(context),
        ),
        BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return Container(
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
            }
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 12.0.w(context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _bottomOption(
                    context,
                    text: "${AppLocalizations.of(context)?.recargaTitle}",
                    onTap: () {},
                    iconPath: isTablet
                        ? AppImages.recargaIconTablet
                        : AppImages.recargaIcon,
                  ),
                  SizedBox(
                    height: 37.h(context),
                  ),
                  _bottomOption(
                    context,
                    text: "${AppLocalizations.of(context)?.transferenciaTitle}",
                    onTap: () {
                      // context
                      //     .pushNamed(TransferBetweenAccountsScreen.routeName);
                    },
                    iconPath: isTablet
                        ? AppImages.transferIconTablet
                        : AppImages.transferIcon,
                  ),
                  SizedBox(
                    height: 37.h(context),
                  ),
                  _bottomOption(
                    context,
                    text: "${AppLocalizations.of(context)?.yappyTitle}",
                    onTap: () {},
                    iconPath: isTablet
                        ? AppImages.yappyIconTablet
                        : AppImages.yappyIcon,
                  ),
                  SizedBox(
                    height: 37.h(context),
                  ),
                  _bottomOption(
                    context,
                    text: "${AppLocalizations.of(context)?.kuaraTitle}",
                    onTap: () {},
                    iconPath: isTablet
                        ? AppImages.kuaraIconTablet
                        : AppImages.kuaraIcon,
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 24.h(context)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w(context)),
          child: Text(
            text.sujestion,
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

  Future<void> showLogOutDialog(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 95.w(context),
                height: 95.h(context),
                child: Image.asset(
                  AppImages.logoutIcon,
                ),
              ),
              SizedBox(height: 18.h(context)),
              Text(
                text.alertLogOutTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.w(context),
                  fontWeight: FontWeightEnum.SemiBold.fWTheme,
                  color: color07355E,
                ),
              ),
            ],
          ),
          content: Text(
            text.alertLogOutSubTitle,
            style: TextStyle(
              fontSize: 14.w(context),
              color: color07355E,
            ),
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            OutlinedButton(
              onPressed: context.pop,
              style: ButtonStyle(
                fixedSize:
                    WidgetStatePropertyAll(Size(137.w(context), 50.h(context))),
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: color51708E.withOpacity(.33),
                  ),
                ),
              ),
              child: Text(
                text.alertLogOutBack,
                style: TextStyle(
                  fontSize: 12.w(context),
                  fontWeight: FontWeightEnum.Bold.fWTheme,
                  color: color516578,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => AlertDialog.adaptive(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      content: Column(
                        children: [
                          CircularProgressIndicator.adaptive(),
                          SizedBox(height: 20),
                          Text(
                            "Cargando...",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                  await AuthController.logOut();

                  context.pushNamedAndRemoveUntil(LoginScreen.routeName);
                } on Exception {
                  context.pop();
                }
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(137.w(context), 50.h(context)),
                backgroundColor: color005199,
              ),
              child: Text(
                text.closeSession,
                style: TextStyle(
                  fontSize: 12.w(context),
                  fontWeight: FontWeightEnum.Bold.fWTheme,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget _bottomOption(
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
          style: TextStyle(
            fontSize: 13.w(context),
            color: color212121,
          ),
        ),
      ],
    ),
  );
}

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
                    image: AssetImage(isTablet
                        ? AppImages.sliderImageTablet
                        : AppImages.sliderImage),
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Image(
                    image: AssetImage(isTablet
                        ? AppImages.sliderImageTablet
                        : AppImages.sliderImage),
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Image(
                    image: AssetImage(isTablet
                        ? AppImages.sliderImageTablet
                        : AppImages.sliderImage),
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
                // controller: _carousellController,
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
