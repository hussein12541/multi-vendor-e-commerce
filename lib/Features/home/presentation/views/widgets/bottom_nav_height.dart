import 'package:flutter/material.dart';

class AppDimensions {
  static double bottomBarHeight = 56;

  static double getBottomBarTotalHeight(BuildContext context) {
    return bottomBarHeight + (MediaQuery.of(context).size.height * 0.025 * 2);
  }
}
