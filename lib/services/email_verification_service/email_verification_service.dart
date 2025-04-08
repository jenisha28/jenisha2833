import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:social_media_app/data/app_exceptions.dart';

class EmailVerificationService {
  static Future<bool> sendOTP(String email) async {
    try {
      EmailOTP.config(
        appName: 'Social Media App',
        otpType: OTPType.numeric,
        expiry: 60000,
        emailTheme: EmailTheme.v6,
        appEmail: 'socialmediaapp@gmail.com',
        otpLength: 6,
      );
      bool isSend = await EmailOTP.sendOTP(email: email);
      return isSend;
    } on FirebaseAuthException catch (error) {
      Get.snackbar(
          "Authentication Exception", error.message ?? 'auth_failed'.tr);
      return false;
    } on NetworkException catch (error) {
      Get.snackbar("Internet not Connected",
          error.message ?? 'Please Check your Internet or WiFi Connection');
      return false;
    }
  }

  static Future<bool> verifyOtp(String otp) async {
    try {
      var result = EmailOTP.verifyOTP(otp: otp);
      return result;
    } on Exception catch (error) {
      Get.snackbar("Authentication Exception", error.toString());
      return false;
    }
  }
}