import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/view/user_view/chat_screen/message_bubble.dart';
import 'package:social_media_app/view_model/user_view_model/chat_controller/chat_controller.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final chat = Get.put(ChatViewModel());

  @override
  void initState() {
    // TODO: implement initState
    chat.time.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
          controller: chat.scrollController,
          shrinkWrap: true,
          reverse: true,
          itemCount: chat.chatData.length,
          itemBuilder: (context, index) {
            final chatMessage = chat.chatData[index];
            final nextChatMessage = index + 1 < chat.chatData.length
                ? chat.chatData[index + 1]
                : null;
            final currentMessageUserId = chatMessage.senderId;
            final nextMessageUserId = nextChatMessage?.senderId;
            final nextUserIsSame = currentMessageUserId == nextMessageUserId;
            if (nextUserIsSame) {
              return MessageBubble.next(
                messageId: chatMessage.messageId,
                message: chatMessage.message,
                isMe: "3" == currentMessageUserId,
                msgTime: chatMessage.timestamp,
                msgType: chatMessage.msgType,
                status: chatMessage.status,
              );
            } else {
              return MessageBubble.first(
                messageId: chatMessage.messageId,
                userImage: chat.getUser(chatMessage.senderId).profImage,
                username: chat.getUser(chatMessage.senderId).username,
                message: chatMessage.message,
                isMe: "3" == currentMessageUserId,
                msgTime: chatMessage.timestamp,
                msgType: chatMessage.msgType,
                status: chatMessage.status,
              );
            }
          }),
    );
  }
}
