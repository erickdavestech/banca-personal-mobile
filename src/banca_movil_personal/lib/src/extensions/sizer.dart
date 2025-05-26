// import 'dart:ui';

// import 'package:flutter/material.dart';

// /// This extention help us to make widget responsive.
// extension NumberParsing on num {
//   /// Get screen media.

//   double w(BuildContext context) {
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     num width = MediaQuery.of(context).size.width;
//     num size = isPortrait ? 428 : 926;
//     if (isTablet) {
//       size = isPortrait ? 768 : 1024;
//     }

//     return this * width / size;
//   }

//   double h(BuildContext context) {
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     num height = MediaQuery.of(context).size.height;
//     num size = isPortrait ? 926 : 428;

//     return this * height / size;
//   }
// }

// bool get isTablet {
//   double shortestSide =
//       PlatformDispatcher.instance.views.first.physicalSize.shortestSide /
//           PlatformDispatcher.instance.views.first.devicePixelRatio;

//   // log("shortestSide: ${PlatformDispatcher.instance.views.first.physicalSize}");

//   return shortestSide > 600; // Umbral típico para diferenciar tablets
// }
