import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/res/components/text_input/text_input.dart';
import 'package:social_media_app/view_model/auth_view_model/signup_controller/signup_controller.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  final _signupController = Get.put(SignupController());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _signupController.selectedDate,
        firstDate: DateTime(1930, 8),
        lastDate: DateTime(2026));
    if (picked != null && picked != _signupController.selectedDate) {
      setState(() {
        _signupController.selectedDate = picked;
        _signupController.dateController.text =
            '${_signupController.selectedDate.toLocal()}'.split(' ')[0];
        print(_signupController.dateController.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextInput(
      controller: _signupController.dateController,
      onValidate: (value) {
        if (value == null ||
            value.trim().isEmpty ||
            value == DateTime.now().toString()) {
          return "Please select your Date of Birth";
        }
        return null;
      },
      icon: Icon(
        Icons.calendar_month,
      ),
      label: "dob".tr,
      onTap: () {
        _selectDate(context);
        print('date: ${_signupController.dateController.text}');
      },
      onSave: (value) {
        _signupController.dob.value = value!;
      },
    );
  }
}
