import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart'
    show AppLocalizations;

import 'package:ca_mobile/src/screens/widgets/modal_contactos.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Drawer(
      backgroundColor: Colors.white,
      width: isTablet ? 390.w(context) : 331.w(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
      ),
      child: ListTileTheme(
        data: ListTileThemeData(
          contentPadding: EdgeInsets.zero,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w(context)),
          child: Column(
            children: [
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      text.drawerTitle,
                      style: TextStyle(
                        fontSize: isTablet ? 18.w(context) : 16.w(context),
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
              Divider(
                color: Colors.grey.withOpacity(0.5),
              ),
              SizedBox(height: isTablet ? 20.w(context) : 20.h(context)),
              ListTile(
                leading: Image(
                  image: AssetImage(AppImages.buildingsIconPath),
                  height: isTablet ? 30.h(context) : 20.h(context),
                  width: isTablet ? 30.w(context) : 20.w(context),
                ),
                title: Text(
                  text.drawerServicePlace,
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
                  text.drawerServiceMail,
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
                  text.drawerService,
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
                  text.drawerServiceDocument,
                  style: TextStyle(
                    color: color07355E,
                    fontSize: isTablet ? 16.w(context) : 14.w(context),
                  ),
                ),
              ),
              SizedBox(height: isTablet ? 15.w(context) : 0),
              ListTile(
                onTap: () {
                  context.pop();
                  modalContacts(context, text);
                },
                leading: Image(
                  image: AssetImage(AppImages.contactIconPath),
                  height: isTablet ? 30.w(context) : 20,
                  width: isTablet ? 30.w(context) : 20,
                ),
                title: Text(
                  text.contact,
                  style: TextStyle(
                    color: color07355E,
                    fontSize: isTablet ? 16.w(context) : 14.w(context),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Padding(
              //   padding: EdgeInsets.only(
              //       top: isTablet ? 260.w(context) : 70.w(context)),
              //   child: Image(
              //     image: AssetImage(AppImages.sbpLogoIconPath),
              //     height: isTablet ? 169.w(context) : 134.w(context),
              //     width: isTablet ? 169.w(context) : 134.w(context),
              //   ),
              // ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      // child: fbIcon,
                      child: Image(
                        image: AssetImage(AppImages.facebookIconPath),
                        width: isTablet ? 55.w(context) : 45.w(context),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {},
                      child: Image(
                        image: AssetImage(AppImages.linkedInIconPath),
                        width: isTablet ? 55.w(context) : 45.w(context),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {},
                      child: Image(
                        image: AssetImage(AppImages.xIconPath),
                        width: isTablet ? 55.w(context) : 45.w(context),
                      ),
                    ),
                    SizedBox(width: 10),
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
              Divider(
                color: Colors.grey.withOpacity(0.5),
              ),
              SizedBox(height: 20),
              Text("${text.version} 0.1.0",
                  style: TextStyle(color: Colors.grey)),
              SizedBox(height: isTablet ? 35 : 25),
            ],
          ),
        ),
      ),
    );
  }
}
