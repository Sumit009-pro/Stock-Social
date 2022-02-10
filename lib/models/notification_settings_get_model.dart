// To parse this JSON data, do
//
//     final notificationSettingsGetModel = notificationSettingsGetModelFromJson(jsonString);

import 'dart:convert';

NotificationSettingsGetModel notificationSettingsGetModelFromJson(String str) => NotificationSettingsGetModel.fromJson(json.decode(str));

String notificationSettingsGetModelToJson(NotificationSettingsGetModel data) => json.encode(data.toJson());

class NotificationSettingsGetModel {
  NotificationSettingsGetModel({
    this.success,
    this.statuscode,
    this.message,
    this.responseData,
  });

  bool? success;
  int? statuscode;
  String? message;
  ResponseData? responseData;

  factory NotificationSettingsGetModel.fromJson(Map<String, dynamic> json) => NotificationSettingsGetModel(
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
    this.usernotSetting,
  });

  UsernotSetting? usernotSetting;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    usernotSetting: UsernotSetting.fromJson(json["usernotSetting"]),
  );

  Map<String, dynamic> toJson() => {
    "usernotSetting": usernotSetting!.toJson(),
  };
}

class UsernotSetting {
  UsernotSetting({
    this.like,
    this.comment,
    this.share,
    this.message,
    this.follow,
  });

  bool? like;
  bool? comment;
  bool? share;
  bool? message;
  bool? follow;

  factory UsernotSetting.fromJson(Map<String, dynamic> json) => UsernotSetting(
    like: json["Like"],
    comment: json["Comment"],
    share: json["Share"],
    message: json["Message"],
    follow: json["Follow"],
  );

  Map<String, dynamic> toJson() => {
    "Like": like,
    "Comment": comment,
    "Share": share,
    "Message": message,
    "Follow": follow,
  };
}
