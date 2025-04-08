import 'package:get/get.dart';
import 'package:social_media_app/res/theme/themes.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(
      Get.isDarkMode ? Themes.lightTheme : Themes.darkTheme,
    );
    // Get.changeThemeMode(
    //   isDarkMode.value ? ThemeMode.light : ThemeMode.dark,
    // );
  }
}
