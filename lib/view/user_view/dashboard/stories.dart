import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/res/routes/route_names.dart';
import 'package:social_media_app/utils/screen_utils.dart';
import 'package:social_media_app/view_model/user_view_model/dashboard_controller/dashboard_controller.dart';

class Stories extends StatefulWidget {
  const Stories({super.key});

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  final dashboard = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          padding: EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Get.isDarkMode ? AppColors.blueGrey : AppColors.white,
          ),
          child: Row(
            children: [
              Stack(
                fit: StackFit.passthrough,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.white,
                    foregroundImage:
                    AssetImage('${'image_path'.tr}${'prof_place'.tr}'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColors.black,
                      foregroundImage:
                      AssetImage('${'icon_path'.tr}${'add'.tr}'),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              for (int i = 0; i < dashboard.story.length; i++)
                GestureDetector(
                  onTap: () {
                    dashboard.storyData.assignAll(dashboard.story);
                    dashboard.currStoryIndex.value = i;
                    Get.toNamed(RouteNames.storyScreen);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 3, color: AppColors.green),
                    ),
                    margin: EdgeInsets.only(left: 5, right: 5),
                    child: CircleAvatar(
                      radius: 30,
                      foregroundImage: NetworkImage(dashboard
                          .getUser(dashboard.story[i].uid)
                          .profImage),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
