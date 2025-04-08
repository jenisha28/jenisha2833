import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/view/user_view/chat_screen/chat_reply.dart';
import 'package:social_media_app/view_model/user_view_model/chat_controller/chat_controller.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final chat = Get.put(ChatViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          chat.chatModel.value.messageId.isNotEmpty ? ChatReply() : Container(),
          Row(
            children: [
              Expanded(
                child: TextField(
                  focusNode: chat.focusNode.value,
                  controller: chat.chatController,
                  style: TextStyle(color: AppColors.black),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Get.isDarkMode ? AppColors.blue : AppColors.white,
                          width: 3,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Get.isDarkMode ? AppColors.blue : AppColors.white,
                          width: 3,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    filled: true,
                    fillColor:
                        Get.isDarkMode ? AppColors.blue : AppColors.white,
                    hintText: "Type your Message here..",
                    hintStyle: TextStyle(
                        color: Get.isDarkMode
                            ? AppColors.lightBlack
                            : AppColors.grey),
                    suffixIconColor:
                        Get.isDarkMode ? AppColors.black : AppColors.blue,
                    prefixIconColor:
                        Get.isDarkMode ? AppColors.black : AppColors.blue,
                    prefixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          chat.thumbnail.clear();
                          chat.imagePreview();
                        });
                      },
                      icon: Icon(Icons.attach_file),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        if (await chat.microphonePermission() == true) {
                          print("permission approved...");
                        } else {
                          setState(() {
                            chat.openSettings();
                          });
                        }
                      },
                      icon: Icon(Icons.mic),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              IconButton(
                style: IconButton.styleFrom(
                    backgroundColor:
                        Get.isDarkMode ? AppColors.blueGrey : AppColors.blue,
                    foregroundColor:
                        Get.isDarkMode ? AppColors.blue : AppColors.white),
                onPressed: () async {
                  if (chat.isUpdate.value) {
                    await chat.updateMessage(chat.chatController.text);
                  } else {
                    await chat.addChat("3", "text",
                        message: chat.chatController.text);
                    if (await chat.notificationPermission() == true) {
                      print("permission approved...");
                    } else {
                      setState(() {
                        chat.openSettings();
                      });
                    }
                  }
                },
                icon: Icon(chat.isUpdate.value ? Icons.check : Icons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
