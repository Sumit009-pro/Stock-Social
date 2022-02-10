// To parse this JSON data, do
//
//     final searchPostModel = searchPostModelFromJson(jsonString);

import 'dart:convert';

import 'global_constants.dart';

SearchPostModel searchPostModelFromJson(String str) => SearchPostModel.fromJson(json.decode(str));

String searchPostModelToJson(SearchPostModel data) => json.encode(data.toJson());

class SearchPostModel {
  SearchPostModel({
    this.success,
    this.statuscode,
    this.message,
    this.responseData,
  });

  bool? success;
  int? statuscode;
  String? message;
  ResponseData? responseData;

  factory SearchPostModel.fromJson(Map<String, dynamic> json) => SearchPostModel(
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
    this.utils,
    this.post,
  });

  int? utils;
  List<Post>? post;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    utils: json["utils"],
    post: List<Post>.from(json["post"].map((x) => Post.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "utils": utils,
    "post": List<dynamic>.from(post!.map((x) => x.toJson())),
  };
}

class Post {
  Post({
    this.id,
    this.postType,
    this.contentTpe,
    this.isDeleted,
    this.comments,
    this.likes,
    this.liked,
    this.likedId,
    this.share,
    this.postCreatedAt,
    this.subCategoryId,
    this.content,
    this.image,
    this.createdBy,
    this.sharePost,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? postType;
  String? contentTpe;
  bool? isDeleted;
  bool? liked;
  String? likedId;
  List<Comment>? comments;
  List<Like>? likes;
  List<dynamic>? share;
  DateTime? postCreatedAt;
  SubCategoryId? subCategoryId;
  String? content;
  String? image;
  EdBy? createdBy;
  SharePost? sharePost;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["_id"],
    postType: json["postType"],
    contentTpe: json["contentTpe"],
    isDeleted: json["isDeleted"],
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
    share: List<dynamic>.from(json["share"].map((x) => x)),
    postCreatedAt: DateTime.parse(json["created_At"]),
    subCategoryId: SubCategoryId.fromJson(json["subCategoryId"]),
    content: json["content"],
    image : json['image']!=null && json["image"]!="" ? "${GlobalConstants.imageLink}${json["image"]}" : "",

    // image: json["image"],
    createdBy: EdBy.fromJson(json["createdBy"]),
    sharePost: json["sharePost"] == null ? null : SharePost.fromJson(json["sharePost"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "postType": postType,
    "contentTpe": contentTpe,
    "isDeleted": isDeleted,
    "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
    "likes": List<dynamic>.from(likes!.map((x) => x.toJson())),
    "share": List<dynamic>.from(share!.map((x) => x)),
    "created_At": postCreatedAt!.toIso8601String(),
    "subCategoryId": subCategoryId!.toJson(),
    "content": content,
    "image": image,
    "createdBy": createdBy!.toJson(),
    "sharePost": sharePost == null ? null : sharePost!.toJson(),
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}

class Comment {
  Comment({
    this.id,
    this.createdAt,
    this.comment,
    this.commentedBy,
  });

  String? id;
  DateTime? createdAt;
  String? comment;
  EdBy? commentedBy;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["_id"],
    createdAt: DateTime.parse(json["created_At"]),
    comment: json["comment"],
    commentedBy: EdBy.fromJson(json["commentedBy"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "created_At": createdAt!.toIso8601String(),
    "comment": comment,
    "commentedBy": commentedBy!.toJson(),
  };
}

class EdBy {
  EdBy({
    this.id,
    this.userName,
    this.profileImage,
    this.email,
  });

  String? id;
  String? userName;
  String? profileImage;
  String? email;

  factory EdBy.fromJson(Map<String, dynamic> json) => EdBy(
    id: json["_id"],
    userName: json["userName"],
    profileImage : json['profileImage']!=null && json['profileImage']!="" ? "${GlobalConstants.imageLink}profile-pic/${json['profileImage']}" : "",

    // profileImage : json['profileImage']!=null && json["profileImage"]!="" ? "${GlobalConstants.imageLink}${json["profileImage"]}" : "",
    // profileImage: json["profileImage"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userName": userName,
    "profileImage": profileImage,
    "email": email,
  };
}

class Like {
  Like({
    this.id,
    this.createdAt,
    this.likedBy,
  });

  String? id;
  DateTime? createdAt;
  EdBy? likedBy;

  factory Like.fromJson(Map<String, dynamic> json) => Like(
    id: json["_id"],
    createdAt: DateTime.parse(json["created_At"]),
    likedBy: EdBy.fromJson(json["likedBy"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "created_At": createdAt!.toIso8601String(),
    "likedBy": likedBy!.toJson(),
  };
}

class SharePost {
  SharePost({
    this.id,
    this.postType,
    this.contentTpe,
    this.isDeleted,
    this.comments,
    this.likes,
    this.share,
    this.sharePostCreatedAt,
    this.subCategoryId,
    this.content,
    this.image,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? postType;
  String? contentTpe;
  bool? isDeleted;
  List<dynamic>? comments;
  List<String>? likes;
  List<String>? share;
  DateTime? sharePostCreatedAt;
  String? subCategoryId;
  String? content;
  String? image;
  EdBy? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory SharePost.fromJson(Map<String, dynamic> json) => SharePost(
    id: json["_id"],
    postType: json["postType"],
    contentTpe: json["contentTpe"],
    isDeleted: json["isDeleted"],
    comments: List<dynamic>.from(json["comments"].map((x) => x)),
    likes: List<String>.from(json["likes"].map((x) => x)),
    share: List<String>.from(json["share"].map((x) => x)),
    sharePostCreatedAt: DateTime.parse(json["created_At"]),
    subCategoryId: json["subCategoryId"],
    content: json["content"],
    image : json['image']!=null && json["image"]!="" ? "${GlobalConstants.imageLink}${json["image"]}" : "",

    // image: json["image"],
    createdBy: EdBy.fromJson(json["createdBy"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "postType": postType,
    "contentTpe": contentTpe,
    "isDeleted": isDeleted,
    "comments": List<dynamic>.from(comments!.map((x) => x)),
    "likes": List<dynamic>.from(likes!.map((x) => x)),
    "share": List<dynamic>.from(share!.map((x) => x)),
    "created_At": sharePostCreatedAt!.toIso8601String(),
    "subCategoryId": subCategoryId,
    "content": content,
    "image": image,
    "createdBy": createdBy!.toJson(),
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
  };
}

class SubCategoryId {
  SubCategoryId({
    this.id,
    this.nameAre,
    this.category,
    this.image,
    this.description,
    this.name,
    this.hashtag,
  });

  String? id;
  String? nameAre;
  List<Category>? category;
  String? image;
  String? description;
  String? name;
  String? hashtag;

  factory SubCategoryId.fromJson(Map<String, dynamic> json) => SubCategoryId(
    id: json["_id"],
    nameAre: json["name_are"],
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    image : json['image']!=null && json["image"]!="" ? "${GlobalConstants.imageLink}${json["image"]}" : "",
    // image: json["image"],
    description: json["description"],
    name: json["name"],
    hashtag: json["hashtag"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name_are": nameAre,
    "category": List<dynamic>.from(category!.map((x) => x.toJson())),
    "image": image,
    "description": description,
    "name": name,
    "hashtag": hashtag,
  };
}

class Category {
  Category({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}
