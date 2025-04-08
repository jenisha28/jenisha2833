import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/res/components/buttons/otp_timer_button.dart';
import 'package:social_media_app/services/email_verification_service/email_verification_service.dart';
import 'package:social_media_app/utils/utils.dart';
import 'package:social_media_app/view_model/auth_view_model/forgot_password_controller/forgot_password_controller.dart';

class FpOtpScreen extends StatefulWidget {
  const FpOtpScreen({super.key});

  @override
  State<FpOtpScreen> createState() => _FPOtpScreenState();
}

class _FPOtpScreenState extends State<FpOtpScreen> {
  final resetPassword = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("verify_email".tr),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "OTP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 80.0),
            ),
            Text("Valid for 1 Minute",
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 40.0),
            Text("OTP sent to ${resetPassword.fEmailController.text}"),
            const SizedBox(height: 20.0),
            OtpTextField(
              mainAxisAlignment: MainAxisAlignment.center,
              numberOfFields: 6,
              fillColor: AppColors.black.withValues(alpha: 0.1),
              filled: true,
              onSubmit: (code) {
                setState(() {
                  resetPassword.verifyOtp(code);
                  resetPassword.isAuthenticating.value = true;
                });
              },
            ),
            const SizedBox(height: 30),
            resetPassword.isAuthenticating.value
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: const CircularProgressIndicator())
                : OtpTimerButton(
                    onPressed: () async {
                      if (await EmailVerificationService.sendOTP(
                          resetPassword.fEmailController.text)) {
                        Utils.toastMessage("OTP sent successfully.");
                      } else {
                        Utils.toastMessage("Failed to sent OTP. Retry");
                      }
                    },
                    loadingIndicator: CircularProgressIndicator(),
                    text: Text("Resend OTP"),
                    duration: 60,
                  ),
          ],
        ),
      ),
    );
  }
}
