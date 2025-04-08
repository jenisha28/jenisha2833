import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/data/dummy_data/dummy_data.dart';
import 'package:social_media_app/model/users_model/users_model.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/utils/screen_utils.dart';
import 'package:social_media_app/view/user_view/dashboard/post_card.dart';
import 'package:social_media_app/view/user_view/profile/gallery.dart';
import 'package:social_media_app/view/user_view/search_screen/profiles_list.dart';
import 'package:social_media_app/view_model/user_view_model/search_controller/search_controller.dart';
import 'package:sticky_headers/sticky_headers.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final search = Get.put(SearchViewModel());

  @override
  Widget build(BuildContext context) {
    // DummyData.postDetails.shuffle();
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: ScreenUtils.screenHeight(context),
          width: ScreenUtils.screenWidth(context),
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      onChanged: (value) async {
                        if (value.isEmpty) {
                          search.userSearchResult
                              .assignAll(DummyData.usersDetails);
                          search.postSearchResult
                              .assignAll(DummyData.postDetails);
                        } else {
                          search.userSearchResult
                              .assignAll(await search.searchUser(value));
                          search.postSearchResult
                              .assignAll(await search.searchPost(value));
                        }
                      },
                      controller: search.searchController,
                      style: TextStyle(color: AppColors.black),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Get.isDarkMode
                                  ? AppColors.blueGrey
                                  : AppColors.white,
                              width: 3,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Get.isDarkMode
                                  ? AppColors.blueGrey
                                  : AppColors.white,
                              width: 3,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        filled: true,
                        fillColor: Get.isDarkMode
                            ? AppColors.blueGrey
                            : AppColors.white,
                        hintText: "Search for Person, Photos, Posts..",
                        suffixIconColor:
                            Get.isDarkMode ? AppColors.grey : AppColors.black,
                        suffixIcon: IconButton(
                          onPressed: () {
                            search.searchUser(search.searchController.text);
                          },
                          icon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Popular",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  StickyHeader(
                    header: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? AppColors.blueGrey
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          spacing: 10,
                          children: [
                            for (var i in search.searchTypes)
                              if (search.selectedType.value == i)
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Get.isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    foregroundColor: Get.isDarkMode
                                        ? AppColors.black
                                        : AppColors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      search.selectedType.value = i;
                                    });
                                  },
                                  child: Text(i),
                                )
                              else
                                OutlinedButton(
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
                                      search.selectedType.value = i;
                                    });
                                  },
                                  child: Text(
                                    i,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ),
                    content: Column(
                      children: [
                        if (search.selectedType.value == "All")
                          Column(
                            children: [
                              for (var i in search.postSearchResult)
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  child: PostCard(
                                    postModel: i,
                                  ),
                                ),
                              Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  child: ProfilesList()),
                            ],
                          ),
                        if (search.selectedType.value == "Posts")
                          if (search.postSearchResult.isNotEmpty)
                            for (var i in search.postSearchResult)
                              Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: PostCard(
                                  postModel: i,
                                ),
                              )
                          else
                            Center(
                              child: Text("Nothing to Display"),
                            ),
                        if (search.selectedType.value == "Profile")
                          Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: ProfilesList()),
                        if (search.selectedType.value == "Photos")
                          Gallery(gallery: search.setGallery()),
                        if (search.selectedType.value == "Trending")
                          Center(
                            child: Text("Nothing to display"),
                          ),
                        if (search.selectedType.value == "Videos")
                          Center(
                            child: Text("Nothing to display"),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
