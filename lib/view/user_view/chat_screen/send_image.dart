import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/utils/screen_utils.dart';
import 'package:social_media_app/view_model/user_view_model/chat_controller/chat_controller.dart';

class SendImage extends StatefulWidget {
  const SendImage({super.key});

  @override
  State<SendImage> createState() => _SendImageState();
}

class _SendImageState extends State<SendImage> {
  final chat = Get.put(ChatViewModel());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtils.screenWidth(context),
      height: ScreenUtils.screenHeight(context) / 3,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: chat.thumbnail.isNotEmpty
                    ? PageView(
                        children: [
                          for (var file in chat.thumbnail.entries)
                            Container(
                                padding: const EdgeInsets.all(8.0),
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Image.file(file.value),
                                    ),
                                    Text(
                                      file.key,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ],
                                )),
                        ],
                      )
                    : Container(),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: chat.focusNode.value,
                        controller: chat.chatController,
                        style: TextStyle(color: AppColors.black),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Get.isDarkMode
                                    ? AppColors.blue
                                    : AppColors.white,
                                width: 3,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Get.isDarkMode
                                    ? AppColors.blue
                                    : AppColors.white,
                                width: 3,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          filled: true,
                          fillColor:
                              Get.isDarkMode ? AppColors.blue : AppColors.white,
                          hintText: "Type your comment here..",
                          hintStyle: TextStyle(
                              color: Get.isDarkMode
                                  ? AppColors.lightBlack
                                  : AppColors.grey),
                          suffixIconColor:
                              Get.isDarkMode ? AppColors.black : AppColors.blue,
                          prefixIconColor:
                              Get.isDarkMode ? AppColors.black : AppColors.blue,
                          prefixIcon: IconButton(
                            onPressed: () async {
                              chat.imagePreview();
                            },
                            icon: Icon(Icons.attach_file),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      style: IconButton.styleFrom(
                          backgroundColor: Get.isDarkMode
                              ? AppColors.blueGrey
                              : AppColors.blue,
                          foregroundColor: Get.isDarkMode
                              ? AppColors.blue
                              : AppColors.white),
                      onPressed: () async {
                        if (chat.thumbnail.isNotEmpty) {
                          for (var img in chat.thumbnail.values) {
                            await chat.addChat("3", "image",
                                messageImage: img.path,
                                message: chat.chatController.text);
                            if (kDebugMode) {
                              print('image path: ${img.path}');
                            }
                            if (await chat.notificationPermission() == true) {
                              print("Notification permission approved...");
                            } else {
                              setState(() {
                                chat.openSettings();
                              });
                            }
                          }
                          chat.selectedFile.clear();
                        }
                      },
                      icon: Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            child: IconButton(
              onPressed: () {
                setState(() {
                  chat.selectedFile.clear();
                });
              },
              icon: Icon(Icons.cancel),
            ),
          ),
        ],
      ),
    );
  }
}
