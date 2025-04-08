import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:social_media_app/main.dart';
import 'package:social_media_app/model/post_model/post_model.dart';
import 'package:social_media_app/model/users_model/users_model.dart';
import 'package:social_media_app/utils/uuid_util.dart';

class FirestoreServices {
  static final String _uid = firebase.currentUser!.uid;

  static final users = FirebaseFirestore.instance.collection("Users");
  static final post = FirebaseFirestore.instance
      .collection("Social Media App")
      .doc(_uid)
      .collection("Posts");

  // Handle Users.....
  Future<void> addUser(UsersModel userModel) async {
    try {
      return await users.doc(_uid).set(userModel.toJson());
    } on Exception catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    }
  }

  Future getUser(String uid) async {
    try {
      DocumentSnapshot snapshot = await users.doc(uid).get();
      if (snapshot.exists) {
        return UsersModel.fromJson(snapshot as Map<String, dynamic>);
      }
      return snapshot.data();
    } on Exception catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    }
  }

  // Handle Posts.....
  Future<void> addPost(PostModel postModel) async {
    try {
      return await post.doc(UuidUtil.uuid.toString()).set(postModel.toJson());
    } on Exception catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    }
  }

  Future<PostModel> getPost(String postId) async {
    try {
      DocumentSnapshot data = await post.doc(postId).get();
      if (data.exists) {
        PostModel post =
            PostModel.fromJson(data.data() as Map<String, dynamic>);
        return post;
      }
    } on Exception catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    }
    return PostModel();
  }

  Stream<List<PostModel>> getAllPost() {
    var data = post.snapshots().map((snapshot) =>
        snapshot.docs.map((post) => PostModel.fromJson(post.data())).toList());
    return data;
  }

  // Comments Handling
  Future<void> addComment(String postId, PostComment postComment) async {
    try {
      return await post.doc(postId).set({
        'postComments': FieldValue.arrayUnion([postComment.toJson()]),
      }, SetOptions(merge: true));
    } on Exception catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    }
  }

  Stream<List<PostComment>> getAllComments(String postId) {
    List<PostComment> postComments = [];
    var data = post.snapshots().map((snapshot) => snapshot.docs
        .where((post) => post.id == postId)
        .map((p) => PostComment.fromJson(p.data()))
        .toList());
    // var b = data.map((e) => e.where((f) => f.cmtText.isNotEmpty));
    // print(b.where((test) => test.isNotEmpty));

    data.listen((onData) {
      for (PostComment i in onData) {
        print(i);
        postComments.add(i);
      }
      print(postComments[0].cmtText);
    });

    return data;
  }
}
