// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

import 'global_constants.dart';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.success,
    this.statuscode,
    this.message,
    this.responseData,
  });

  bool? success;
  int? statuscode;
  String? message;
  ResponseData? responseData;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
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
    this.notification,
  });

  List<Notify>? notification;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    notification: List<Notify>.from(json["notification"].map((x) => Notify.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "notification": List<dynamic>.from(notification!.map((x) => x.toJson())),
  };
}

class Notify {
  Notify({
    this.isRead,
    this.id,
    this.userId,
    this.notificationType,
    this.message,
    this.otherData,
    this.otherUserId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? isRead;
  String? id;
  String? userId;
  String? notificationType;
  String? message;
  String? otherData;
  OtherUserId? otherUserId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Notify.fromJson(Map<String, dynamic> json) => Notify(
    isRead: json["isRead"],
    id: json["_id"],
    userId: json["userId"],
    notificationType: json["notificationType"],
    message: json["message"],
    otherData: json["otherData"],
    otherUserId: OtherUserId.fromJson(json["otherUserId"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "isRead": isRead,
    "_id": id,
    "userId": userId,
    "notificationType": notificationType,
    "message": message,
    "otherData": otherData,
    "otherUserId": otherUserId!.toJson(),
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}

class OtherUserId {
  OtherUserId({
    this.userName,
    this.profileImage,
    this.id,
    this.email,
  });

  String? userName;
  String? profileImage;
  String? id;
  String? email;

  factory OtherUserId.fromJson(Map<String, dynamic> json) => OtherUserId(
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
