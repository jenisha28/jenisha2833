import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/data/app_preference/app_preference.dart';
import 'package:social_media_app/data/dummy_data/dummy_data.dart';
import 'package:social_media_app/main.dart';
import 'package:social_media_app/model/post_model/post_model.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/res/routes/route_names.dart';
import 'package:social_media_app/utils/screen_utils.dart';
import 'package:social_media_app/view/user_view/dashboard/post_card.dart';
import 'package:social_media_app/view/user_view/profile/gallery.dart';
import 'package:social_media_app/view/user_view/profile/story_archive.dart';
import 'package:social_media_app/view_model/theme_controller/theme_controller.dart';
import 'package:social_media_app/view_model/user_view_model/dashboard_controller/dashboard_controller.dart';
import 'package:social_media_app/view_model/user_view_model/profile_controller/profile_controller.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ProfileScreen> {
  final profile = Get.put(ProfileController());
  final dashboard = Get.put(DashboardController());
  final theme = Get.put(ThemeController());

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   profile.profile();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    dashboard.currUser.value = DummyData.usersDetails[2];
    profile.postData = DummyData.postDetails
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
    List<PostModel> savedPostData = [];
    if (dashboard.savedPost.isNotEmpty) {
      for (var i in DummyData.postDetails) {
        if (dashboard.savedPost.contains(i.postId)) {
          savedPostData.add(i);
        }
      }
    }
    dashboard.storyData.assignAll(profile.storyData);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        onPressed: () {
          theme.toggleTheme();
          // Get.changeTheme(
          //   Get.isDarkMode ? Themes.lightTheme : Themes.darkTheme,
          // );
        },
        child: Get.isDarkMode
            ? Icon(Icons.light_mode, color: Colors.black)
            : Icon(Icons.dark_mode, color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 0),
                  margin: EdgeInsets.only(top: 0),
                  height: ScreenUtils.screenHeight(context) * 0.20,
                  width: ScreenUtils.screenWidth(context),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: ScreenUtils.screenHeight(context) * 0.137,
                        width: ScreenUtils.screenWidth(context),
                        child: Image.asset(
                          '${'image_path'.tr}${'p3'.tr}',
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
                          // width: ScreenUtils.screenWidth(context),
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 60,
                            foregroundImage:
                                profile.userProfile.value.isNotEmpty
                                    ? NetworkImage(
                                        profile.userProfile.value,
                                      )
                                    : AssetImage(
                                        "assets/images/profile_place_1.webp"),
                            backgroundImage: AssetImage(
                                "assets/images/profile_place_1.webp"),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.lightBlack,
                            foregroundColor: AppColors.white,
                          ),
                          onPressed: () {
                            profile.signOutFromGoogle();
                            profile.facebookSignOut();
                            firebase.signOut();
                            AppPreference.setPreference(
                                'user_preference_key'.tr, false);
                            Get.offAllNamed(RouteNames.loginScreen);
                          },
                          icon: Icon(Icons.power_settings_new),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                profile.userName.value.isNotEmpty
                    ? Text(
                        profile.userName.value,
                        // dashboard.currUser.value.username,
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    : Container(),
                const SizedBox(height: 8),
                profile.userLocation.value.isNotEmpty
                    ? Text(
                        profile.userLocation.value,
                        // dashboard.currUser.value.location,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.grey),
                      )
                    : Container(),
                const SizedBox(height: 10),
                profile.userBio.value.isNotEmpty
                    ? Text(
                        profile.userBio.value,
                        // dashboard.currUser.value.bio,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.w400),
                      )
                    : Container(),
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  width: ScreenUtils.screenWidth(context),
                  child: Row(children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteNames.followers);
                        },
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
                                '${profile.userFollowers.value}',
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
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteNames.followings);
                        },
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
                                '${profile.userFollowings.value}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: AppColors.blue,
                                        fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'followings',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          profile.currUser.value = dashboard.currUser.value;
                          Get.toNamed(RouteNames.editProfile);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Get.isDarkMode
                              ? AppColors.blueGrey
                              : AppColors.black,
                          foregroundColor: AppColors.lightGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text("Edit Profile"),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 20),
                StickyHeader(
                  header: Container(
                    height: 40,
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
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
                  content: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        if (profile.selectedMenu.value == "Posts")
                          for (var i in profile.postData)
                            PostCard(postModel: i),
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
                        if (profile.selectedMenu.value == "Saved")
                          if (savedPostData.isNotEmpty)
                            for (var i in savedPostData) PostCard(postModel: i)
                          else
                            Center(child: Text("No Data to Display")),
                        if (profile.selectedMenu.value == "Gallery")
                          Gallery(gallery: dashboard.setGallery()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
