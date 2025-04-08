import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/view/user_view/add_post_screen/add_post_screen.dart';
import 'package:social_media_app/view/user_view/alerts_screen/alerts_screen.dart';
import 'package:social_media_app/view/user_view/dashboard/dashboard.dart';
import 'package:social_media_app/view/user_view/profile/profile_screen.dart';
import 'package:social_media_app/view/user_view/search_screen/search_screen.dart';


class NavBarViewModel extends  GetxController {
  RxInt currentPageIndex = 0.obs;
  List<Widget> buildScreens = [
    Dashboard(),
    SearchScreen(),
    AddPostScreen(),
    AlertsScreen(),
    ProfileScreen()
  ].obs;
}