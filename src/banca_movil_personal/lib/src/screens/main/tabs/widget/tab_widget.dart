import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:ca_mobile/src/bloc/tab/tab_bloc.dart';

import 'package:ca_mobile/src/localization/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabWidget extends StatelessWidget {
  final AppLocalizations text;
  final int index;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const TabWidget(
      {super.key,
      required this.text,
      required this.index,
      required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
        shadow: Shadow(
          color: Colors.black26,
          blurRadius: 20,
        ),
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
                title: text.tabItemRequest,
                imagePath: AppImages.fileText,
                isActive: isActive,
                context: context,
              );

            default:
              return _tabItem(
                title: text.tabItemDrawer,
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
        onTap: (index) {
          if (index == 3) {
            scaffoldKey.currentState?.openEndDrawer();
          } else {
            context.read<TabBloc>().add(TabChangeIndex(index));
          }
        });
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
          color: isActive ? color005199 : color506578,
        ),
        SizedBox(height: 5.h(context)),
        Text(
          title,
          style: TextStyle(
            color: isActive ? color005199 : color506578,
            fontSize: 14.w(context),
          ),
        ),
      ],
    );
  }
}
