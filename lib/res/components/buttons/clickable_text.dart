import 'package:flutter/material.dart';
import 'package:social_media_app/res/colors/app_colors.dart';

class ClickableText extends StatefulWidget {
  const ClickableText({
    super.key,
    required this.onClick,
    required this.text,
    this.textColor = AppColors.black,
    this.fontWeight = FontWeight.w500, this.textAlign,
  });

  final void Function() onClick;
  final String text;
  final Color textColor;
  final FontWeight fontWeight;
  final TextAlign? textAlign;

  @override
  State<ClickableText> createState() => _ClickableTextState();
}

class _ClickableTextState extends State<ClickableText> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Text(
        widget.text,
        style: TextStyle(color: widget.textColor),
        textAlign: widget.textAlign,
      ),
    );
  }
}
