import 'package:flutter/material.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/utils/screen_utils.dart';

class ShadowButton extends StatefulWidget {
  const ShadowButton({
    super.key,
    required this.onClick,
    required this.assetImagePath,
    required this.text,
    this.buttonColor = AppColors.white,
    this.textColor = AppColors.black,
    this.imageColor,
  });

  final void Function() onClick;
  final String assetImagePath;
  final String text;
  final Color buttonColor;
  final Color textColor;
  final Color? imageColor;

  @override
  State<ShadowButton> createState() => _ShadowButtonState();
}

class _ShadowButtonState extends State<ShadowButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        padding: EdgeInsets.all(8),
        width: ScreenUtils.screenWidth(context) * 0.9,
        decoration: BoxDecoration(
          color: widget.buttonColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: Offset(0.0, 2),
              color: Colors.grey.shade500,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(
              widget.assetImagePath,
              height: 32,
              color: widget.imageColor,
            ),
            SizedBox(width: 20),
            Text(
              widget.text,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 17, color: widget.textColor),
            ),
          ],
        ),
      ),
    );
  }
}
