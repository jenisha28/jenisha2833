import 'dart:convert';

List<PostModel> postModelFromJson(String str) {
  final jsonData = json.decode(str);
  return List<PostModel>.from(jsonData.map((x) => PostModel.fromJson(x)));
}

String postModelToJson(List<PostModel> data) {
  final dyn = List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class PostModel {
  String postId; // TODO: to remove
  String uid; // TODO: to remove
  String postTime;
  String postText;
  List<dynamic> postImage;
  int likes;
  int share;
  List<PostComment> postComments;

  PostModel({
    this.postId = "",
    this.uid = "",
    this.postTime = "",
    this.postText = "",
    this.postImage = const [],
    this.likes = 0,
    this.share = 0,
    this.postComments = const [],
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    postId: json["postId"] ?? '',
    uid: json["uid"] ?? '',
    postTime: json["postTime"] ?? '',
    postText: json["postText"] ?? '',
    postImage: List<dynamic>.from(json["postImage"].map((x) => x)),
    likes: json["likes"] ?? 0,
    share: json["share"] ?? 0,
    postComments: List<PostComment>.from(json["postComments"].map((x) => PostComment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "postId": postId,
    "uid": uid,
    "postTime": postTime,
    "postText": postText,
    "postImage": List<dynamic>.from(postImage.map((x) => x)),
    "likes": likes,
    "share": share,
    "postComments": List<dynamic>.from(postComments.map((x) => x.toJson())),
  };
}

class PostComment {
  String commentId;
  String uid;
  String cmtText;
  String cmtTime;
  int likes;

  PostComment({
    this.commentId = "",
    this.uid = "",
    this.cmtText = "",
    this.cmtTime = "",
    this.likes = 0,
  });

  factory PostComment.fromJson(Map<String, dynamic> json) => PostComment(
    commentId: json["comment_id"] ?? '',
    uid: json["uid"] ?? '',
    cmtText: json["cmt_text"] ?? '',
    cmtTime: json["cmt_time"] ?? '',
    likes: json["likes"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "comment_id": commentId,
    "uid": uid,
    "cmt_text": cmtText,
    "cmt_time": cmtTime,
    "likes": likes,
  };
}
