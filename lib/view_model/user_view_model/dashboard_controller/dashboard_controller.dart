import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_media_app/model/post_model/post_model.dart';
import 'package:social_media_app/model/users_model/users_model.dart';
import 'package:social_media_app/repository/post_repository/post_repository.dart';
import 'package:social_media_app/repository/story_repository/story_repository.dart';
import 'package:social_media_app/repository/user_repository/user_repository.dart';

class DashboardController extends GetxController {
  final users = UserRepository.getUsers();
  final story = StoryRepository.getStories();
  final posts = PostRepository.getPosts();
  final commentController = TextEditingController();
  final currTime = DateTime.now();
  final currStoryIndex = 0.obs;
  List storyData = [];
  PostModel currPost = PostModel();
  final isSorted = false.obs;
  final currUser = UsersModel().obs;

  final likedPost = [].obs;
  final savedPost = [].obs;
  final likedComments = [].obs;
  List gallery = [];
  List sortedComments = <PostComment>[].obs;

  void onShare(BuildContext context, String text) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(text,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  Future<List<ConnectivityResult>> checkConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    return connectivityResult;
  }

  void bookmark(String postId) {
    if (savedPost.contains(postId)) {
      savedPost.remove(postId);
    } else {
      savedPost.add(postId);
    }
  }

  void likePost(String postId, int likes) {
    if (likedPost.contains(postId)) {
      likedPost.remove(postId);
      likes--;
    } else {
      likedPost.add(postId);
      likes++;
    }
  }

  String postTime(String pTime) {
    DateTime t = DateTime.parse(pTime);
    Duration timeData = currTime.difference(t);
    if (timeData.inSeconds < 60) {
      return "Just Now";
    } else if (timeData.inMinutes < 60) {
      return "${timeData.inMinutes} minutes ago";
    } else if (timeData.inHours < 24) {
      return "${timeData.inHours} hours ago";
    } else if (timeData.inDays < 31) {
      return "${timeData.inDays} day ago";
    } else if (timeData.inDays < 365) {
      return "${(timeData.inDays / 31).toString().split('.')[0]} month ago";
    } else {
      return "${(timeData.inDays / 365).toString().split('.')[0]} year ago";
    }
  }

  void sortCommentsDesc() {
    sortedComments = currPost.postComments.map((cmt) => cmt).toList()
      ..sort((a, b) => a.cmtTime.compareTo(b.cmtTime));
  }

  void sortCommentsAsc() {
    sortedComments = currPost.postComments.map((cmt) => cmt).toList()
      ..sort((a, b) => b.cmtTime.compareTo(a.cmtTime));
  }

  void getImageSize(String imagePath) async {
    final buffer = await rootBundle.load(imagePath); // get the byte buffer
    final memoryImageSizeResult =
        ImageSizeGetter.getSizeResult(MemoryInput.byteBuffer(buffer.buffer));
    final size = memoryImageSizeResult.size;
    if (kDebugMode) {
      print('size = $size');
    }
  }

  UsersModel getUser(String uid) {
    int userIndex = users.indexWhere((e) => e.uid == uid);
    return users[userIndex];
  }

  List setGallery() {
    if (currUser.value.uid == '') {
      currUser.value = users[2];
    } else {
      gallery = [];
      List<PostModel> postData =
          posts.where((e) => e.uid == currUser.value.uid).toList();

      for (var i in postData) {
        if (i.postImage.isNotEmpty) {
          for (var j in i.postImage) {
            gallery.add(j);
          }
        }
      }
    }
    return gallery;
  }
}
