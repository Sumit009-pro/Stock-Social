// To parse this JSON data, do
//
//     final activityCountModel = activityCountModelFromJson(jsonString);

import 'dart:convert';

ActivityCountModel activityCountModelFromJson(String str) => ActivityCountModel.fromJson(json.decode(str));

String activityCountModelToJson(ActivityCountModel data) => json.encode(data.toJson());

class ActivityCountModel {
  ActivityCountModel({
    this.success,
    this.statuscode,
    this.message,
    this.responseData,
  });

  bool? success;
  int? statuscode;
  String? message;
  ResponseData? responseData;

  factory ActivityCountModel.fromJson(Map<String, dynamic> json) => ActivityCountModel(
    success: json["success"],
    statuscode: json["STATUSCODE"],
    message: json["message"],
    responseData: ResponseData.fromJson(json["response_data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "STATUSCODE": statuscode,
    "message": message,
    "response_data": responseData!.toJson(),
  };
}

class ResponseData {
  ResponseData({
    this.followers,
    this.following,
    this.posts,
    this.like,
    this.share,
    this.comment,
  });

  int? followers;
  int? following;
  int? posts;
  int? like;
  int? share;
  int? comment;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    followers: json["followers"],
    following: json["following"],
    posts: json["posts"],
    like: json["like"],
    share: json["share"],
    comment: json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "followers": followers,
    "following": following,
    "posts": posts,
    "like": like,
    "share": share,
    "comment": comment,
  };
}
