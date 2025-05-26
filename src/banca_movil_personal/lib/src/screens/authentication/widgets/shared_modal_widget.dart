import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';

Widget modalHandle(BuildContext context) {
  return Container(
    width: 50.w(context),
    height: 4.h(context),
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

Widget bottomOption(
  BuildContext context, {
  required String text,
  required VoidCallback onTap,
  required String iconPath,
  Color color = const Color(0xFF07355E),
}) {
  final isTablet = MediaQuery.of(context).size.shortestSide > 600;

  return InkWell(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image(
          image: AssetImage(iconPath),
          color: color,
          height: isTablet ? 25.w(context) : 20,
          width: isTablet ? 25.w(context) : 20,
        ),
        SizedBox(height: 4.w(context)),
        Text(
          text,
          style: TextStyle(
            fontSize: isTablet ? 18.w(context) : 14.w(context),
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget bottomOptionsBar(
  BuildContext context, {
  required String promoText,
  required String tokenText,
  required String userText,
  required VoidCallback onTapPromo,
  required VoidCallback onTapToken,
  required VoidCallback onTapUser,
  required String promoIconPath,
  required String tokenIconPath,
  required String userIconPath,
  Color tokenColor = const Color(0xFF0080F2),
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 6.h(context)),
    child: SizedBox(
      height: 70.h(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          bottomOption(
            context,
            text: promoText,
            iconPath: promoIconPath,
            onTap: onTapPromo,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: VerticalDivider(color: Color(0xFF07355E).withOpacity(.12)),
          ),
          bottomOption(
            context,
            text: tokenText,
            iconPath: tokenIconPath,
            onTap: onTapToken,
            color: tokenColor,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: VerticalDivider(color: Color(0xFF07355E).withOpacity(.12)),
          ),
          bottomOption(
            context,
            text: userText,
            iconPath: userIconPath,
            onTap: onTapUser,
          ),
        ],
      ),
    ),
  );
}
