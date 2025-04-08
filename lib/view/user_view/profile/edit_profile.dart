// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/data/dummy_data/dummy_data.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/res/components/buttons/long_elevated_button.dart';
import 'package:social_media_app/res/components/text_input/text_input.dart';
import 'package:social_media_app/res/routes/route_names.dart';
import 'package:social_media_app/utils/screen_utils.dart';
import 'package:social_media_app/view_model/user_view_model/profile_controller/profile_controller.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final profile = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    profile.usernameController.text = profile.userName.value;
    profile.locationController.text = profile.userLocation.value;
    profile.bioController.text = profile.userBio.value;
    profile.contactController.text = profile.userContact.value;
    profile.emailController.text = profile.userEmail.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 0),
              margin: EdgeInsets.only(top: 0),
              height: ScreenUtils.screenHeight(context) * 0.20,
              width: ScreenUtils.screenWidth(context),
              child: Obx(() => Stack(
                    children: [
                      SizedBox(
                        height: ScreenUtils.screenHeight(context) * 0.137,
                        width: ScreenUtils.screenWidth(context),
                        child: Image.asset(
                          '${'image_path'.tr}${'p3'.tr}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.lightGreen,
                                AppColors.radiantBlue
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          // width: ScreenUtils.screenWidth(context),
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 60,
                            foregroundImage: profile.pickedImageFile.value == ''
                                ? NetworkImage(profile.currUser.value.profImage)
                                : FileImage(
                                    File(profile.pickedImageFile.value)),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 20),
            Container(
              width: ScreenUtils.screenWidth(context) * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        profile.pickImage();
                      });
                    },
                    icon: Icon(
                      Icons.camera_alt,
                      color: AppColors.blue,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextInput(
                    controller: profile.usernameController,
                    label: "Username",
                  ),
                  const SizedBox(height: 15),
                  TextInput(
                    controller: profile.bioController,
                    label: "Bio",
                  ),
                  const SizedBox(height: 15),
                  TextInput(
                    controller: profile.contactController,
                    label: "Contact",
                  ),
                  const SizedBox(height: 15),
                  TextInput(
                    controller: profile.emailController,
                    label: "Email",
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: TextInput(
                          label: "Location",
                          controller: profile.locationController,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          profile.openMap(context);
                        },
                        icon: Icon(Icons.location_pin),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  LongElevatedButton(
                    text: profile.isLoading.value
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: const CircularProgressIndicator(
                              color: AppColors.white,
                            ),
                          )
                        : Text("Update"),
                    onClick: () async {
                      setState(() {
                        profile.isLoading.value = true;
                      });
                      await profile.updateProfile();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
