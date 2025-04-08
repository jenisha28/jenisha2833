
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:social_media_app/utils/screen_utils.dart';
import 'package:social_media_app/view_model/user_view_model/dashboard_controller/dashboard_controller.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key, required this.gallery});
  final List gallery;

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  final dashboard = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    if (widget.gallery.isEmpty) {
      return Center(child: Text("No Data to Display"));
    } else {
      return Container(
        padding: EdgeInsets.all(20),
        height: ScreenUtils.screenHeight(context) * 0.9,
        child: MasonryGridView.builder(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: widget.gallery.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.gallery[index],
                  scale: 1,
                  fit: BoxFit.cover,
                ),
              );
            }),
      );
    }
  }
}