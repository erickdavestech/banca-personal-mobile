import 'dart:async';

import 'package:ca_mobile/src/bloc/login_bloc/login_bloc.dart';
import 'package:ca_mobile/src/bloc/products_bloc/products_bloc.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart';
import 'package:ca_mobile/src/screens/main/tabs/widget/money_bottom_sheet.dart';
import 'package:ca_mobile/src/screens/main/tabs/widget/main_drawer.dart';
import 'package:ca_mobile/src/screens/main/tabs/widget/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/tab/tab_bloc.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  static const String routeName = '/TabsScreen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final GlobalKey _fabKey = GlobalKey();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();

    // _checkInternet();
    InternetChecker.checkConnection(() {
      _showNoInternetModal();
    });
    context.read<ProductsBloc>().add(GetProducts());
    context.read<LoginBloc>().add(LoginSuccessEvent());
  }

  // @override
  // void dispose() {
  //   InternetChecker.checkConnection().cancel();
  //   super.dispose();
  // }

  // StreamSubscription<InternetStatus> _checkInternet() {
  //   return InternetConnection().onStatusChange.listen((InternetStatus status) {
  //     switch (status) {
  //       case InternetStatus.connected:
  //         log("Internet status: $status");
  //         // The internet is now connected
  //         break;
  //       case InternetStatus.disconnected:
  //         log("Internet status: $status");

  //         _showNoInternetModal();
  //         // The internet is now disconnected
  //         break;
  //     }
  //   });
  // }

  void _showNoInternetModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return NoInternet(
          onRetry: () async {
            context.pop();
            context.read<ProductsBloc>().add(GetProducts());
            if (!(await InternetChecker.hasInternetAccess)) {
              Future.delayed(
                  Duration(seconds: 3), () => _showNoInternetModal());
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return BlocBuilder<TabBloc, TabState>(
      builder: (context, state) {
        if (state is TabInitial) {
          return Scaffold(
            key: _scaffoldKey,
            endDrawer: CustomMainDrawer(),
            body: state.screen,
            floatingActionButton: FloatingActionButton(
              key: _fabKey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              backgroundColor: color005199,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) => CustomBottomSheet(
                    fabKey: _fabKey,
                  ),
                );
              },
              child: ImageIcon(
                AssetImage(AppImages.sendMoney),
                color: Colors.white,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: _tab(text, context, state),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _tab(AppLocalizations text, BuildContext context, TabInitial state) {
    return TabWidget(
      text: text,
      index: state.index,
      scaffoldKey: _scaffoldKey,
    );
  }
}

class NoInternet extends StatelessWidget {
  const NoInternet({
    super.key,
    required this.onRetry,
  });

  final Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.w(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.sizeOf(context).height * 0.05.h(context),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: context.pop,
                  icon: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: color005199,
                        width: 1.5.w(context),
                      ),
                    ),
                    child: Icon(
                      Icons.close,
                      size: 20.w(context),
                      color: color0080F2,
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Image(
              image: AssetImage(AppImages.noInternet),
              width: 240.w(context),
            ),
            SizedBox(height: 27.h(context)),
            Text(
              text.noInternet,
              style: TextStyle(
                color: color06243E,
                fontSize: 14.w(context),
                fontWeight: FontWeightEnum.SemiBold.fWTheme,
              ),
            ),
            SizedBox(height: 5.h(context)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w(context)),
              child: Text(
                text.noInternetMessage,
                style: TextStyle(
                  color: color506578,
                  fontSize: 12.w(context),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            OutlinedButton(
              onPressed: onRetry,
              child: Text(text.tryAgain),
            ),
          ],
        ),
      ),
    );
  }
}
