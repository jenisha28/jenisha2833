import 'dart:async';
import 'package:get/get.dart';
import 'package:social_media_app/data/app_preference/app_preference.dart';
import 'package:social_media_app/res/routes/route_names.dart';

class SplashController extends GetxController {
  void startApp() {
    if (AppPreference.isExist('user_preference_key'.tr) && AppPreference.getPreference('user_preference_key'.tr)) {
      Timer(Duration(seconds: 3), () => Get.offNamed(RouteNames.navMenu));
    } else {
      Timer(Duration(seconds: 3), () => Get.offNamed(RouteNames.loginScreen));
    }

  }
}