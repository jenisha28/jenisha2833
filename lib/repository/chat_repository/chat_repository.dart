import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:social_media_app/data/dummy_data/dummy_data.dart';
import 'package:social_media_app/main.dart';
import 'package:social_media_app/model/chat_model/chat_model.dart';
import 'package:social_media_app/utils/uuid_util.dart';

class ChatRepository {
  static Map<String, List<ChatModel>> getChat() {
    Map<String, List<ChatModel>> chats = DummyData.chatDetails;
    return chats;
  }

  static String uid = firebase.currentUser!.uid;

  static final chat = FirebaseFirestore.instance.collection("Chat");
  static final chatList = FirebaseFirestore.instance.collection("Chat List");
  static final usersChat = FirebaseFirestore.instance.collection("Users Chat");

  Future<String> alreadyHaveChatId(String uid1) async {
    final snap = await usersChat.doc(uid).get();
    final snap2 = await usersChat.doc(uid1).get();
    if (snap.exists && snap2.exists) {
      Set<dynamic> element = snap
          .get('chatList')
          .toSet()
          .intersection(snap2.get('chatList').toSet());

      if (element.length == 1) {
        return element.first;
      }
    }
    return '';
  }

  Future<List<Map>> getChats() async {
    /// Testing
    // Get All ChatID List with its Data
    try {
      var snapshot = await chatList.get();
      List<Map> data = snapshot as List<Map>;
      print(data);
      return data;
    } on Exception catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    }
    return [];
  }

  Future getChatInfo(String chatId) async {
    /// Testing
    // TODO: Get Data from Chat List
    try {
      var chatData = await chatList.doc(chatId).get();
      var data = chatData.data() as Map<String, dynamic>;
    } on Exception catch (error) {
      log('Exception, $error');
      Get.snackbar(
          "Something Went Wrong", "Failed to add Comment, Please Retry");
    }
  }

  Future getChatMessages(String chatId) async {
    try {
      var chatData = await chat.doc(chatId).get();
      var data = chatData.data() as Map<String, dynamic>;
      return data;
    } on Exception catch (error) {
      log('Exception, $error');
      Get.snackbar(
          "Something Went Wrong", "Failed to add Comment, Please Retry");
    }
  }

  Future<void> addChat(String uid1, ChatModel chatModel) async {
    try {
      final oldChatId = await alreadyHaveChatId(uid1);
      if (oldChatId.isNotEmpty) {
        await getChatMessages(oldChatId);
        await addMessage(oldChatId, chatModel);
        await chatList.doc(oldChatId).update({
          'lastMessage': chatModel.toJson(),
        });
      } else {
        String chatId = UuidUtil.uuid.toString();

        // Add chaListId in Chat Id collection
        await chatList.doc(chatId).set({
          'initiatedAt': DateTime.now().toString(),
          'initiatedBy': uid,
          'lastMessage': chatModel.toJson(),
          'participantIds': [uid, uid1],
          'participants': [
            {
              'last_online': '28 March 2025 at 10:10:25 UTC+5:30',
              'profile_image': 'url',
              'uid': uid1,
              'username': 'Harry Potter'
            }
          ]
        });

        // Add chaListId in Users Chat collection
        await usersChat.doc(uid).set({
          'chatList': FieldValue.arrayUnion([chatId])
        }, SetOptions(merge: true));
        await usersChat.doc(uid1).set({
          'chatList': FieldValue.arrayUnion([chatId])
        }, SetOptions(merge: true));

        // Add Message to Chat Collection
        await addMessage(chatId, chatModel);
      }
    } on Exception catch (error) {
      log('"Authentication Exception", $error');
      Get.snackbar(
          "Something Went Wrong", "Failed to add Comment, Please Retry");
    }
  }

  Future<void> addMessage(String chatID, ChatModel chatModel) async {
    try {
      await chat.doc(chatID).set(
          {UuidUtil.uuid.toString(): chatModel.toJson()},
          SetOptions(merge: true));
    } on Exception catch (error) {
      log('"Authentication Exception", $error');
      Get.snackbar(
          "Something Went Wrong", "Failed to add Comment, Please Retry");
    }
  }
}
