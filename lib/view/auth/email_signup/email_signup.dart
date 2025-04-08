import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/res/components/buttons/clickable_text.dart';
import 'package:social_media_app/res/components/buttons/long_elevated_button.dart';
import 'package:social_media_app/res/components/text_input/text_input.dart';
import 'package:social_media_app/utils/screen_utils.dart';
import 'package:social_media_app/view_model/auth_view_model/signup_controller/signup_controller.dart';

class EmailSignup extends StatefulWidget {
  const EmailSignup({super.key});

  @override
  State<EmailSignup> createState() => _EmailSignupState();
}

class _EmailSignupState extends State<EmailSignup> {
  final _signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("signup".tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _signupController.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  '${'image_path'.tr}${'splash_image'.tr}',
                  height: 200,
                ),
                TextInput(
                  initialValue: _signupController.emailId.value,
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter your Email Address';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Please write proper email';
                    }
                    return null;
                  },
                  icon: Icon(Icons.email),
                  label: "email".tr,
                  keyBoardType: TextInputType.emailAddress,
                  onSave: (value) {
                    setState(() {
                      _signupController.emailId.value = value!;
                    });
                  },
                ), // Email
                SizedBox(height: 20),
                TextInput(
                  onValidate: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        value.length < 6) {
                      return 'Password should have at least 6 characters';
                    }
                    return null;
                  },
                  initialValue: _signupController.pwd.value,
                  icon: Icon(Icons.password),
                  label: "password".tr,
                  keyBoardType: TextInputType.emailAddress,
                  obscureText: !_signupController.passwordVisible.value,
                  onSave: (value) {
                    _signupController.pwd.value = value!;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(_signupController.passwordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(
                        () {
                          _signupController.passwordVisible.value =
                              !_signupController.passwordVisible.value;
                        },
                      );
                    },
                  ),
                ), // Password
                SizedBox(height: 20),
                TextInput(
                  initialValue: _signupController.cPwd.value,
                  icon: Icon(Icons.password),
                  label: "confirm_password".tr,
                  keyBoardType: TextInputType.emailAddress,
                  onValidate: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        value.length < 6) {
                      return 'Password should have at least 6 characters';
                    }
                    return null;
                  },
                  obscureText: !_signupController.cPasswordVisible.value,
                  onSave: (value) {
                    _signupController.cPwd.value = value!;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(_signupController.cPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(
                        () {
                          _signupController.cPasswordVisible.value =
                              !_signupController.cPasswordVisible.value;
                        },
                      );
                    },
                  ),
                ), // Confirm Password
                SizedBox(height: 10),
                LongElevatedButton(
                  text: Text(
                    "signup".tr,
                    style: TextStyle(fontSize: 20),
                  ),
                  onClick: () {
                    setState(() {
                      _signupController.isAuthenticating.value = true;
                      _signupController.signupWithEmailPassword();
                    });
                  },
                ), // Sign Up
                SizedBox(height: 10),
                ClickableText(
                    onClick: () {
                      Get.back();
                    },
                    text: "login_account".tr), // toLogin
              ],
            ),
          ),
        ),
      ),
    );
  }
}
