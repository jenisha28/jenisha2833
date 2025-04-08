import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/view_model/auth_view_model/signup_controller/signup_controller.dart';

class GenderWidget extends StatefulWidget {
  const GenderWidget({super.key});

  @override
  State<GenderWidget> createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  final _signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( left: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "${'gender'.tr}:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Row(
                children: [
                  for (var a in Gender.values)
                    Row(
                      children: [
                        Radio(
                            activeColor: AppColors.blue,
                            value: a,
                            groupValue: _signupController.selectedGender,
                            onChanged: (val) {
                              setState(() {
                                _signupController.selectedGender = val;
                              });
                            }),
                        Text(
                          '${a.name[0].toUpperCase()}${a.name.substring(1)}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
