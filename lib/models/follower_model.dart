// To parse this JSON data, do
//
//     final followerModel = followerModelFromJson(jsonString);

import 'dart:convert';

import 'global_constants.dart';

FollowerModel followerModelFromJson(String str) => FollowerModel.fromJson(json.decode(str));

String followerModelToJson(FollowerModel data) => json.encode(data.toJson());

class FollowerModel {
  FollowerModel({
    this.success,
    this.statuscode,
    this.message,
    this.responseData,
  });

  bool? success;
  int? statuscode;
  String? message;
  List<ResponseDatum>? responseData;

  factory FollowerModel.fromJson(Map<String, dynamic> json) => FollowerModel(
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
    this.id,
    this.userId,
  });

  String? id;
  UserId? userId;

  factory ResponseDatum.fromJson(Map<String, dynamic> json) => ResponseDatum(
    id: json["_id"],
    userId: UserId.fromJson(json["userId"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId?.toJson(),
  };
}

class UserId {
  UserId({
    this.userName,
    this.profileImage,
    this.id,
    this.email,
  });

  String? userName;
  String? profileImage;
  String? id;
  String? email;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
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
