// To parse this JSON data, do
//
//     final aboutModel = aboutModelFromJson(jsonString);

import 'dart:convert';

AboutModel aboutModelFromJson(String str) => AboutModel.fromJson(json.decode(str));

String aboutModelToJson(AboutModel data) => json.encode(data.toJson());

class AboutModel {
  AboutModel({
    this.success,
    this.statuscode,
    this.message,
    this.responseData,
  });

  bool? success;
  int? statuscode;
  String? message;
  ResponseData? responseData;

  factory AboutModel.fromJson(Map<String, dynamic> json) => AboutModel(
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
    required this.content,
  });

  Content content;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    content: Content.fromJson(json["content"]),
  );

  Map<String, dynamic> toJson() => {
    "content": content.toJson(),
  };
}

class Content {
  Content({
    this.name,
    this.pageName,
    this.isActive,
    this.id,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? name;
  String? pageName;
  bool? isActive;
  String? id;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    name: json["name"],
    pageName: json["pageName"],
    isActive: json["isActive"],
    id: json["_id"],
    content: json["content"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "pageName": pageName,
    "isActive": isActive,
    "_id": id,
    "content": content,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}
