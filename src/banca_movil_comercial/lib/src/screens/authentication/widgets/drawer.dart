import 'package:banca_movil_comercial/src/extensions/context_extensions.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';

import 'package:flutter/material.dart';

class LoginDrawer extends StatelessWidget {
  const LoginDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: isTablet ? 390.w(context) : 331.w(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
      ),
      child: ListTileTheme(
        data: ListTileThemeData(contentPadding: EdgeInsets.zero),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w(context)),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.sizeOf(context).height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            context.lang.drawerTitle,
                            style: TextStyle(
                              fontSize:
                                  isTablet ? 18.w(context) : 16.w(context),
                              fontWeight: FontWeightEnum.Medium.fWTheme,
                              color: color07355E,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Image(
                            image: AssetImage(AppImages.closeCircleIconPath),
                            height: 25,
                            width: 25,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    SizedBox(height: isTablet ? 20.w(context) : 10.h(context)),
                    Divider(color: Colors.grey.withOpacity(0.5)),
                    SizedBox(height: isTablet ? 20.w(context) : 20.h(context)),
                    ListTile(
                      leading: Image(
                        image: AssetImage(AppImages.buildingsIconPath),
                        height: isTablet ? 30.h(context) : 20.h(context),
                        width: isTablet ? 30.w(context) : 20.w(context),
                      ),
                      title: Text(
                        context.lang.drawerServicePlace,
                        style: TextStyle(
                          color: color07355E,
                          fontSize: isTablet ? 16.w(context) : 14.w(context),
                        ),
                      ),
                    ),
                    SizedBox(height: isTablet ? 15.w(context) : 0),
                    ListTile(
                      leading: Image(
                        image: AssetImage(AppImages.emailIconPath),
                        height: isTablet ? 30.h(context) : 20.h(context),
                        width: isTablet ? 30.w(context) : 20.w(context),
                      ),
                      title: Text(
                        context.lang.drawerServiceMail,
                        style: TextStyle(
                          color: color07355E,
                          fontSize: isTablet ? 16.w(context) : 14.w(context),
                        ),
                      ),
                    ),
                    SizedBox(height: isTablet ? 15.w(context) : 0),
                    ListTile(
                      leading: Image(
                        image: AssetImage(AppImages.cjLineaIconPath),
                        height: isTablet ? 30.h(context) : 20.h(context),
                        width: isTablet ? 30.w(context) : 20.w(context),
                      ),
                      title: Text(
                        context.lang.drawerService,
                        style: TextStyle(
                          color: color07355E,
                          fontSize: isTablet ? 16.w(context) : 14.w(context),
                        ),
                      ),
                    ),
                    SizedBox(height: isTablet ? 15.w(context) : 0),
                    ListTile(
                      leading: Image(
                        image: AssetImage(AppImages.documentsIconPath),
                        height: isTablet ? 30.h(context) : 20.h(context),
                        width: isTablet ? 30.w(context) : 20.w(context),
                      ),
                      title: Text(
                        context.lang.drawerServiceDocument,
                        style: TextStyle(
                          color: color07355E,
                          fontSize: isTablet ? 16.w(context) : 14.w(context),
                        ),
                      ),
                    ),
                    SizedBox(height: isTablet ? 15.w(context) : 0),
                    ListTile(
                      onTap: () {},
                      leading: Image(
                        image: AssetImage(AppImages.contactIconPath),
                        height: isTablet ? 30.w(context) : 20,
                        width: isTablet ? 30.w(context) : 20,
                      ),
                      title: Text(
                        context.lang.contact,
                        style: TextStyle(
                          color: color07355E,
                          fontSize: isTablet ? 16.w(context) : 14.w(context),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Image(
                              image: AssetImage(AppImages.facebookIconPath),
                              width: isTablet ? 55.w(context) : 45.w(context),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {},
                            child: Image(
                              image: AssetImage(AppImages.linkedInIconPath),
                              width: isTablet ? 55.w(context) : 45.w(context),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {},
                            child: Image(
                              image: AssetImage(AppImages.xIconPath),
                              width: isTablet ? 55.w(context) : 45.w(context),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {},
                            child: Image(
                              image: AssetImage(AppImages.instagramIconPath),
                              width: isTablet ? 55.w(context) : 45.w(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey.withOpacity(0.5)),
                    const SizedBox(height: 20),
                    version(context),
                    SizedBox(height: isTablet ? 35 : 25),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget version(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.landscape) {
      return Flexible(
        child: Text(
          "${context.lang.version} 0.1.0",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
    return Text(
      "${context.lang.version} 0.1.0",
      style: TextStyle(color: Colors.grey),
    );
  }
}
