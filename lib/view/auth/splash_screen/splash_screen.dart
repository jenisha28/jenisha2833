import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/utils/screen_utils.dart';
import 'package:social_media_app/view_model/auth_view_model/splash_controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = Get.put(SplashController());

  @override
  void initState() {
    controller.startApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: ScreenUtils.screenWidth(context),
        height: ScreenUtils.screenHeight(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('${'image_path'.tr}${'splash_image'.tr}', height: 200,),
            SizedBox(
              height: 30,
            ),
            Text(
              "Connect with others",
              style: ThemeData().textTheme.headlineLarge!.copyWith(
                    fontSize: 20,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color:
                        Get.isDarkMode ? AppColors.white : AppColors.blue,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
