import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/view/user_view/dashboard/dots_indicator/dots_decorator.dart';
import 'package:social_media_app/view/user_view/dashboard/dots_indicator/dots_indicator.dart';

class CarouselSlider extends StatefulWidget {
  const CarouselSlider({super.key, required this.images});

  final List images;

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  int imagePos = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: PageController(
                viewportFraction: 0.9,
                initialPage: 0,
              ),
              onPageChanged: (int value) {
                setState(() {
                  imagePos = value;
                });
              },
              children: List.generate(
                widget.images.length,
                (index) => Card(
                  color: Get.isDarkMode ? AppColors.black : AppColors.white,
                  margin: EdgeInsets.only(left: 7, right: 7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: widget.images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          widget.images.length > 1
              ? DotsIndicator(
                  dotsCount: widget.images.length,
                  position: imagePos.toDouble(),
                  decorator: DotsDecorator(activeColor: AppColors.blue),
                  fadeOutLastDot: true,
                  fadeOutDistance: 2,
                )
              : Container(),
        ],
      ),
    );
  }
}
