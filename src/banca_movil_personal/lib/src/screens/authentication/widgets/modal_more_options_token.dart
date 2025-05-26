import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart'
    show AppLocalizations;
import 'package:ca_mobile/src/screens/authentication/scan_face_screen.dart';
import 'package:ca_mobile/src/screens/authentication/widgets/shared_modal_widget.dart';

void showMoreOptionsTokenModal(BuildContext context) {
  final text = AppLocalizations.of(context)!;

  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.59,
        maxChildSize: 0.59,
        minChildSize: 0.59,
        builder: (_, controller) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            // En showMoreOptionsTokenModal
            padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 12.h(context)),
                modalHandle(context),
                SizedBox(height: 12.h(context)),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios,
                            size: 20.w(context), color: color07355E),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Center(
                      child: Text(
                        text.tokenOptions,
                        style: TextStyle(
                          fontSize: 16.w(context),
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF07355E),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text.serial,
                      style: TextStyle(
                        fontSize: 14.w(context),
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF07355E),
                      ),
                    ),
                    SizedBox(width: 12.w(context)),
                    Text(
                      '0000511108650001555',
                      style: TextStyle(
                        fontSize: 14.w(context),
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF506578),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text.expiration,
                      style: TextStyle(
                        fontSize: 14.w(context),
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF07355E),
                      ),
                    ),
                    SizedBox(width: 12.w(context)),
                    Text(
                      '31/12/2035',
                      style: TextStyle(
                        fontSize: 14.w(context),
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF506578),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h(context)),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFE0DA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 20.h(context),
                        horizontal: 20.w(context),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      text.disableToken,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.w(context),
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFF2794C),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h(context)),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15.h(context),
                    bottom: 10.h(context),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 18.w(context),
                        color: color1C274C.withOpacity(0.4),
                      ),
                      SizedBox(width: 4.w(context)),
                      Expanded(
                        child: Text(
                          text.tokenWarning,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 12.w(context),
                            color: color1C274C.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    color: color07355E.withOpacity(.12),
                    thickness: 1,
                  ),
                ),
                SizedBox(height: 12.h(context)),
                bottomOptionsBar(
                  context,
                  promoText: text.drawerServicePromotion,
                  tokenText: text.token,
                  userText: text.newUser,
                  onTapPromo: () {},
                  onTapToken: () {
                    Navigator.pop(context);
                  },
                  onTapUser: () {
                    context.pushNamed(ScanFaceScreen.routeName);
                  },
                  promoIconPath: AppImages.bookmarksIconPath,
                  tokenIconPath: AppImages.tokenIconPath,
                  userIconPath: AppImages.userIconPath,
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
