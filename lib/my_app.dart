import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/getx_localization/language.dart';
import 'package:social_media_app/res/routes/routes.dart';
import 'package:social_media_app/res/theme/themes.dart';
import 'package:social_media_app/services/analytics_service/analytics_service.dart';
import 'package:social_media_app/utils/utils.dart';
import 'package:social_media_app/view/auth/forgot_password_screen/fp_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.unFocus(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Login',
        translations: Languages(),
        locale: Locale('en', 'US'),
        fallbackLocale: Locale('en', 'US'),
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: ThemeMode.light,
        // home: MyApp1(),
        getPages: Routes.appRoutes(),
        navigatorObservers: [
          FirebaseAnalyticsObserver(
              analytics: AnalyticsService.firebaseAnalytics),
        ],
      ),
    );
  }
}
