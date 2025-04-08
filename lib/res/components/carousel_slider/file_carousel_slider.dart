import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/view/user_view/dashboard/dots_indicator/dots_indicator.dart';

class FileCarouselSlider extends StatefulWidget {
  const FileCarouselSlider({super.key, required this.fileImages});

  final List fileImages;

  @override
  State<FileCarouselSlider> createState() => _FileCarouselSliderState();
}

class _FileCarouselSliderState extends State<FileCarouselSlider> {
  int imagePos = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: Obx(
        () => Column(
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (int value) {
                  setState(() {
                    imagePos = value;
                  });
                },
                children: List.generate(
                  widget.fileImages.length,
                  (index) => Stack(alignment: Alignment.center, children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        widget.fileImages[index],
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.fileImages.remove(widget.fileImages[index]);
                            imagePos--;
                          });
                        },
                        child: Icon(
                          Icons.cancel_rounded,
                          size: 27,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            widget.fileImages.length > 1
                ? DotsIndicator(
                    dotsCount: widget.fileImages.length,
                    position: imagePos.toDouble(),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
