import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:social_media_app/main.dart';
import 'package:social_media_app/model/post_model/post_model.dart';
import 'package:social_media_app/model/story_model/story_model.dart';
import 'package:social_media_app/model/users_model/users_model.dart';
import 'package:social_media_app/repository/user_repository/user_repository.dart';

class ProfileController extends GetxController {
  final users = UserRepository.getUsers();
  final usernameController = TextEditingController();
  final bioController = TextEditingController();
  final locationController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  RxBool isLoading = false.obs;

  List<String> images = [];

  List<String> followersImages() {
    List<String> data = [];
    for (var i in users) {
      data.add(i.profImage);
    }
    images.assignAll(data);
    return images;
  }

  RxString userId = ''.obs;
  RxString userName = ''.obs;
  RxString userEmail = ''.obs;
  RxString userDob = ''.obs;
  RxString userGender = ''.obs;
  RxString userContact = ''.obs;
  RxString userBio = ''.obs;
  RxInt userFollowers = 0.obs;
  RxInt userFollowings = 0.obs;
  RxString userProfile = ''.obs;
  RxString userLocation = ''.obs;

  final RxBool followRequested = false.obs;
  final currUser = UsersModel().obs;

  RxString pickedImageFile = ''.obs;
  File? selectImage;

  final selectedMenu = "Posts".obs;
  List<StoryModel> storyData = [];
  List<PostModel> postData = [];

  final menuButtons = [
    "Posts",
    "Stories",
    "Liked",
    "Saved",
    "Gallery",
  ].obs;

  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 150,
        maxHeight: 150);
    if (pickedImage == null) {
      return;
    }
    pickedImageFile.value = pickedImage.path;
  }

  Future<void> profile() async {
    try {
      String uid = firebase.currentUser!.uid;
      final snapshot = await databaseRef.child(uid).get();

      if (!snapshot.exists) {
        return;
      }

      dynamic user = snapshot.value as Map;
      userId.value = user['userid_key'.tr] ?? '';
      userName.value = user['username_key'.tr] ?? '';
      userEmail.value = user['email_key'.tr] ?? '';
      userDob.value = user['dob_key'.tr] ?? '';
      userGender.value = user['gender_key'.tr] ?? '';
      userContact.value = user['contact_key'.tr] ?? '';
      userBio.value = user['bio_key'.tr] ?? '';
      userFollowers.value = user['followers_key'.tr] ?? 0;
      userFollowings.value = user['followings_key'.tr] ?? 0;
      userProfile.value = user['prof_img_key'.tr] ?? '';
      userLocation.value = user['location_key'.tr] ?? '';
    } on FirebaseAuthException catch (error) {
      Get.snackbar(
          "Error in Authentication", error.message ?? 'auth_failed'.tr);
    }
  }

  void openMap(BuildContext context) {
    Get.to(MapLocationPicker(
      hideMapTypeButton: true,
      backButton: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back),
      ),
      apiKey: "AIzaSyCsBj_Q4IFt8Jbs6iS1R43DQUDE7zuHG-Y",
      popOnNextButtonTaped: true,
      currentLatLng: const LatLng(21.183509, 72.783102),
      debounceDuration: const Duration(milliseconds: 500),
      onNext: (GeocodingResult? result) {
        if (result != null) {
          locationController.text = result
              .addressComponents[result.addressComponents.length - 4].longName;
        }
      },
    ));
  }

  Future<void> facebookSignOut() async {
    await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<void> updateProfile() async {
    isLoading.value = true;
    String uid = firebase.currentUser!.uid;

    String imageUrl = '';

    if (pickedImageFile.value.isNotEmpty) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('users_profile')
          .child('${firebase.currentUser!.uid}.jpg');

      await storageRef.putFile(File(pickedImageFile.value));
      imageUrl = await storageRef.getDownloadURL();
    }

    await databaseRef.child(uid).update(<String, dynamic>{
      'username_key'.tr: usernameController.text,
      'email_key'.tr: emailController.text,
      'contact_key'.tr: contactController.text,
      'location_key'.tr: locationController.text,
      'bio_key'.tr: bioController.text,
      'prof_img_key'.tr: imageUrl,
    });
    isLoading.value = false;
    profile();
    Get.back();
  }
}
