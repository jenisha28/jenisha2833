import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:get/get.dart';
import 'package:social_media_app/data/dummy_data/dummy_data.dart';
import 'package:social_media_app/model/post_model/post_model.dart';
import 'package:social_media_app/model/users_model/users_model.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/res/routes/route_names.dart';
import 'package:social_media_app/utils/screen_utils.dart';
import 'package:social_media_app/view/user_view/dashboard/post_card.dart';
import 'package:social_media_app/view/user_view/profile/gallery.dart';
import 'package:social_media_app/view/user_view/profile/story_archive.dart';
import 'package:social_media_app/view_model/user_view_model/chat_controller/chat_controller.dart';
import 'package:social_media_app/view_model/user_view_model/dashboard_controller/dashboard_controller.dart';
import 'package:social_media_app/view_model/user_view_model/profile_controller/profile_controller.dart';

class UsersProfile extends StatefulWidget {
  const UsersProfile({super.key});

  @override
  State<UsersProfile> createState() => _UsersProfileState();
}

class _UsersProfileState extends State<UsersProfile> {
  final profile = Get.put(ProfileController());
  final dashboard = Get.put(DashboardController());
  final chat = Get.put(ChatViewModel());

  @override
  Widget build(BuildContext context) {
    List<PostModel> postData = DummyData.postDetails
        .where((e) => e.uid == dashboard.currUser.value.uid)
        .toList();

    profile.storyData = dashboard.story
        .where((e) => e.uid == dashboard.currUser.value.uid)
        .toList();

    List<PostModel> likedPostData = [];
    if (dashboard.likedPost.isNotEmpty) {
      for (var i in DummyData.postDetails) {
        if (dashboard.likedPost.contains(i.postId)) {
          likedPostData.add(i);
        }
      }
    }
    dashboard.storyData.assignAll(profile.storyData);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 0),
                margin: EdgeInsets.only(top: 0),
                height: ScreenUtils.screenHeight(context) * 0.25,
                width: ScreenUtils.screenWidth(context),
                child: Stack(
                  children: [
                    SizedBox(
                      height: ScreenUtils.screenHeight(context) * 0.18,
                      width: ScreenUtils.screenWidth(context),
                      child: Image.asset(
                        '${'image_path'.tr}${'p7'.tr}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.lightGreen,
                              AppColors.radiantBlue
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 60,
                          foregroundImage:
                              NetworkImage(dashboard.currUser.value.profImage),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: IconButton(
                        style: IconButton.styleFrom(
                            backgroundColor: Get.isDarkMode
                                ? AppColors.blueGrey
                                : AppColors.white),
                        color:
                            Get.isDarkMode ? AppColors.blue : AppColors.black,
                        onPressed: () {
                          dashboard.currUser.value = UsersModel();
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                dashboard.currUser.value.username,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                "New York",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.grey),
              ),
              const SizedBox(height: 10),
              Text(
                "Writer by profession, Artist by Passion",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                width: ScreenUtils.screenWidth(context),
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 15, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15),
                            color: Get.isDarkMode
                                ? AppColors.blueGrey
                                : AppColors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${postData.length}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: AppColors.blue,
                                        fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'posts',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.only(
                              left: 15, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15),
                            color: Get.isDarkMode
                                ? AppColors.blueGrey
                                : AppColors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${dashboard.currUser.value.followers}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: AppColors.blue,
                                        fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'followers',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.only(
                              left: 15, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15),
                            color: Get.isDarkMode
                                ? AppColors.blueGrey
                                : AppColors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${dashboard.currUser.value.following}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: AppColors.blue,
                                        fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'followers',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (profile.followRequested.value == false) {
                                    profile.followRequested.value = true;
                                  } else {
                                    profile.followRequested.value = false;
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size.fromWidth(
                                    ScreenUtils.screenWidth(context) * 0.35),
                                backgroundColor: Get.isDarkMode
                                    ? AppColors.blueGrey
                                    : AppColors.black,
                                foregroundColor: AppColors.lightGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(profile.followRequested.value
                                  ? "Requested"
                                  : "Follow"),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                chat.chatUserId.value = dashboard.currUser.value.uid;
                                print(chat.chatUserId.value);
                                Get.toNamed(RouteNames.chatScreen);
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size.fromWidth(
                                    ScreenUtils.screenWidth(context) * 0.35),
                                backgroundColor: AppColors.blue,
                                foregroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text("Message"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  FlutterImageStack(
                    imageList: profile.followersImages(),
                    showTotalCount: false,
                    totalCount: profile.images.length,
                    itemRadius: 40,
                    itemCount: 3,
                    itemBorderWidth: 3,
                  ),
                  Text(
                      'Followed by ${DummyData.usersDetails[1].username} & ${DummyData.usersDetails.length - 1}+ others'),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 40,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 10,
                    children: [
                      for (var i in profile.menuButtons)
                        if (profile.selectedMenu.value == i)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Get.isDarkMode
                                  ? AppColors.blueGrey
                                  : AppColors.black,
                              foregroundColor: Get.isDarkMode
                                  ? AppColors.lightGreen
                                  : AppColors.lightGreen,
                            ),
                            onPressed: () {
                              setState(() {
                                profile.selectedMenu.value = i;
                              });
                            },
                            child: Text(i),
                          )
                        else
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Get.isDarkMode
                                  ? AppColors.blueGrey
                                  : AppColors.white,
                              foregroundColor: Get.isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                profile.selectedMenu.value = i;
                                profile.menuButtons.remove(i);
                                profile.menuButtons.insert(0, i);
                              });
                            },
                            child: Text(
                              i,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.w400),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    if (profile.selectedMenu.value == "Posts")
                      for (var i in postData) PostCard(postModel: i),
                    if (profile.selectedMenu.value == "Stories")
                      if (profile.storyData.isNotEmpty)
                        StoryArchive()
                      else
                        Center(child: Text("No Data to Display")),
                    if (profile.selectedMenu.value == "Liked")
                      if (likedPostData.isNotEmpty)
                        for (var i in likedPostData) PostCard(postModel: i)
                      else
                        Center(child: Text("No Data to Display")),
                    if (profile.selectedMenu.value == "Tagged")
                      Center(child: Text("No Data to Display")),
                    if (profile.selectedMenu.value == "Gallery")
                      // Center(child: Text("No Data to Display")),
                      Gallery(gallery: dashboard.setGallery()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
