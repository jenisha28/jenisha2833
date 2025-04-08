import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:social_media_app/utils/screen_utils.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/view/user_view/chat_screen/chat.dart';
import 'package:social_media_app/view/user_view/chat_screen/chats.dart';
import 'package:social_media_app/view/user_view/chat_screen/send_image.dart';
import 'package:social_media_app/view_model/user_view_model/chat_controller/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chat = Get.put(ChatViewModel());

  @override
  void initState() {
    chat.getChat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              // PopupMenuItem 1
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.delete_sharp),
                    SizedBox(width: 10),
                    Text("Delete"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.mark_chat_unread),
                    SizedBox(width: 10),
                    Text("Mark as Unread")
                  ],
                ),
              ),
            ],
            offset: Offset(0, 50),
            elevation: 2,
            onSelected: (value) {
              if (value == 1) {
                setState(() {
                  if (chat.selectedMessages.isNotEmpty) {
                    for (var msg in chat.selectedMessages) {
                      chat.chatData.remove(chat.getMessage(msg));
                    }
                    chat.selectedMessages.clear();
                  }
                });
              } else if (value == 2) {
                if (kDebugMode) {
                  print("chat marked as unread");
                }
              }
            },
          ),
        ],
        leading: IconButton(
          style: IconButton.styleFrom(
              backgroundColor:
                  Get.isDarkMode ? AppColors.blueGrey : AppColors.black,
              foregroundColor:
                  Get.isDarkMode ? AppColors.blue : AppColors.white),
          onPressed: () {
            chat.selectedMessages.clear();
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Row(
          children: [
            CircleAvatar(
              foregroundImage:
                  NetworkImage(chat.getUser(chat.chatUserId.value).profImage),
            ),
            const SizedBox(width: 10),
            Text(
              chat.getUser(chat.chatUserId.value).username,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: PopScope(
        onPopInvokedWithResult: (val, value) {
          print("Back.................");
        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              height: ScreenUtils.screenHeight(context),
              width: ScreenUtils.screenWidth(context),
              child: Column(
                children: [
                  if (chat.chatData.isNotEmpty)
                    Expanded(child: Chat())
                  else
                    Expanded(
                      child: Column(
                        children: [
                          Spacer(),
                          Text(
                            "Start Your Conversation",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: AppColors.grey),
                          ),
                        ],
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                    // height: 50,
                    child: Obx(
                      () =>
                          chat.selectedFile.isNotEmpty ? SendImage() : Chats(),
                    ),
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
