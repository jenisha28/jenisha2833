import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/res/components/buttons/otp_timer_button.dart';
import 'package:social_media_app/view_model/auth_view_model/signup_controller/signup_controller.dart';

class EmailOtpVerification extends StatefulWidget {
  const EmailOtpVerification({super.key});

  @override
  State<EmailOtpVerification> createState() => _EmailOtpVerificationState();
}

class _EmailOtpVerificationState extends State<EmailOtpVerification>
    with TickerProviderStateMixin {
  final _signupController = Get.put(SignupController());
  AnimationController? _controller;
  int otpTimer = 60;

  @override
  void dispose() {
    // TODO: implement dispose
    _controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: otpTimer));
    _controller!.forward();
    super.initState();
  }

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
            Text("OTP sent to ${_signupController.verificationEmail}"),
            const SizedBox(height: 20.0),
            OtpTextField(
              mainAxisAlignment: MainAxisAlignment.center,
              numberOfFields: 6,
              fillColor: AppColors.black.withValues(alpha: 0.1),
              filled: true,
              onSubmit: (code) {
                  _signupController.verifyEmailOtp(code);
                  setState(() {
                    _signupController.isAuthenticating.value = true;
                  });
              },
            ),
            const SizedBox(height: 30),
            _signupController.isAuthenticating.value
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: const CircularProgressIndicator())
                : OtpTimerButton(
                    onPressed: () {
                      _signupController.resendOTP();
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
