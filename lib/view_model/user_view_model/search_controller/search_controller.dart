import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:social_media_app/data/dummy_data/dummy_data.dart';
import 'package:social_media_app/model/post_model/post_model.dart';
import 'package:social_media_app/model/users_model/users_model.dart';
import 'package:social_media_app/view_model/user_view_model/dashboard_controller/dashboard_controller.dart';

class SearchViewModel extends GetxController {
  final users = Get.find<DashboardController>().users;
  final posts = Get.find<DashboardController>().posts;
  final searchController = TextEditingController();
  final selectedType = "All".obs;
  final searchTypes = [
    "All",
    "Posts",
    "Profile",
    "Photos",
    "Trending",
    "Videos",
  ].obs;

  setGallery() {
    List galleryList = [];
    for (var post in posts) {
      if (post.postImage.isNotEmpty) {
        galleryList.addAll(post.postImage);
      }
    }
    return galleryList;
  }

  UsersModel getUser(String uid) {
    int userIndex = users.indexWhere((e) => e.uid == uid);
    return users[userIndex];
  }

  final userSearchResult = DummyData.usersDetails.obs;
  // final userSearchResult = <UsersModel>[].obs;
  final postSearchResult = DummyData.postDetails.obs;
  // final postSearchResult = <PostModel>[].obs;
  final userSearch = <UsersModel>[].obs;
  final postSearch = <PostModel>[].obs;

  Future<List<UsersModel>> searchUser(String searchInput) async {
    userSearch.assignAll(users.where((user) =>
        user.username
            .toString()
            .toLowerCase()
            .contains(searchInput.toLowerCase()) ||
        user.bio.toString().toLowerCase().contains(searchInput.toLowerCase()) ||
        user.location
            .toString()
            .toLowerCase()
            .contains(searchInput.toLowerCase())));
    return userSearch;
  }

  Future<List<PostModel>> searchPost(String searchInput) async {
    postSearch.assignAll(posts.where((post) => post.postText
            .toString()
            .toLowerCase()
            .contains(searchInput.toLowerCase())
        || getUser(post.uid).username.toLowerCase().contains(searchInput.toLowerCase())
        // || post.postComments.map((cmt) => cmt.cmtText.toLowerCase().contains(searchInput.toLowerCase()))  ||
        // post.postImage.toString().toLowerCase().contains(searchInput.toLowerCase())
        ));
    return postSearch;
  }
}
