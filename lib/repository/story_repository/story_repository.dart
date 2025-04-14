
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:social_media_app/data/dummy_data/dummy_data.dart';
import 'package:social_media_app/main.dart';
import 'package:social_media_app/model/story_model/story_model.dart';
import 'package:social_media_app/utils/utils.dart';
import 'package:social_media_app/utils/uuid_util.dart';

class StoryRepository {
  static List<StoryModel> getStories() {
    List<StoryModel> stories = DummyData.storyDetails;
    return stories;
  }

  Future<void> addStory(StoryModel storyModel) async {
    try {
      String uid = firebase.currentUser!.uid;

      DocumentReference ref = FirebaseFirestore.instance
          .collection("Social Media App")
          .doc(uid)
          .collection("Stories")
          .doc(UuidUtil.uuid.toString());

      await ref.set(storyModel.toJson());

      Utils.toastMessage("Story added Successfully");
    } on Exception catch (error) {
      log('"Authentication Exception", $error');
      Get.snackbar("Something Went Wrong", "Failed to add Story, Please Retry");
    }
  }
}