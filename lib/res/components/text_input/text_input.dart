import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/colors/app_colors.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    this.initialValue,
    this.onSave,
    this.onValidate,
    this.icon,
    this.label,
    this.keyBoardType = TextInputType.text,
    this.obscureText = false,
    this.controller,
    this.suffixIcon,
    this.onTap,
  });

  final String? initialValue;
  final TextEditingController? controller;
  final Icon? icon;
  final String? label;
  final TextInputType? keyBoardType;
  final bool obscureText;
  final void Function(String? value)? onSave;
  final String? Function(String? value)? onValidate;
  final void Function()? onTap;
  final Widget? suffixIcon;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUnfocus,
      cursorColor: AppColors.blue,
      initialValue: widget.initialValue,
      controller: widget.controller,
      keyboardAppearance: Get.isDarkMode ? Brightness.dark : Brightness.light,
      decoration: InputDecoration(
        filled: true,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.red, width: 0.8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.blue, width: 2),
        ),
        fillColor: AppColors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.blue, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.blue, width: 1),
        ),
        prefixIconColor: AppColors.blue,
        prefixIcon: widget.icon,
        labelText: widget.label,
        labelStyle: TextStyle(color: AppColors.blue),
        suffixIcon: widget.suffixIcon,
      ),
      keyboardType: widget.keyBoardType,
      validator: widget.onValidate,
      onSaved: widget.onSave,
      obscureText: widget.obscureText,
      onTap: widget.onTap,
    );
  }
}
