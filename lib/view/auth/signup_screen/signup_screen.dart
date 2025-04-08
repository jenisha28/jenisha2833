import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/res/components/buttons/clickable_text.dart';
import 'package:social_media_app/res/components/buttons/long_elevated_button.dart';
import 'package:social_media_app/res/components/text_input/text_input.dart';
import 'package:social_media_app/view/auth/signup_screen/signup_widgets/date_picker_widget.dart';
import 'package:social_media_app/view/auth/signup_screen/signup_widgets/gender_widget.dart';
import 'package:social_media_app/view_model/auth_view_model/signup_controller/signup_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                TextInput(
                  initialValue: _signupController.userid.value,
                  onSave: (value) {
                    if (value != null || value!.trim().isNotEmpty) {
                      _signupController.userid.value = value;
                    }
                  },
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter User ID';
                    }
                    return null;
                  },
                  icon: Icon(Icons.person),
                  label: "UserId",
                ), // UserID
                SizedBox(height: 20),
                TextInput(
                  initialValue: _signupController.username.value,
                  onSave: (value) {
                    if (value != null || value!.trim().isNotEmpty) {
                      _signupController.username.value = value;
                    }
                  },
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter User Name';
                    }
                    return null;
                  },
                  icon: Icon(Icons.person),
                  label: "User Name",
                ), // UserName
                SizedBox(height: 20),
                TextInput(
                  initialValue: _signupController.email.value,
                  onSave: (value) {
                    setState(() {
                      _signupController.email.value = value!;
                    });
                  },
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter your Email Address';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Please write proper email';
                    }
                    return null;
                  },
                  keyBoardType: TextInputType.emailAddress,
                  icon: Icon(Icons.person),
                  label: "Email",
                ), // Email
                SizedBox(height: 20),
                DatePickerWidget(), // DOB
                SizedBox(height: 20),
                GenderWidget(), // Gender
                _signupController.isSelectedGender
                    ? Container(
                        height: 0,
                      )
                    : Text(
                        "Please select Gender",
                        style: ThemeData().textTheme.bodySmall!.copyWith(
                              color: Color(0xFF8D1B01),
                            ),
                      ),
                SizedBox(height: 20),
                TextInput(
                  initialValue: _signupController.contact.value,
                  onSave: (value) {
                    _signupController.contact.value = value!;
                  },
                  onValidate: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        value.trim().length < 10) {
                      return 'Enter your Contact No';
                    }
                    return null;
                  },
                  keyBoardType: TextInputType.number,
                  icon: Icon(Icons.contacts),
                  label: "Contact No",
                ), // Contact No
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextInput(
                        controller: _signupController.addressController,
                        onSave: (value) {
                          _signupController.address.value = value!;
                        },
                        onValidate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Select Location';
                          }
                          return null;
                        },
                        icon: Icon(Icons.location_on),
                        label: "Location",
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: AppColors.blue,
                          foregroundColor: AppColors.black),
                      icon: const Icon(Icons.location_on),
                      onPressed: () {
                        _signupController.openMap();
                      },
                    ),
                  ],
                ), // Location
                SizedBox(height: 20),
                TextInput(
                  initialValue: _signupController.password.value,
                  onSave: (value) {
                    _signupController.password.value = value!;
                  },
                  onValidate: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        value.length < 6) {
                      return 'Password should have at least 6 characters';
                    }
                    return null;
                  },
                  obscureText: !_signupController.passwordVisible.value,
                  icon: Icon(Icons.password),
                  label: "Password",
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
                  initialValue: _signupController.cPassword.value,
                  obscureText: !_signupController.cPasswordVisible.value,
                  onSave: (value) {
                    _signupController.cPassword.value = value!;
                  },
                  onValidate: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        value.length < 6) {
                      return 'Password should have at least 6 characters';
                    }
                    return null;
                  },
                  icon: Icon(Icons.password),
                  label: "Confirm Password",
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
                    text: _signupController.isAuthenticating.value
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: const CircularProgressIndicator(
                              color: AppColors.white,
                            ),
                          )
                        : Text("Sign up"),
                    onClick: () {
                      setState(() {
                        _signupController.isAuthenticating.value = true;
                        _signupController.submit();
                      });
                    }), // Sign Up
                SizedBox(height: 10),
                ClickableText(
                  onClick: () {
                    Get.back();
                  },
                  text: "login_account".tr,
                ), // to Login
              ],
            ),
          ),
        ),
      ),
    );
  }
}
