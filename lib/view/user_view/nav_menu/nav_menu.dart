import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/view_model/theme_controller/theme_controller.dart';
import 'package:social_media_app/view_model/user_view_model/nav_bar_view_model/nav_bar_view_model.dart';
import 'package:social_media_app/view_model/user_view_model/profile_controller/profile_controller.dart';

class NavMenu extends StatefulWidget {
  const NavMenu({super.key});

  @override
  State<NavMenu> createState() => _NsvMenuState();
}

class _NsvMenuState extends State<NavMenu> {
  final navbar = Get.put(NavBarViewModel());
  final theme = Get.put(ThemeController());
  final profile = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    profile.profile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navbar.buildScreens[navbar.currentPageIndex.value],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Obx(
          () => BottomNavigationBar(
            selectedLabelStyle: TextStyle(fontSize: 10, color: AppColors.black),
            elevation: 10,
            backgroundColor: theme.isDarkMode.value ? AppColors.blue : AppColors.white,
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(color: AppColors.black),
            unselectedIconTheme: IconThemeData(color: AppColors.black),
            selectedItemColor: AppColors.black,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 26.5),
                label: '●',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 28),
                label: '●',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.add, color: Colors.white),
                ),
                label: "●",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications, size: 28),
                label: '●',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 28),
                label: '●',
              ),
            ],
            currentIndex: navbar.currentPageIndex.value,
            onTap: (index) {
              setState(() {
                navbar.currentPageIndex.value = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
