import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/res/components/buttons/clickable_text.dart';
import 'package:social_media_app/res/components/buttons/long_elevated_button.dart';
import 'package:social_media_app/res/components/buttons/shadow_button.dart';
import 'package:social_media_app/res/components/text_input/text_input.dart';
import 'package:social_media_app/res/routes/route_names.dart';
import 'package:social_media_app/view_model/auth_view_model/login_controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _signInController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login".tr),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset(
                '${'image_path'.tr}${'splash_image'.tr}',
                height: 200,
              ),
              Form(
                key: _signInController.lFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextInput(
                        initialValue: _signInController.email.value,
                        onValidate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter your Email Address';
                          }
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'Please write proper email';
                          }
                          return null;
                        },
                        onSave: (value) {
                          _signInController.email.value = value!;
                        },
                        icon: Icon(Icons.email),
                        label: 'Email'),
                    const SizedBox(height: 20),
                    TextInput(
                      onValidate: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.length < 6) {
                          return 'Password should have at least 6 characters';
                        }
                        return null;
                      },
                      initialValue: _signInController.password.value,
                      icon: Icon(
                        Icons.password,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_signInController.passwordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                            () {
                              _signInController.passwordVisible.value =
                                  !_signInController.passwordVisible.value;
                            },
                          );
                        },
                      ),
                      onSave: (value) {
                        _signInController.password.value = value!;
                      },
                      label: "password".tr,
                      obscureText: !_signInController.passwordVisible.value,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ClickableText(
                          onClick: () {
                            Get.toNamed(RouteNames.forgotPasswordScreen);
                          },
                          text: '${"forgot_password".tr}?',
                          textAlign: TextAlign.end,
                          textColor: AppColors.blue,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LongElevatedButton(
                      text: _signInController.isAuthenticating.value
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: const CircularProgressIndicator(
                                color: AppColors.white,
                              ),
                            )
                          : Text(
                              "login".tr,
                              style: TextStyle(fontSize: 20),
                            ),
                      onClick: () {
                        setState(() {
                          _signInController.isAuthenticating.value = true;
                          _signInController.submit();
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    ClickableText(
                      onClick: () {
                        Get.toNamed(RouteNames.signupScreen);
                      },
                      text: "create_account".tr,
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ShadowButton(
                            onClick: () async {
                              await _signInController.signInWithGoogle();
                            },
                            assetImagePath: '${'icon_path'.tr}${'google'.tr}',
                            text: "Sign In with Google"),
                        const SizedBox(height: 10),
                        ShadowButton(
                          onClick: () async {
                            // var user =
                            await _signInController.signInWithFacebook();
                            // print('facebook email${user.user!.displayName}');
                          },
                          assetImagePath: '${'icon_path'.tr}${'facebook'.tr}',
                          text: "Sign In with Facebook",
                          textColor: AppColors.white,
                          buttonColor: Color(0xff0089fc),
                        ),
                        const SizedBox(height: 10),
                        ShadowButton(
                          onClick: () {},
                          assetImagePath: '${'icon_path'.tr}${'apple'.tr}',
                          text: "Sign In with Apple",
                          buttonColor: Get.isDarkMode
                              ? AppColors.white
                              : AppColors.black,
                          imageColor: Get.isDarkMode
                              ? AppColors.black
                              : AppColors.white,
                          textColor: Get.isDarkMode
                              ? AppColors.black
                              : AppColors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ClickableText(
                      onClick: () {
                        Get.toNamed(RouteNames.emailSignup);
                      },
                      text: "Create account using email-password",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
