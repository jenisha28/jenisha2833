import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/data/dummy_data/dummy_data.dart';
import 'package:social_media_app/res/colors/app_colors.dart';

class Followers extends StatelessWidget {
  const Followers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Followers"),
      ),
      body: Column(
        children: [
          for (var user in DummyData.usersDetails)
            Card(
              color: Get.isDarkMode ? AppColors.blueGrey : Colors.white,
              child: ListTile(
                title: Text(user.username),
                leading: CircleAvatar(
                  foregroundImage: NetworkImage(user.profImage),
                ),
                trailing: ElevatedButton(onPressed: () {}, child: Text("Remove")),
              ),
            ),
        ],
      ),
    );
  }
}
