import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/data/app_exceptions.dart';
import 'package:social_media_app/main.dart';
import 'package:social_media_app/res/components/network_checker/internet_checker.dart';
import 'package:social_media_app/res/routes/route_names.dart';
import 'package:social_media_app/services/email_verification_service/email_verification_service.dart';
import 'package:social_media_app/services/encryption_service/encryption_service.dart';
import 'package:social_media_app/services/login_service/login_service.dart';
import 'package:social_media_app/utils/utils.dart';

class ForgotPasswordController extends GetxController {
  var formKey = GlobalKey<FormState>();
  final internetChecker = Get.put(InternetChecker());
  RxString oldPassword = ''.obs;

  final fEmailController = TextEditingController();
  RxBool isAuthenticating = false.obs;

  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;

  RxBool hidePassword = true.obs;
  RxBool hideConfirmPassword = true.obs;

  bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  Future<void> submitResetEmail() async {
    try {
      isAuthenticating.value = true;
      final snapshot = await databaseRef.get();
      if (snapshot.exists) {
        final data = snapshot.value as Map;
        var userData = data.entries
            .firstWhere((e) => e.value['email'] == fEmailController.text);
        if (userData.value != null) {
          oldPassword.value =
              EncryptionService().decryptData(userData.value['password']);
          if (await EmailVerificationService.sendOTP(fEmailController.text)) {
            Utils.toastMessage("OTP sent successfully.");
            Get.toNamed(RouteNames.fpScreen);
          } else {
            Utils.toastMessage("Failed to sent OTP. Retry");
          }
          isAuthenticating.value = false;
        }
      } else {
        if (kDebugMode) {
          print('No data available.');
        }
        isAuthenticating.value = false;
      }
    } on FirebaseAuthException catch (error) {
      isAuthenticating.value = false;
      Get.snackbar("Authentication Error", error.message ?? 'auth_failed'.tr);
      if (kDebugMode) {
        print(error.message ?? 'auth_failed'.tr);
      }
    }
  }

  Future verifyOtp(String otp) async {
    bool result = await EmailVerificationService.verifyOtp(otp);
    if (result) {
      await LoginService.login(fEmailController.text, oldPassword.value);
      Get.offAndToNamed(RouteNames.resetPasswordScreen);
    } else {
      Get.snackbar("Invalid OTP", "Please re-enter your OTP");
    }
  }

  Future<void> resetPassword() async {
    try {
      if (formKey.currentState!.validate()) {
        String newPassword = passwordController.value.text;
        var encryptedPassword = EncryptionService().encryptData(newPassword);
        await firebase.currentUser!.updatePassword(newPassword);
        await databaseRef.child(firebase.currentUser!.uid).update({
          'password': encryptedPassword,
        });
        Get.offAllNamed(RouteNames.loginScreen);
        isAuthenticating.value = false;
      }
    } on FirebaseAuthException catch (error) {
      isAuthenticating.value = false;
      Get.snackbar("Authentication Error", error.message ?? 'auth_failed'.tr);
    } on NetworkException catch (error) {
      Get.snackbar("Internet not Connected",
          error.message ?? 'Please Check your Internet or WiFi Connection');
    }
  }
}
