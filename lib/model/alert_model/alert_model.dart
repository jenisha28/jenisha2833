// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  List<Alert>? alerts;

  Welcome({
    this.alerts,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    alerts: json["alerts"] == null ? [] : List<Alert>.from(json["alerts"]!.map((x) => Alert.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "alerts": alerts == null ? [] : List<dynamic>.from(alerts!.map((x) => x.toJson())),
  };
}

class Alert {
  String id;
  String type;
  String title;
  String message;
  String timestamp;
  bool isRead;
  String imageUrl;
  String link;

  Alert({
    this.id = " = ",
    this.type = "",
    this.title = "",
    this.message = "",
    this.timestamp = "",
    this.isRead = false,
    this.imageUrl = "",
    this.link = "",
  });

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
    id: json["id"] ?? '',
    type: json["type"] ?? '',
    title: json["title"] ?? '',
    message: json["message"] ?? '',
    timestamp: json["timestamp"] ?? '',
    isRead: json["isRead"] ?? false,
    imageUrl: json["imageUrl"] ?? '',
    link: json["link"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "title": title,
    "message": message,
    "timestamp": timestamp,
    "isRead": isRead,
    "imageUrl": imageUrl,
    "link": link,
  };
}