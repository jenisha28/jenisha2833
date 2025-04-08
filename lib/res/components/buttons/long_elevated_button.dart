import 'package:flutter/material.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/utils/screen_utils.dart';

class LongElevatedButton extends StatefulWidget {
  const LongElevatedButton(
      {super.key,
      required this.text,
      required this.onClick,
      this.foregroundColor = AppColors.white,
      this.backgroundColor = AppColors.blue,
      });

  final Widget text;
  final void Function() onClick;
  final Color foregroundColor;
  final Color backgroundColor;

  @override
  State<LongElevatedButton> createState() => _LongElevatedButtonState();
}

class _LongElevatedButtonState extends State<LongElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtils.screenWidth(context) * 0.9,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          foregroundColor: widget.foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: widget.onClick,
        child: widget.text,
      ),
    );
  }
}
