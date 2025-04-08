import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/res/components/buttons/animated_toggle.dart';
import 'package:social_media_app/res/components/carousel_slider/file_carousel_slider.dart';
import 'package:social_media_app/utils/screen_utils.dart';
import 'package:social_media_app/view/user_view/add_post_screen/embedded_link_text.dart';
import 'package:social_media_app/view_model/user_view_model/add_post_controller/add_post_controller.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen>
    with TickerProviderStateMixin {
  final addPost = Get.put(AddPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Obx(
          () => SizedBox(
            height: ScreenUtils.screenHeight(context),
            width: ScreenUtils.screenWidth(context),
            child: Stack(
              children: [
                Column(
                  children: [
                    SafeArea(
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              "Discard",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: AppColors.blue,
                                  ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "CREATE",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              if (addPost.isPost.value == true) {
                                await addPost.sendPost();
                                setState(() {
                                  addPost.isExpanded.value = false;
                                });
                              } else if (addPost.isPost.value == false) {
                                await addPost.sendStory();
                                setState(() {
                                  addPost.isExpanded.value = false;
                                });
                              }
                            },
                            child: addPost.isSending.value
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: const CircularProgressIndicator(
                                        color: AppColors.blue),
                                  )
                                : Text("Submit"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      child: Stack(
                        children: [
                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(20),
                            child: TextField(
                              strutStyle: StrutStyle(fontWeight: FontWeight.w700),
                              cursorColor: AppColors.blue,
                              controller: addPost.textPostController,
                              maxLines: 6,
                              decoration: InputDecoration(
                                prefixIcon: Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  height: 130,
                                  width: 55,
                                  alignment: Alignment.topLeft,
                                  child: CircleAvatar(
                                    radius: 20,
                                    foregroundImage: NetworkImage(
                                        addPost.users[2].profImage),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Get.isDarkMode
                                            ? AppColors.blueGrey
                                            : AppColors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Get.isDarkMode
                                            ? AppColors.blueGrey
                                            : AppColors.white)),
                                hintText: "What's in your mind..",
                                filled: true,
                                fillColor: Get.isDarkMode
                                    ? AppColors.blueGrey
                                    : AppColors.white,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 20,
                            child: Row(
                              children: [
                                IconButton(
                                  style: IconButton.styleFrom(
                                      backgroundColor: Get.isDarkMode ? AppColors.white : AppColors.black),
                                  onPressed: () {
                                    setState(() {
                                      if (addPost.isExpanded.value) {
                                        addPost.isExpanded.value = false;
                                      } else {
                                        addPost.isExpanded.value = true;
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    addPost.isExpanded.value
                                        ? Icons.cancel
                                        : Icons.add,
                                    color: Get.isDarkMode ? AppColors.black : AppColors.white,
                                  ),
                                ),
                                addPost.isExpanded.value
                                    ? AnimatedContainer(
                                        curve: Curves.easeInOut,
                                        duration: Duration(milliseconds: 300),
                                        key: Key("expanded"),
                                        height: 42,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Get.isDarkMode ? AppColors.white : AppColors.black
                                        ),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                addPost.result =
                                                    await FilePicker.platform
                                                        .pickFiles(
                                                  allowMultiple: true,
                                                  type: FileType.custom,
                                                  allowedExtensions: [
                                                    'png',
                                                    'jpg',
                                                    'webp'
                                                  ],
                                                );
                                                if (addPost.result != null) {
                                                  for (var file in addPost
                                                      .result!.files) {
                                                    if (!addPost.selectedFile
                                                        .contains(
                                                            File(file.path!))) {
                                                      addPost.selectedFile.add(
                                                          File(file.path!));
                                                    }
                                                  }
                                                }
                                              },
                                              icon: Icon(
                                                Icons.camera_alt,
                                                color: Get.isDarkMode ? AppColors.black : AppColors.white,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                addPost.result =
                                                    await FilePicker.platform
                                                        .pickFiles(
                                                  allowMultiple: true,
                                                  type: FileType.custom,
                                                  allowedExtensions: [
                                                    'mp4',
                                                    'jpg'
                                                  ],
                                                );
                                                if (addPost.result != null) {
                                                  for (var file in addPost
                                                      .result!.files) {
                                                    if (!addPost.selectedFile
                                                        .contains(
                                                            File(file.path!))) {
                                                      addPost.selectedFile.add(
                                                          File(file.path!));
                                                    }
                                                  }
                                                  if (kDebugMode) {
                                                    print(addPost.selectedFile);
                                                  }
                                                }
                                              },
                                              icon: Icon(
                                                Icons.video_collection,
                                                color: Get.isDarkMode ? AppColors.black : AppColors.white,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.map,
                                                color: Get.isDarkMode ? AppColors.black : AppColors.white,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  addPost.showLinkBox.value =
                                                      !addPost
                                                          .showLinkBox.value;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.link,
                                                color: Get.isDarkMode ? AppColors.black : AppColors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : AnimatedContainer(
                                        duration: Duration(seconds: 2),
                                        key: Key("notExpanded"),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    addPost.showLinkBox.value
                        ? EmbeddedLinkText()
                        : Container(),
                    addPost.selectedFile.isNotEmpty
                        ? FileCarouselSlider(fileImages: addPost.selectedFile)
                        : const SizedBox()
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Material(
                    color: Colors.transparent,
                    child: AnimatedToggle(
                      values: ["Post", "Story"],
                      onToggleCallback: (value) {
                        if (value == 0) {
                          addPost.isPost.value = true;
                        } else {
                          addPost.isPost.value = false;
                        }
                        if (kDebugMode) {
                          print(value);
                          print(addPost.isPost.value);
                        }
                      },
                      buttonColor: AppColors.black,
                      textColor: AppColors.white,
                      backgroundColor: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
