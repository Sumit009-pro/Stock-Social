// To parse this JSON data, do
//
//     final notificationDataModel = notificationDataModelFromJson(jsonString);

import 'dart:convert';

NotificationDataModel notificationDataModelFromJson(String str) => NotificationDataModel.fromJson(json.decode(str));

String notificationDataModelToJson(NotificationDataModel data) => json.encode(data.toJson());

class NotificationDataModel {
  NotificationDataModel({
    this.otherData,
    this.isRead,
    this.count,
    this.notificationType,
    this.message,
    this.userId,
    this.otherUserId,
  });

  String? otherData;
  String? isRead;
  int? count;
  String? notificationType;
  String? message;
  String? userId;
  String? otherUserId;

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) => NotificationDataModel(
    otherData: json["otherData"],
    isRead: json["isRead"],
    count: json["count"],
    notificationType: json["notificationType"],
    message: json["message"],
    userId: json["userId"],
    otherUserId: json["otherUserId"],
  );

  Map<String, dynamic> toJson() => {
    "otherData": otherData,
    "isRead": isRead,
    "count": count,
    "notificationType": notificationType,
    "message": message,
    "userId": userId,
    "otherUserId": otherUserId,
  };
}
