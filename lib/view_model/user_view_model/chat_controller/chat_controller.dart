import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_media_app/model/chat_model/chat_model.dart';
import 'package:social_media_app/model/users_model/users_model.dart';
import 'package:social_media_app/repository/chat_repository/chat_repository.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/view/user_view/chat_screen/message_bubble.dart';
import 'package:social_media_app/view_model/user_view_model/dashboard_controller/dashboard_controller.dart';

class ChatViewModel extends GetxController {
  final chat = ChatRepository.getChat();
  final users = Get.find<DashboardController>().users;
  final chatController = TextEditingController();
  final Rx<FocusNode> focusNode = FocusNode().obs;
  final scrollController = ScrollController();
  Rx<ChatModel> chatModel = ChatModel().obs;
  final chatUserId = "1".obs;
  RxList chatData = <ChatModel>[].obs;
  RxList time = [].obs;
  RxList selectedMessages = [].obs;
  final selectedFile = <File>[].obs;
  FilePickerResult? result;
  final thumbnail = {}.obs;
  final RxBool isUpdate = false.obs;
  final RxString updateMsgId = "".obs;

  var count = 0;
  var tapPosition;

  void deleteMessage(String msgId) {
    chatData.remove(getMessage(msgId));
  }
  
  getMsgIndex(String msgId) {
    return chatData.indexWhere((msg) => msg.messageId == msgId);
  }

  void showCustomMenu(BuildContext context, String messageId) async {
    if (tapPosition == null) {
      return;
    }
    final overlay = Overlay.of(context).context.findRenderObject();
    if (overlay == null) {
      return;
    }

    final delta = await showMenu(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: Get.isDarkMode ? AppColors.blueGrey : AppColors.white,
      items: <PopupMenuEntry<int>>[PlusMinusEntry(messageId)],
      position: RelativeRect.fromRect(
          tapPosition! &
          const Size(30, 30), // smaller rect, the touch area
          Offset.zero &
          overlay.semanticBounds.size // Bigger rect, the entire screen
      ),
    );

    // delta would be null if user taps on outside the popup menu
    // (causing it to close without making selection)
    if (delta == null) {
      return;
    }
  }

  void storePosition(TapDownDetails details) {
    tapPosition = details.globalPosition;
  }

  void imagePreview() async {
    selectedFile.clear();
    result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: [
        'png',
        'jpg',
        'webp',
        "mp3",
        "mp4",
      ],
    );
    if (result != null) {
      for (var file in result!.files) {
        if (!selectedFile.contains(File(file.path!))) {
          selectedFile.add(File(file.path!));
          thumbnail[file.name] = File(file.path!);
        }
      }
    } else {
      if (kDebugMode) {
        print("User not selected any file.....");
      }
    }
  }

  void getChat() {
    if (chat.containsKey(chatUserId.value)) {
      chatData.assignAll(chat[chatUserId.value]!.obs);
    } else {
      chatData.clear();
    }
  }

  UsersModel getUser(String uid) {
    int userIndex = users.indexWhere((e) => e.uid == uid);
    return users[userIndex];
  }

  ChatModel getMessage(String messageId) {
    int msgIndex = chatData.indexWhere((e) => e.messageId == messageId);
    return chatData[msgIndex];
  }

  Future<void> updateMessage(String message) async {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.minScrollExtent);
    }
    int index = getMsgIndex(updateMsgId.value);
    chatData[index].message = message;
    chatController.clear();
    isUpdate.value = false;
    updateMsgId.value = '';
    focusNode.value.unfocus();
  }

  Future<void> addChat(String senderId, String type,
      {String message = "", String messageImage = ""}) async {
    if (message.trim().isEmpty && messageImage.trim().isEmpty) {
      return;
    }
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.minScrollExtent);
    }
    chatController.clear();

    ChatModel chat = ChatModel(
      messageId: (chatData.length + 1).toString(),
      message: message,
      imageMessage: messageImage,
      type: type,
      senderId: senderId,
      timestamp: DateTime.now().toString(),
      msgType:
          chatModel.value.messageId != "" ? MsgType.reply : MsgType.message,
      replyTo: chatModel.value.messageId != "" ? chatModel.value.messageId : '',
      status: Status.read,
    );

    // To add Chat in Firebase FireStore
    // String imageUrls = await StorageServices().uploadChatImages(messageImage);
    //
    // ChatModel chats = ChatModel(
    //   message: message,
    //   imageMessage: imageUrls,
    //   type: type,
    //   senderId: firebase.currentUser!.uid,
    //   timestamp: DateTime.now().toString(),
    //   msgType:
    //   chatModel.value.messageId != "" ? MsgType.reply : MsgType.message,
    //   replyTo: chatModel.value.messageId != "" ? chatModel.value.messageId : '',
    //   status: Status.read,
    // );
    //
    // await ChatRepository()
    //     .addChat("XmoPkPCAa9hojp9KEOpp2rXsceE3", chats);
    chatModel.value = ChatModel();
    chatData.insert(0, chat);
    // await NotificationService.sendNotification(getUser(senderId).username, message);
    // chatData.refresh();
  }

  void onReply(String messageId) {
    chatModel.value = chatData.firstWhere((msg) => msg.messageId == messageId);
    focusNode.value.requestFocus();
  }

  Future<bool> microphonePermission() async {
    if (await Permission.microphone.isDenied) {
      await Permission.microphone.request();
    }
    return await Permission.microphone.status.isGranted;
  }

  Future<bool> notificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
    return await Permission.notification.status.isGranted;
  }

  void openSettings() {
    openAppSettings();
  }
}
