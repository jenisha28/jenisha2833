import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/main.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/res/components/text_input/text_input.dart';
import 'package:social_media_app/view_model/auth_view_model/forgot_password_controller/forgot_password_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final resetPassword = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("reset_password".tr),
      ),
      body: PopScope(
        onPopInvokedWithResult: (val, value) async {
          print("Back.................");
          if (firebase.currentUser != null) {
            await firebase.signOut();
            print('Logout');
          } else {
            print('No user there');
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: resetPassword.formKey,
              child: Column(
                children: [
                  TextInput(
                    controller: resetPassword.passwordController.value,
                    icon: Icon(Icons.password_sharp),
                    label: "New Password",
                    obscureText: resetPassword.hidePassword.value,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          resetPassword.hidePassword.value =
                              !resetPassword.hidePassword.value;
                        });
                      },
                      icon: Icon(resetPassword.hidePassword.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    onValidate: (value) {
                      if (resetPassword.passwordController.value.text.length <
                          6) {
                        return 'Password have at least 6 characters.';
                      } else if (!resetPassword.validatePassword(
                          resetPassword.passwordController.value.text)) {
                        return 'Password should have [0-9], [a-z], [A-Z], [!@#\$&*~]';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextInput(
                    controller: resetPassword.confirmPasswordController.value,
                    icon: Icon(Icons.password_sharp),
                    label: "New Confirm Password",
                    obscureText: resetPassword.hideConfirmPassword.value,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          resetPassword.hideConfirmPassword.value =
                              !resetPassword.hideConfirmPassword.value;
                        });
                      },
                      icon: Icon(resetPassword.hideConfirmPassword.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    onValidate: (value) {
                      if (resetPassword
                              .confirmPasswordController.value.text.length <
                          6) {
                        return 'Password have at least 6 characters.';
                      } else if (!resetPassword.validatePassword(
                          resetPassword.confirmPasswordController.value.text)) {
                        // return 'Password should have to be Strong.';
                        return 'Password should have [0-9], [a-z], [A-Z], [!@#\$&*~]';
                      } else if (resetPassword.passwordController.value.text !=
                          resetPassword.confirmPasswordController.value.text) {
                        return 'Please Enter Correct Password';
                      }
                      return null;
                    },
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
                          "Cancel",
                          style: TextStyle(color: AppColors.blue),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          resetPassword.resetPassword();
                        },
                        child: Text("Save New Password"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
