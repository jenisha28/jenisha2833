import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:social_media_app/main.dart';
import 'package:social_media_app/model/chat_model/chat_model.dart';
import 'package:social_media_app/utils/uuid_util.dart';

class ChatService {
  static String uid = firebase.currentUser!.uid;

  static final chat = FirebaseFirestore.instance.collection("Chat");
  static final chatList = FirebaseFirestore.instance.collection("Chat List");
  static final usersChat = FirebaseFirestore.instance.collection("Users Chat");

  static Future<String> alreadyHaveChatId(String uid1) async {
    final snap = await usersChat.doc(uid).get();
    final snap2 = await usersChat.doc(uid1).get();

    Set<dynamic> element = snap
        .get('chatList')
        .toSet()
        .intersection(snap2.get('chatList').toSet());

    if (element.length == 1) {
      return element.first;
    } else {
      return '';
    }
  }

  static Future getChatInfo(String chatId) async {
    // TODO: Get Data from Chat List
  }

  static Future getChatMessages(String chatId) async {
    try {
      var chatData = await chat.doc(chatId).get();
      print(chatData.data());
    } on Exception catch (error) {
      log('"Authentication Exception", $error');
      Get.snackbar(
          "Something Went Wrong", "Failed to add Comment, Please Retry");
    }
  }

  static Future<void> addChat(String uid1) async {
    try {
      final oldChatId = await alreadyHaveChatId(uid1);
      print(oldChatId);
      if (oldChatId.isNotEmpty) {
        await getChatMessages(oldChatId);
      } else {
        //TODO: Add chaListId in users chat collection
        String chatId = UuidUtil.uuid.toString();
        await usersChat.doc(uid).set({
          'chatList': FieldValue.arrayUnion([chatId])
        }, SetOptions(merge: true));
        await usersChat.doc(uid1).set({
          'chatList': FieldValue.arrayUnion([chatId])
        }, SetOptions(merge: true));
      }
    } on Exception catch (error) {
      log('"Authentication Exception", $error');
      Get.snackbar(
          "Something Went Wrong", "Failed to add Comment, Please Retry");
    }
  }

  static Future<void> addMessage(
      String text, String images,Status status, MsgType msgType, String userId) async {
    try {
      ChatModel chatModel = ChatModel(
          message: text,
          status: Status.read,
          senderId: uid,
          replyTo: 'XmoPkPCAa9hojp9KEOpp2rXsceE3',
          msgType: msgType,
          timestamp: DateTime.now().toString(),
          type: 'text',
          imageMessage: '');

      await chat
          .doc("1743140027114898")
          .set({UuidUtil.uuid.toString(): chatModel.toJson()}, SetOptions(merge: true));
    } on Exception catch (error) {
      log('"Authentication Exception", $error');
      Get.snackbar(
          "Something Went Wrong", "Failed to add Comment, Please Retry");
    }
  }
}
