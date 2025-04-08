import 'dart:convert';

List<UsersModel> usersModelFromJson(String str) {
  final jsonData = json.decode(str);
  return List<UsersModel>.from(jsonData.map((x) => UsersModel.fromJson(x)));
}

String usersModelToJson(List<UsersModel> data) {
  final dyn = List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class UsersModel {
  String uid;
  String profImage;
  String username;
  String contact;
  String dob;
  String gender;
  String email;
  String location;
  String password;
  String bio;
  int followers;
  int following;

  UsersModel({
    this.uid = '',
    this.profImage = '',
    this.username = '',
    this.contact = "",
    this.dob = "",
    this.gender = "",
    this.email = '',
    this.location = '',
    this.password = '',
    this.bio = '',
    this.followers = 0,
    this.following = 0,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        uid: json["uid"] ?? '',
        profImage: json["prof_image"] ?? '',
        username: json["username"] ?? '',
        contact: json["contact"] ?? '',
        dob: json["dob"] ?? '',
        gender: json["gender"] ?? '',
        email: json["email"] ?? '',
        location: json['location'] ?? '',
        password: json['password'] ?? '',
        bio: json['bio'] ?? '',
        followers: json["followers"] ?? 0,
        following: json["following"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "prof_image": profImage,
        "username": username,
        "contact": contact,
        "dob": dob,
        "gender": gender,
        "email": email,
        'location': location,
        'password': password,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
}
