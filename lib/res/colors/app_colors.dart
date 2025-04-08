import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AppColors {
  static const Color primaryColor = Color(0xff185f70);
  static const Color darkPrimaryColor = Color(0xff96c5cc);
  static const Color secondaryColor = Color(0xff96c5cc);
  static const Color darkSecondaryColor = Color(0xff185f70);
  static const Color backgroundColor = Color(0xffb1cbd3);
  static const Color textColor = Color(0xff04292d);
  static const Color deepPurple = Color(0xFF673AB7);
  static const Color deepPurple400 = Color(0xFF7E57C2);
  static const Color deepPurple50 = Color(0xFFEDE7F6);
  static const Color deepPurpleShade200 = Color(0xFFB39DDB);

  static const Color darkTeal = Color(0xFF002C2A);
  static const Color teal = Color(0xFF009688);
  static const Color teal50 = Color(0xFFE0F2F1);
  static const Color teal100 = Color(0xFFB2DFDB);
  static const Color teal200 = Color(0xFF80CBC4);
  static const Color teal300 = Color(0xFF4DB6AC);

  static const Color red = Color(0xffff0000);
  static const Color yellow = Color(0xffffff00);
  static const Color green = Color(0xFF4CAF50);
  static const Color lightGreen = Color(0xff00ffaf);
  static const Color blueAccent = Color(0xFF2196F3);
  static const Color black = Color(0xff000000);
  static const Color lightBlack = Color(0xff464646);
  static const Color white = Color(0xffffffff);
  static const Color grey = Color(0xff808080);
  static const Color lightGrey = Color(0xffa9a9a9);
  static const Color grey100 = Color(0xfff3f3f3);
  static const Color radiantBlue = Color(0xff0067fd);

  static const Color darkBlue = Color(0xff00203f);
  static const Color blue = Color(0xff33a0ce);
  static const Color lightBlue = Color(0xffe9f5ff);
  static const Color blueGrey = Color(0xb303262f);

  static Color randomColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt());

}