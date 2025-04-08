import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/model/chat_model/chat_model.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/utils/screen_utils.dart';
import 'package:social_media_app/view_model/user_view_model/chat_controller/chat_controller.dart';

class ChatReply extends StatefulWidget {
  const ChatReply({super.key});

  @override
  State<ChatReply> createState() => _ChatReplyState();
}

class _ChatReplyState extends State<ChatReply> {
  final chat = Get.put(ChatViewModel());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppColors.blue),
          color: AppColors.lightBlue,
          borderRadius: BorderRadius.circular(10)),
      width: ScreenUtils.screenWidth(context),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(right: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Reply to ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 12, color: AppColors.black),
                    ),
                    TextSpan(
                      text:
                          chat.getUser(chat.chatModel.value.senderId).username,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppColors.black),
                    ),
                  ]),
                ),
                chat.chatModel.value.message.isNotEmpty
                    ? Text(
                        overflow: TextOverflow.ellipsis,
                        chat.chatModel.value.message,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w500),
                      )
                    : Image.file(
                        File(chat.chatModel.value.imageMessage),
                        height: 100,
                      ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              onPressed: () {
                chat.chatModel.value = ChatModel();
              },
              icon: Icon(Icons.cancel_sharp),
            ),
          ),
        ],
      ),
    );
  }
}
