// ignore_for_file: constant_identifier_names

import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum FontWeightEnum {
  Thin,
  ExtraLight,
  Light,
  Medium,
  SemiBold,
  ExtraBold,
  Bold,
  Black,
}

ThemeData themeData(BuildContext context) => ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(10),
    enabledBorder: borders,
    border: borders,
    focusedBorder: borders,
    filled: true,
    fillColor: Colors.white,
    hintStyle: TextStyle(
      color: color07355E.withOpacity(.5),
      fontSize: 16.w(context),
    ),
  ),
  // colorScheme: ColorScheme.fromSeed(seedColor: color4C8CD3),
  useMaterial3: true,
  primaryColor: color005199,

  textButtonTheme: textButtonThemeData(context),
  scaffoldBackgroundColor: Colors.white,
  elevatedButtonTheme: elevatedButtonThemeData(context),
  outlinedButtonTheme: outlinedButtonThemeData(context),

  // checkboxTheme: checkboxThemeData,
  // dividerTheme: const DividerThemeData(color: colorE8EBEF),

  // fontFamily: "Poppins",
  fontFamily: GoogleFonts.poppins().fontFamily,
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    surfaceTintColor: Colors.white,
    color: Colors.white,
    titleTextStyle: TextStyle(
      fontSize: 20.w(context),
      color: color07355E,
      fontWeight: FontWeightEnum.Medium.fWTheme,
    ),
  ),
  tabBarTheme: TabBarThemeData(indicatorColor: color005199),
);

TextButtonThemeData textButtonThemeData(BuildContext context) =>
    TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(color005199),
        fixedSize: WidgetStatePropertyAll(Size(double.infinity, 55.h(context))),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.poppins(color: color005199, fontSize: 15.w(context)),
        ),
        foregroundBuilder: (context, states, child) {
          return Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: child!,
          );
        },
      ),
    );
ElevatedButtonThemeData elevatedButtonThemeData(BuildContext context) =>
    ElevatedButtonThemeData(
      style: ButtonStyle(
        fixedSize: WidgetStatePropertyAll(Size(double.infinity, 55.h(context))),
        iconSize: const WidgetStatePropertyAll(16),
        iconColor: const WidgetStatePropertyAll(Colors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        foregroundBuilder: (context, states, child) {
          return Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: child!,
          );
        },
        backgroundColor: const WidgetStatePropertyAll(color005199),
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 15.w(context),
            fontWeight: FontWeightEnum.Medium.fWTheme,
          ),
        ),
      ),
    );

OutlinedButtonThemeData outlinedButtonThemeData(BuildContext context) =>
    OutlinedButtonThemeData(
      style: ButtonStyle(
        fixedSize: WidgetStatePropertyAll(Size(double.infinity, 55.h(context))),
        iconSize: const WidgetStatePropertyAll(16),
        iconColor: const WidgetStatePropertyAll(Colors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        foregroundColor: const WidgetStatePropertyAll(color005199),
        side: WidgetStatePropertyAll(BorderSide(color: color005199)),
        foregroundBuilder: (context, states, child) {
          return Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: child!,
          );
        },
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 15.w(context),
            fontWeight: FontWeightEnum.Medium.fWTheme,
          ),
        ),
      ),
    );

// final checkboxThemeData = CheckboxThemeData(
//   // fillColor: WidgetStatePropertyAll(Colors.white),
//   // checkColor: WidgetStatePropertyAll(color4C8CD3),
//   splashRadius: 0,
//   materialTapTargetSize: MaterialTapTargetSize.padded,
//   side: const BorderSide(
//     width: 1,
//     color: colorE8EBEF,
//   ),
//   shape: RoundedRectangleBorder(
//     side: const BorderSide(
//       width: 1,
//       color: colorE8EBEF,
//     ),
//     borderRadius: BorderRadius.circular(4),
//   ),
// );

OutlineInputBorder withOutBorder = const OutlineInputBorder(
  borderSide: BorderSide.none,
);

extension FontWeightExtension on FontWeightEnum {
  FontWeight get fWTheme {
    switch (this) {
      case FontWeightEnum.Thin:
        return FontWeight.w100;
      case FontWeightEnum.ExtraLight:
        return FontWeight.w200;
      case FontWeightEnum.Light:
        return FontWeight.w300;
      case FontWeightEnum.Medium:
        return FontWeight.w500;
      case FontWeightEnum.SemiBold:
        return FontWeight.w600;
      case FontWeightEnum.ExtraBold:
        return FontWeight.w800;
      case FontWeightEnum.Black:
        return FontWeight.w900;
      case FontWeightEnum.Bold:
        return FontWeight.bold;
    }
  }
}

OutlineInputBorder get borders {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
    borderSide: BorderSide(color: color51708E.withOpacity(.33)),
  );
}
