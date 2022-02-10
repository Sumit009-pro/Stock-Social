// To parse this JSON data, do
//
//     final followingModel = followingModelFromJson(jsonString);

import 'dart:convert';

import 'global_constants.dart';

FollowingModel followingModelFromJson(String str) => FollowingModel.fromJson(json.decode(str));

String followingModelToJson(FollowingModel data) => json.encode(data.toJson());

class FollowingModel {
  FollowingModel({
    this.success,
    this.statuscode,
    this.message,
    this.responseData,
  });

  bool? success;
  int? statuscode;
  String? message;
  List<ResponseDatum>? responseData;

  factory FollowingModel.fromJson(Map<String, dynamic> json) => FollowingModel(
    success: json["success"],
    statuscode: json["STATUSCODE"],
    message: json["message"],
    responseData: List<ResponseDatum>.from(json["response_data"].map((x) => ResponseDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "STATUSCODE": statuscode,
    "message": message,
    "response_data": List<dynamic>.from(responseData!.map((x) => x.toJson())),
  };
}

class ResponseDatum {
  ResponseDatum({
    this.following,
    this.id,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  List<Following>? following;
  String? id;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory ResponseDatum.fromJson(Map<String, dynamic> json) => ResponseDatum(
    following: List<Following>.from(json["following"].map((x) => Following.fromJson(x))),
    id: json["_id"],
    userId: json["userId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "following": List<dynamic>.from(following!.map((x) => x.toJson())),
    "_id": id,
    "userId": userId,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}

class Following {
  Following({
    this.userName,
    this.profileImage,
    this.id,
    this.email,
  });

  String? userName;
  String? profileImage;
  String? id;
  String? email;

  factory Following.fromJson(Map<String, dynamic> json) => Following(
    userName: json["userName"],
    profileImage : json['profileImage']!=null && json['profileImage']!="" ? "${GlobalConstants.imageLink}profile-pic/${json['profileImage']}" : "",
    id: json["_id"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "profileImage": profileImage,
    "_id": id,
    "email": email,
  };
}
