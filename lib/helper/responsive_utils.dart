import 'package:flutter/material.dart';

class Responsive {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;

  static bool isMobile(BuildContext context) => width(context) < 600;
  static bool isTablet(BuildContext context) => width(context) >= 600 && width(context) < 1200;
  static bool isDesktop(BuildContext context) => width(context) >= 1200;

  static double textSize(BuildContext context, double baseSize) {
    if (isTablet(context)) {
      return baseSize * 1.25;
    } else if (isDesktop(context)) {
      return baseSize * 1.5;
    }
    return baseSize;
  }
}
