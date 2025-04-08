import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/res/routes/route_names.dart';
import 'package:social_media_app/view_model/user_view_model/dashboard_controller/dashboard_controller.dart';
import 'package:social_media_app/view_model/user_view_model/search_controller/search_controller.dart';

class ProfilesList extends StatelessWidget {
  ProfilesList({super.key});

  final currUser = Get.find<DashboardController>().currUser;
  final search = Get.put(SearchViewModel());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(search.userSearchResult.isNotEmpty)
        for(var user in search.userSearchResult)
          Card(
            color: Get.isDarkMode ? AppColors.blueGrey : Colors.white,
            child: ListTile(
              onTap: () {
                currUser.value = user;
                Get.toNamed(RouteNames.usersProfile);
              },
              title: Text(user.username),
              subtitle: Text(user.bio),
              leading: CircleAvatar(foregroundImage: NetworkImage(user.profImage),),
            ),
          )
        else
          Center(child: Text("Nothing to display"),)
      ],
    );
  }
}
