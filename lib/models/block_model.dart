// To parse this JSON data, do
//
//     final blockModel = blockModelFromJson(jsonString);

import 'dart:convert';

BlockModel blockModelFromJson(String str) => BlockModel.fromJson(json.decode(str));

String blockModelToJson(BlockModel data) => json.encode(data.toJson());

class BlockModel {
  BlockModel({
    this.success,
    this.statuscode,
    this.message,
    this.responseData,
  });

  bool? success;
  int? statuscode;
  String? message;
  ResponseData? responseData;

  factory BlockModel.fromJson(Map<String, dynamic> json) => BlockModel(
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
    this.blockList,
    this.id,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  List<String>? blockList;
  String? id;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    blockList: List<String>.from(json["blockList"].map((x) => x)),
    id: json["_id"],
    userId: json["userId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "blockList": List<dynamic>.from(blockList!.map((x) => x)),
    "_id": id,
    "userId": userId,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}
