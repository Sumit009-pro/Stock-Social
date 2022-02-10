// To parse this JSON data, do
//
//     final blockListModel = blockListModelFromJson(jsonString);

import 'dart:convert';

BlockListModel blockListModelFromJson(String str) => BlockListModel.fromJson(json.decode(str));

String blockListModelToJson(BlockListModel data) => json.encode(data.toJson());

class BlockListModel {
  BlockListModel({
    this.success,
    this.statuscode,
    this.message,
    this.responseData,
  });

  bool? success;
  int? statuscode;
  String? message;
  List<ResponseDatum>? responseData;

  factory BlockListModel.fromJson(Map<String, dynamic> json) => BlockListModel(
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
    this.blockList,
    this.id,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  List<BlockList>? blockList;
  String? id;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory ResponseDatum.fromJson(Map<String, dynamic> json) => ResponseDatum(
    blockList: List<BlockList>.from(json["blockList"].map((x) => BlockList.fromJson(x))),
    id: json["_id"],
    userId: json["userId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "blockList": List<dynamic>.from(blockList!.map((x) => x.toJson())),
    "_id": id,
    "userId": userId,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}

class BlockList {
  BlockList({
    this.userName,
    this.profileImage,
    this.id,
    this.email,
  });

  String? userName;
  String? profileImage;
  String? id;
  String? email;

  factory BlockList.fromJson(Map<String, dynamic> json) => BlockList(
    userName: json["userName"],
    profileImage: json["profileImage"],
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
