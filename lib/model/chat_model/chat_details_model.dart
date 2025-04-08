// To parse this JSON data, do
//
//     final chatDetailsModel = chatDetailsModelFromJson(jsonString);

import 'dart:convert';

ChatDetailsModel chatDetailsModelFromJson(String str) =>
    ChatDetailsModel.fromJson(json.decode(str));

String chatDetailsModelToJson(ChatDetailsModel data) =>
    json.encode(data.toJson());

class ChatDetailsModel {
  String initiatedAt;
  String initiatedBy;
  LastMessage? lastMessage;
  String lastUpdatedAt;
  List<String> participantIds;
  List<Participant> participants;

  ChatDetailsModel({
    this.initiatedAt = '',
    this.initiatedBy = '',
    this.lastMessage,
    this.lastUpdatedAt = '',
    this.participantIds = const [],
    this.participants = const [],
  });

  factory ChatDetailsModel.fromJson(Map<String, dynamic> json) =>
      ChatDetailsModel(
        initiatedAt: json["initiatedAt"] ?? '',
        initiatedBy: json["initiatedBy"] ?? '',
        lastMessage: LastMessage.fromJson(json["lastMessage"]),
        lastUpdatedAt: json["lastUpdatedAt"] ?? '',
        participantIds: List<String>.from(json["participantIds"].map((x) => x)),
        participants: List<Participant>.from(
            json["participants"].map((x) => Participant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "initiatedAt": initiatedAt,
        "initiatedBy": initiatedBy,
        "lastMessage": lastMessage!.toJson(),
        "lastUpdatedAt": lastUpdatedAt,
        "participantIds": List<dynamic>.from(participantIds.map((x) => x)),
        "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
      };
}

class LastMessage {
  String imageMessage;
  String message;
  String msgType;
  String replyTo;
  String senderId;
  String status;
  String timestamp;
  String type;

  LastMessage({
    this.imageMessage = '',
    this.message = '',
    this.msgType = '',
    this.replyTo = '',
    this.senderId = '',
    this.status = '',
    this.timestamp = '',
    this.type = '',
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        imageMessage: json["imageMessage"] ?? '',
        message: json["message"] ?? '',
        msgType: json["msgType"] ?? '',
        replyTo: json["replyTo"] ?? '',
        senderId: json["senderId"] ?? '',
        status: json["status"] ?? '',
        timestamp: json["timestamp"] ?? '',
        type: json["type"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "imageMessage": imageMessage,
        "message": message,
        "msgType": msgType,
        "replyTo": replyTo,
        "senderId": senderId,
        "status": status,
        "timestamp": timestamp,
        "type": type,
      };
}

class Participant {
  String lastOnlineSeen;
  String profileImage;
  String uid;
  String username;

  Participant({
    this.lastOnlineSeen = '',
    this.profileImage = '',
    this.uid = '',
    this.username = '',
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        lastOnlineSeen: json["last_online/seen"] ?? '',
        profileImage: json["profile_image"] ?? '',
        uid: json["uid"] ?? '',
        username: json["username"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "last_online/seen": lastOnlineSeen,
        "profile_image": profileImage,
        "uid": uid,
        "username": username,
      };
}
