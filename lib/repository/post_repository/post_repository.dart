import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:social_media_app/data/dummy_data/dummy_data.dart';
import 'package:social_media_app/main.dart';
import 'package:social_media_app/model/post_model/post_model.dart';
import 'package:social_media_app/services/firestore_services/firestore_services.dart';

class PostRepository {

  final _firestoreService = FirestoreServices();

  static List<PostModel> getPosts() {
    List<PostModel> posts = DummyData.postDetails;
    return posts;
  }

  static String uid = firebase.currentUser!.uid;

  final post = FirebaseFirestore.instance
      .collection("Social Media App")
      .doc(uid)
      .collection("Posts");

  Stream<List<PostModel>> getAllPosts() {
    return _firestoreService.getAllPost();
  }
  Future<PostModel> getPost(String postId) async {
    return await _firestoreService.getPost(postId);
  }


  Future<void> addPost(PostModel postModel) async {
    try {
      await _firestoreService.addPost(postModel);
    } on Exception catch (error) {
      log('"Authentication Exception", $error');
      Get.snackbar("Something Went Wrong", "Failed to add Post, Please Retry");
    }
  }

  Future<void> addComment(String postId, PostComment postComment) async {
    try {
      await _firestoreService.addComment(postId, postComment);
    } on Exception catch (error) {
      log('"Authentication Exception", $error');
      Get.snackbar(
          "Something Went Wrong", "Failed to add Comment, Please Retry");
    }
  }

  Stream<List<PostComment>> getAllComments(String postId) { // TODO: Need to Work
    // print(_firestoreService.getAllComments(postId));
    return _firestoreService.getAllComments(postId);
  }
}
