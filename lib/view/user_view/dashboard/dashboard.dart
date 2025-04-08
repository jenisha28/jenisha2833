import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/data/dummy_data/dummy_data.dart';
import 'package:social_media_app/res/routes/route_names.dart';
import 'package:social_media_app/view/user_view/chat_list/chat_list.dart';
import 'package:social_media_app/view/user_view/dashboard/post_card.dart';
import 'package:social_media_app/view/user_view/dashboard/stories.dart';
import 'package:social_media_app/view_model/user_view_model/dashboard_controller/dashboard_controller.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final dashboard = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Good Morning..",
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(RouteNames.chatList);
            },
            icon: ImageIcon(
              AssetImage('${'icon_path'.tr}${'tel'.tr}'),
              size: 30,
              color: Colors.blue,
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stories(),
            for (var i in dashboard.posts)
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: PostCard(
                  postModel: i,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
