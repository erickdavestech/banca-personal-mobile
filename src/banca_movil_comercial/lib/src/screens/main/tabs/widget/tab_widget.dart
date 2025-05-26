import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:banca_movil_comercial/src/bloc/tab/tab_bloc.dart';
import 'package:banca_movil_comercial/src/localization/app_localizations.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabWidget extends StatelessWidget {
  final AppLocalizations text;
  final int index;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const TabWidget({
    super.key,
    required this.text,
    required this.index,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      shadow: Shadow(color: Colors.black26, blurRadius: 20),
      height: isTablet ? 70 : null,
      itemCount: 4,
      tabBuilder: (index, isActive) {
        switch (index) {
          case 0:
            return _tabItem(
              title: text.tabItem,
              imagePath: AppImages.homeSmile,
              isActive: isActive,
              context: context,
            );
          case 1:
            return _tabItem(
              title: text.tabItemProducts,
              imagePath: AppImages.apps,
              isActive: isActive,
              context: context,
            );
          case 2:
            return _tabItem(
              title: text.authorize,
              imagePath: AppImages.clipboardCheckIcon,
              isActive: isActive,
              context: context,
            );

          default:
            return _tabItem(
              title: text.options,
              imagePath: AppImages.hamburgerIconPath,
              isActive: isActive,
              context: context,
            );
        }
      },
      elevation: 10,
      backgroundColor: Colors.white,
      activeIndex: index,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      onTap: (tappedIndex) {
        if (tappedIndex == 3) {
          scaffoldKey.currentState?.openEndDrawer();
        } else {
          final tappedTab = AppTab.values[tappedIndex];
          final currentTab = AppTab.values[index];
          final tabBloc = context.read<TabBloc>();

          if (tappedTab == currentTab) {
            // Si el usuario toca el mismo tab, resetea el stack
            final navigatorKey = tabBloc.tabNavigatorKeys[tappedTab];
            navigatorKey?.currentState?.popUntil((route) => route.isFirst);
          } else {
            // Cambia de tab
            tabBloc.add(TabChangeIndex(tappedIndex));
          }
        }
      },
    );
  }

  Widget _tabItem({
    required String title,
    required String imagePath,
    required bool isActive,
    required BuildContext context,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ImageIcon(
          AssetImage(imagePath),
          size: isTablet ? 30 : 24,
          color: isActive ? color043371 : color506578,
        ),
        SizedBox(height: 5.h(context)),
        Text(
          title,
          style: TextStyle(
            color: isActive ? color043371 : color506578,
            fontSize: 14.w(context),
          ),
        ),
      ],
    );
  }
}
