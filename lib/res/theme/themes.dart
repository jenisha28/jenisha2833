import 'package:flutter/material.dart';
import 'package:social_media_app/res/colors/app_colors.dart';

class Themes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.grey100,
    textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w600,
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w500,
          ),
          bodySmall: TextStyle(
            color: AppColors.black,
            fontFamily: "OpenSans",
          ),
          bodyMedium: TextStyle(
            color: AppColors.black,
            fontFamily: "OpenSans",
          ),
          bodyLarge: TextStyle(
            color: AppColors.black,
            fontFamily: "OpenSans",
          ),
        ),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
          centerTitle: false,
          foregroundColor: AppColors.black,
          backgroundColor: AppColors.grey100,
        ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.black,
          foregroundColor: AppColors.blue,
          textStyle: ThemeData().textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.black,
    textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: "OpenSans",
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: "OpenSans",
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.white,
            fontFamily: "OpenSans",
          ),
          bodySmall: TextStyle(
            color: AppColors.white,
            fontFamily: "OpenSans",
          ),
          bodyMedium: TextStyle(
            color: AppColors.white,
            fontFamily: "OpenSans",
          ),
          bodyLarge: TextStyle(
            color: AppColors.white,
            fontFamily: "OpenSans",
          ),
        ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blue,
          foregroundColor: AppColors.white,
          textStyle: ThemeData().textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
    ),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
          centerTitle: false,
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.black,
        ),
  );
}
