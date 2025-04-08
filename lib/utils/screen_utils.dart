import 'package:flutter/material.dart';

class ScreenUtils {

  // MediaQuery..

  static screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  static isPortrait(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait;

  static isLandScape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;



}
