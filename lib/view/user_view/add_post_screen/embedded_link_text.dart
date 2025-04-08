import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/view_model/user_view_model/add_post_controller/add_post_controller.dart';

class EmbeddedLinkText extends StatefulWidget {
  const EmbeddedLinkText({super.key});

  @override
  State<EmbeddedLinkText> createState() => _EmbeddedLinkTextState();
}

class _EmbeddedLinkTextState extends State<EmbeddedLinkText> {
  final addPost = Get.put(AddPostController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            controller: addPost.linkController,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              hintText: "Enter Url",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: addPost.textController,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              hintText: "Enter Text",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  foregroundColor: AppColors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () {},
                child: Text("Add link"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
