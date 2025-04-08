import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/res/routes/route_names.dart';
import 'package:social_media_app/view_model/user_view_model/chat_controller/chat_controller.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final chat = Get.put(ChatViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var user in chat.users)
                if (chat.chat.containsKey(user.uid))
                  Column(
                    children: [
                      ListTile(
                        onLongPress: () {
                          Get.dialog(
                            AlertDialog(
                              backgroundColor: Get.isDarkMode
                                  ? AppColors.blueGrey
                                  : AppColors.white,
                              title: Text("Delete Chat"),
                              titleTextStyle: TextStyle(
                                  color: Get.isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              icon: Icon(Icons.warning, size: 60),
                              iconColor: AppColors.red,
                              content: Text(
                                  "You are going to delete chat with ${user.username}"),
                              contentTextStyle: TextStyle(
                                  color: Get.isDarkMode
                                      ? AppColors.white
                                      : AppColors.black),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Get.isDarkMode
                                            ? AppColors.white
                                            : AppColors.black,
                                        fontSize: 16),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      chat.chat.remove(user.uid);
                                      Get.back();
                                    });
                                  },
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                        color: AppColors.blue, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        onTap: () {
                          chat.chatUserId.value = user.uid;
                          Get.toNamed(RouteNames.chatScreen);
                        },
                        title: Text(user.username),
                        subtitle: Text(user.bio),
                        leading: CircleAvatar(
                          foregroundImage: NetworkImage(user.profImage),
                        ),
                      ),
                      // Divider(endIndent: 10,indent: 10,height: 2,),
                    ],
                  ),
              const SizedBox(height: 20),
              Text(
                " Start Conversation With",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              for (var user in chat.users)
                if (!chat.chat.containsKey(user.uid))
                  ListTile(
                    onTap: () {
                      chat.chatUserId.value = user.uid;
                      Get.toNamed(RouteNames.chatScreen);
                    },
                    title: Text(user.username),
                    subtitle: Text(user.bio),
                    leading: CircleAvatar(
                      foregroundImage: NetworkImage(user.profImage),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
