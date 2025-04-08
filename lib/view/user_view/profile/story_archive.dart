import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/routes/route_names.dart';
import 'package:social_media_app/view_model/user_view_model/dashboard_controller/dashboard_controller.dart';
import 'package:social_media_app/view_model/user_view_model/profile_controller/profile_controller.dart';

class StoryArchive extends StatefulWidget {
  const StoryArchive({super.key});

  @override
  State<StoryArchive> createState() => _StoryArchiveState();
}

class _StoryArchiveState extends State<StoryArchive> {
  final dashboard = Get.put(DashboardController());
  final profile = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        alignment: WrapAlignment.start,
        children: [
          for (int i = 0; i < dashboard.storyData.length; i++)
            GestureDetector(
              onTap: () {
                dashboard.storyData.assignAll(profile.storyData);
                dashboard.currStoryIndex.value = i;
                Get.toNamed(RouteNames.storyScreen);
              },
              child: Container(
                height: 160,
                width: 160,
                margin: EdgeInsets.all(10),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        dashboard.storyData[i].storyImg[0],
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Positioned(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              colors: [
                                Color(0x6FFFFFFF),
                                Color(0x54000000),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
