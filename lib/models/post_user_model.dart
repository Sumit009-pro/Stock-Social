// To parse this JSON data, do
//
//     final profileUserModel = profileUserModelFromJson(jsonString);

import 'dart:convert';

ProfileUserModel profileUserModelFromJson(String str) => ProfileUserModel.fromJson(json.decode(str));

String profileUserModelToJson(ProfileUserModel data) => json.encode(data.toJson());

class ProfileUserModel {
  ProfileUserModel({
    this.userName,
    this.countryCode,
    this.phone,
    this.profileImage,
    this.coverImage,
    this.isActive,
    this.isDeleted,
    this.isDisable,
    this.badgeCount,
    this.about,
    this.shortAbout,
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
  String? about;
  String? shortAbout;
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

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) => ProfileUserModel(
    userName: json["userName"],
    countryCode: json["countryCode"],
    phone: json["phone"],
    profileImage: json["profileImage"],
    coverImage: json["coverImage"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    isDisable: json["isDisable"],
    badgeCount: json["badgeCount"],
    about: json["about"],
    shortAbout: json["shortAbout"],
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
    "about": about,
    "shortAbout": shortAbout,
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
