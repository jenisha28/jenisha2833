import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/res/routes/route_names.dart';
import 'package:social_media_app/view_model/auth_view_model/forgot_password_controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _forgotPasswordController = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("forgot_password".tr),
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(20),
              shadowColor:
                  Get.isDarkMode ? AppColors.blue : AppColors.lightBlue,
              child: TextField(
                controller: _forgotPasswordController.fEmailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      Get.isDarkMode ? AppColors.blueGrey : AppColors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Get.isDarkMode
                            ? AppColors.blueGrey
                            : AppColors.white,
                        width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Get.isDarkMode
                            ? AppColors.blueGrey
                            : AppColors.white,
                        width: 1),
                  ),
                  prefixIcon: Icon(
                    Icons.email,
                    color: AppColors.blue,
                  ),
                  labelText: 'email'.tr,
                  labelStyle: TextStyle(color: AppColors.blue),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "cancel".tr,
                    style: TextStyle(color: AppColors.blue),
                  ),
                ),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
                  onPressed: () {
                    _forgotPasswordController.submitResetEmail();
                    // Get.toNamed(RouteNames.resetPasswordScreen);
                    /* setState(() {
                      _forgotPasswordController.isAuthenticating.value = true;
                      if (kDebugMode) {
                        print(_forgotPasswordController.fEmailController.text);
                      }
                      _forgotPasswordController.sendPasswordResetMail();
                      Get.toNamed(RouteNames.fpScreen);
                    }); */
                  },
                  child: _forgotPasswordController.isAuthenticating.value
                      ? const CircularProgressIndicator()
                      : Text(
                          "send_reset_email".tr,
                          style: TextStyle(color: AppColors.white),
                        ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
