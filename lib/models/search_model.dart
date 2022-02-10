// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

import 'global_constants.dart';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    this.success,
    this.statuscode,
    this.message,
    this.responseData,
  });

  bool? success;
  int? statuscode;
  String? message;
  List<ResponseDatum>? responseData;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
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
    this.userName,
    this.countryCode,
    this.phone,
    this.profileImage,
    this.coverImage,
    this.isActive,
    this.isDeleted,
    this.isDisable,
    this.badgeCount,
    this.promotionalEmail,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.dateOfBirth,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? userName;
  String? countryCode;
  dynamic phone;
  String? profileImage;
  String? coverImage;
  bool? isActive;
  bool? isDeleted;
  bool? isDisable;
  int? badgeCount;
  bool? promotionalEmail;
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  DateTime? dateOfBirth;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory ResponseDatum.fromJson(Map<String, dynamic> json) => ResponseDatum(
    userName: json["userName"],
    countryCode: json["countryCode"],
    phone: json["phone"],
    profileImage:json['profileImage']!=null && json['profileImage']!="" ? "${GlobalConstants.imageLink}profile-pic/${json['profileImage']}" : "",
    coverImage:json["coverImage"]!=null && json["coverImage"]!="" ? "${GlobalConstants.imageLink}${json["coverImage"]}" : "",
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    isDisable: json["isDisable"],
    badgeCount: json["badgeCount"],
    promotionalEmail: json["promotionalEmail"],
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "countryCode": countryCode,
    "phone": phone,
    "profileImage": profileImage,
    "coverImage": coverImage,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "isDisable": isDisable,
    "badgeCount": badgeCount,
    "promotionalEmail": promotionalEmail,
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "dateOfBirth": dateOfBirth!.toIso8601String(),
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}
