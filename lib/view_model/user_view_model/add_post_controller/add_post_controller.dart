import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/data/dummy_data/dummy_data.dart';
import 'package:social_media_app/model/post_model/post_model.dart';
import 'package:social_media_app/model/story_model/stories_model.dart';
import 'package:social_media_app/model/story_model/story_model.dart';
import 'package:social_media_app/repository/post_repository/post_repository.dart';
import 'package:social_media_app/repository/story_repository/story_repository.dart';
import 'package:social_media_app/services/storage_services/storage_services.dart';
import 'package:social_media_app/utils/utils.dart';
import 'package:social_media_app/utils/uuid_util.dart';
import 'package:social_media_app/view_model/user_view_model/dashboard_controller/dashboard_controller.dart';

class AddPostController extends GetxController {
  final _postRepository = PostRepository();

  final story = Get.find<DashboardController>().story;
  final posts = Get.find<DashboardController>().posts;
  final users = Get.find<DashboardController>().users;
  final textPostController = TextEditingController();
  final linkController = TextEditingController();
  final textController = TextEditingController();
  File? pickedImageFile;
  List selectedFile = <File>[].obs;
  FilePickerResult? result;
  RxBool isExpanded = false.obs;
  RxBool isPost = true.obs;
  // RxBool isEmbeddedText = false.obs;
  RxBool showLinkBox = false.obs;
  RxBool isSending = false.obs;

  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 150,
        maxHeight: 150);
    if (pickedImage == null) {
      return;
    }
    pickedImageFile = File(pickedImage.path);
  }

  Future<void> takePicture() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 150,
        maxHeight: 150);
    if (pickedImage == null) {
      return;
    }
    pickedImageFile = File(pickedImage.path);
  }

  Future<void> sendPost() async {
    if (textPostController.text.isNotEmpty || selectedFile.isNotEmpty) {
      isSending.value = true;

      List<String> imageUrl =
          await StorageServices().uploadPostImages(selectedFile);

      PostModel postModel = PostModel(
        uid: "3",
        postText: textPostController.text,
        postTime: DateTime.now().toString(),
        postImage: imageUrl,
        postId: {posts.length + 1}.toString(),
        likes: 0,
        postComments: [],
        share: 0,
      );

      // await _postRepository.addPost(postModel);
      posts.insert(0, postModel);
      Utils.toastMessage("Post added Successfully");
      selectedFile.clear();
      textPostController.clear();
      isSending.value = false;
    }
  }

  StoryModel getStory(String uid) {
    int storyIndex = story.indexWhere((s) => s.uid == uid);
    return story[storyIndex];
  }

  Future<void> sendStory() async {
    try {
      if (textPostController.text.isNotEmpty || selectedFile.isNotEmpty) {
        isSending.value = true;

        List<String> imageUrl =
            await StorageServices().uploadPostImages(selectedFile);

        StoryModel s = StoryModel();
        int storyIndex = 0;
        for (int i = 0; i < story.length; i++) {
          if (story[i].uid == '3') {
            print('StoryID: ${story[i].storyId}');
            s = story[i];
            storyIndex = i;
          }
        }

        if (s.storyId != '') {
          if (textPostController.text != '') {
            s.storyText.insert(0, textPostController.text);
          }
          for (var i in imageUrl) {
            s.storyImg.insert(0, i);
          }
          s.storyTime = DateTime.now().toString();
          story[storyIndex] = s;
          Utils.toastMessage("Story added Successfully");
        } else {
          StoryModel storyModel = StoryModel(
            uid: "3",
            storyText: [textPostController.text],
            storyTime: DateTime.now().toString(),
            storyImg: imageUrl,
            storyId: {story.length + 1}.toString(),
            viewers: 0,
            storyLikes: 0,
          );
          story.insert(0, storyModel);
          Utils.toastMessage("Story added Successfully");
        }

        selectedFile.clear();
        textPostController.clear();
        isSending.value = false;
      }
      isSending.value = false;
    } on Exception catch (error) {
      print(error);
      isSending.value = false;
    }
  }

  Future<void> addStory() async {
    try {
      if (textPostController.text.isNotEmpty || selectedFile.isNotEmpty) {
        isSending.value = true;

        List<String> imageUrl =
            await StorageServices().uploadPostImages(selectedFile);

          if (textPostController.text.isNotEmpty) {
            StoriesModel storiesModel = StoriesModel(
              storyId: (DummyData.storiesDetails['3'] != null ? DummyData.storiesDetails['3']!.length : 0 + 1).toString(),
              storyText: textPostController.text,
              storyTime: DateTime.now().toString(),
              viewers: 0,
              storyLikes: 0,
            );
            if (DummyData.storiesDetails['3'] != null) {
              DummyData.storiesDetails['3']!.insert(0, storiesModel);
            } else {
              DummyData.storiesDetails['3'] = [];
              DummyData.storiesDetails['3']!.insert(0, storiesModel);
            }
          }
          if (imageUrl.isNotEmpty) {
            for (var i in imageUrl) {
              StoriesModel storiesModel = StoriesModel(
                storyId: (DummyData.storiesDetails['3'] != null ? DummyData.storiesDetails['3']!.length : 0 + 1).toString(),
                storyImg: i,
                storyTime: DateTime.now().toString(),
                viewers: 0,
                storyLikes: 0,
              );
              if (DummyData.storiesDetails['3'] != null) {
                DummyData.storiesDetails['3']!.insert(0, storiesModel);
              } else {
                DummyData.storiesDetails['3'] = [];
                DummyData.storiesDetails['3']!.insert(0, storiesModel);
              }
            }
          }
          Utils.toastMessage("Story added Successfully");


        selectedFile.clear();
        textPostController.clear();
        isSending.value = false;
      }
      isSending.value = false;
    } on Exception catch (error) {
      print(error);
      isSending.value = false;
    }
  }
}
