import 'dart:convert';

List<ChatModel> chatModelFromJson(String str) =>
    List<ChatModel>.from(json.decode(str).map((x) => ChatModel.fromJson(x)));

String chatModelToJson(List<ChatModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

enum MsgType { reply, message }

enum Status { pending, delivered, read }

class ChatModel {
  String messageId;
  String message;
  String imageMessage;
  String senderId;
  String timestamp;
  String type;
  Status status;
  MsgType msgType;
  String replyTo;

  ChatModel({
    this.messageId = "",
    this.message = "",
    this.imageMessage = "",
    this.senderId = "",
    this.timestamp = "",
    this.type = "",
    this.status = Status.read,
    this.msgType = MsgType.message,
    this.replyTo = "",
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        messageId: json["messageId"] ?? '',
        message: json["message"] ?? '',
        imageMessage: json["imageMessage"] ?? '',
        senderId: json["senderId"] ?? '',
        timestamp: json["timestamp"] ?? '',
        type: json["type"] ?? '',
        status: json["status"] ?? Status.read,
        msgType: json["msgType"] ?? MsgType.message,
        replyTo: json["replyTo"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "message": message,
        "imageMessage": imageMessage,
        "senderId": senderId,
        "timestamp": timestamp,
        "type": type,
        "status": status.name,
        "msgType": msgType.name,
        "replyTo": replyTo,
      };
}
