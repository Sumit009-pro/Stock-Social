// To parse this JSON data, do
//
//     final postFetchModel = postFetchModelFromJson(jsonString);

import 'dart:convert';

import 'global_constants.dart';

PostFetchModel postFetchModelFromJson(String str) =>
    PostFetchModel.fromJson(json.decode(str));

String postFetchModelToJson(PostFetchModel data) => json.encode(data.toJson());

class PostFetchModel {
  PostFetchModel({
    this.success,
    this.statuscode,
    this.message,
    this.responseData,
  });

  bool? success;
  int? statuscode;
  String? message;
  ResponseData? responseData;

  factory PostFetchModel.fromJson(Map<String, dynamic> json) => PostFetchModel(
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
    this.post,
    this.getUserData,
    this.getCount,
    this.activeCheck,
  });

  List<Post>? post;
  GetUserData? getUserData;
  GetCount? getCount;
  ActiveCheck? activeCheck;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        post: List<Post>.from(json["post"].map((x) => Post.fromJson(x))),
        getUserData: GetUserData.fromJson(json["getUserData"]),
        getCount: GetCount.fromJson(json["getCount"]),
        activeCheck: ActiveCheck.fromJson(json["activeCheck"]),
      );

  Map<String, dynamic> toJson() => {
        "post": List<dynamic>.from(post!.map((x) => x.toJson())),
        "getUserData": getUserData!.toJson(),
        "getCount": getCount!.toJson(),
        "activeCheck": activeCheck!.toJson(),
      };
}

class ActiveCheck {
  ActiveCheck({
    this.follow,
    this.block,
  });

  bool? follow;
  bool? block;

  factory ActiveCheck.fromJson(Map<String, dynamic> json) => ActiveCheck(
        follow: json["follow"],
        block: json["block"],
      );

  Map<String, dynamic> toJson() => {
        "follow": follow,
        "block": block,
      };
}

class GetCount {
  GetCount({
    this.followers,
    this.following,
    this.posts,
  });

  int? followers;
  int? following;
  int? posts;

  factory GetCount.fromJson(Map<String, dynamic> json) => GetCount(
        followers: json["followers"],
        following: json["following"],
        posts: json["posts"],
      );

  Map<String, dynamic> toJson() => {
        "followers": followers,
        "following": following,
        "posts": posts,
      };
}

class GetUserData {
  GetUserData({
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

  UserName? userName;
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
  GetUserDataId? id;
  String? firstName;
  String? lastName;
  Email? email;
  String? password;
  DateTime? dateOfBirth;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory GetUserData.fromJson(Map<String, dynamic> json) => GetUserData(
        userName: userNameValues.map[json["userName"]],
        countryCode: json["countryCode"],
        phone: json["phone"],
        profileImage: json['profileImage'] != null && json['profileImage'] != ""
            ? "${GlobalConstants.imageLink}profile-pic/${json['profileImage']}"
            : "",

        // profileImage: profileImageValues.map[json["profileImage"]],
        coverImage: json["coverImage"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        isDisable: json["isDisable"],
        badgeCount: json["badgeCount"],
        about: json["about"],
        shortAbout: json["shortAbout"],
        promotionalEmail: json["promotionalEmail"],
        id: getUserDataIdValues.map[json["_id"]],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: emailValues.map[json["email"]],
        password: json["password"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userNameValues.reverse![userName],
        "countryCode": countryCode,
        "phone": phone,
        "profileImage": profileImageValues.reverse![profileImage],
        "coverImage": coverImage,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "isDisable": isDisable,
        "badgeCount": badgeCount,
        "about": about,
        "shortAbout": shortAbout,
        "promotionalEmail": promotionalEmail,
        "_id": getUserDataIdValues.reverse![id],
        "firstName": firstName,
        "lastName": lastName,
        "email": emailValues.reverse![email],
        "password": password,
        "dateOfBirth": dateOfBirth!.toIso8601String(),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}

enum Email {
  RT_GMAIL_COM,
  AEAR026_GMAIL_COM,
  RADHAK_GMAIL_COM,
  SHAHID31346_GMAIL_COM,
  SUBHAJITSINGHA1992_GMAIL_COM,
  DONA1_GMAIL_COM
}

final emailValues = EnumValues({
  "aear026@gmail.com": Email.AEAR026_GMAIL_COM,
  "dona1@gmail.com": Email.DONA1_GMAIL_COM,
  "radhak@gmail.com": Email.RADHAK_GMAIL_COM,
  "rt@gmail.com": Email.RT_GMAIL_COM,
  "shahid31346@gmail.com": Email.SHAHID31346_GMAIL_COM,
  "subhajitsingha1992@gmail.com": Email.SUBHAJITSINGHA1992_GMAIL_COM
});

enum GetUserDataId {
  THE_614_C6_AAB0_CAEBA68_E0_F6851_F,
  THE_61_A949_D8_A03_DF26_CD979_AA21,
  THE_615171_C5_B880_AD4367_E75_E6_F,
  THE_6158_B15263_FEA640_D473_A56_D,
  THE_61_A63638541_FF14209_B6_DCE6,
  THE_614883_F10_EBC266_EFB1073_C3
}

final getUserDataIdValues = EnumValues({
  "614883f10ebc266efb1073c3": GetUserDataId.THE_614883_F10_EBC266_EFB1073_C3,
  "614c6aab0caeba68e0f6851f": GetUserDataId.THE_614_C6_AAB0_CAEBA68_E0_F6851_F,
  "615171c5b880ad4367e75e6f": GetUserDataId.THE_615171_C5_B880_AD4367_E75_E6_F,
  "6158b15263fea640d473a56d": GetUserDataId.THE_6158_B15263_FEA640_D473_A56_D,
  "61a63638541ff14209b6dce6": GetUserDataId.THE_61_A63638541_FF14209_B6_DCE6,
  "61a949d8a03df26cd979aa21": GetUserDataId.THE_61_A949_D8_A03_DF26_CD979_AA21
});

enum ProfileImage {
  CUSTOMERPROFILE_8371632754331_JPG,
  EMPTY,
  CUSTOMERPROFILE_6871632754131_JPG,
  CUSTOMERPROFILE_7261638283341_JPG,
  CUSTOMERPROFILE_4491632753941_PNG
}

final profileImageValues = EnumValues({
  "customerprofile-449-1632753941.png":
      ProfileImage.CUSTOMERPROFILE_4491632753941_PNG,
  "customerprofile-687-1632754131.jpg":
      ProfileImage.CUSTOMERPROFILE_6871632754131_JPG,
  "customerprofile-726-1638283341.jpg":
      ProfileImage.CUSTOMERPROFILE_7261638283341_JPG,
  "customerprofile-837-1632754331.jpg":
      ProfileImage.CUSTOMERPROFILE_8371632754331_JPG,
  "": ProfileImage.EMPTY
});

enum UserName { RADHA, ABOOOD, KUMARIRADHA, SHAHID31346, SUBHAJIT601, DONA1 }

final userNameValues = EnumValues({
  "Aboood": UserName.ABOOOD,
  "dona1": UserName.DONA1,
  "kumariradha": UserName.KUMARIRADHA,
  "Radha": UserName.RADHA,
  "shahid31346": UserName.SHAHID31346,
  "subhajit601": UserName.SUBHAJIT601
});

class Post {
  Post({
    this.postType,
    this.contentTpe,
    this.isDeleted,
    this.comments,
    this.likes,
    this.liked,
    this.likedId,
    this.share,
    this.postCreatedAt,
    this.id,
    this.subCategoryId,
    this.content,
    this.image,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.sharePost,
  });

  PostType? postType;
  ContentTpe? contentTpe;
  bool? isDeleted;
  List<Comment>? comments;
  List<Like>? likes;
  bool? liked;
  String? likedId;
  List<String>? share;
  DateTime? postCreatedAt;
  String? id;
  SubCategoryId? subCategoryId;
  String? content;
  String? image;
  EdBy? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  SharePost? sharePost;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        postType: postTypeValues.map[json["postType"]],
        contentTpe: contentTpeValues.map[json["contentTpe"]],
        isDeleted: json["isDeleted"],
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
        share: List<String>.from(json["share"].map((x) => x)),
        postCreatedAt: DateTime.parse(json["created_At"]),
        id: json["_id"],
        subCategoryId: SubCategoryId.fromJson(json["subCategoryId"]),
        content: json["content"],
        image: json["image"] != null && json["image"] != ""
            ? "${GlobalConstants.imageLink}${json["image"]}"
            : "",

        // image: postImageValues.map[json["image"]],
        createdBy: EdBy.fromJson(json["createdBy"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        sharePost: json["sharePost"] == null
            ? null
            : SharePost.fromJson(json["sharePost"]),
      );

  Map<String, dynamic> toJson() => {
        "postType": postTypeValues.reverse![postType],
        "contentTpe": contentTpeValues.reverse![contentTpe],
        "isDeleted": isDeleted,
        "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
        "likes": List<dynamic>.from(likes!.map((x) => x.toJson())),
        "share": List<dynamic>.from(share!.map((x) => x)),
        "created_At": postCreatedAt!.toIso8601String(),
        "_id": id,
        "subCategoryId": subCategoryId!.toJson(),
        "content": content,
        "image": postImageValues.reverse![image],
        "createdBy": createdBy!.toJson(),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "sharePost": sharePost == null ? null : sharePost!.toJson(),
      };
}

class Comment {
  Comment({
    this.createdAt,
    this.id,
    this.comment,
    this.commentedBy,
  });

  DateTime? createdAt;
  String? id;
  String? comment;
  EdBy? commentedBy;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        createdAt: DateTime.parse(json["created_At"]),
        id: json["_id"],
        comment: json["comment"],
        commentedBy: EdBy.fromJson(json["commentedBy"]),
      );

  Map<String, dynamic> toJson() => {
        "created_At": createdAt!.toIso8601String(),
        "_id": id,
        "comment": comment,
        "commentedBy": commentedBy!.toJson(),
      };
}

class EdBy {
  EdBy({
    this.userName,
    this.profileImage,
    this.id,
    this.email,
  });

  String? userName;
  String? profileImage;
  String? id;
  String? email;

  factory EdBy.fromJson(Map<String, dynamic> json) => EdBy(
        userName: json['userName'] != null
            ? json['userName'].toString()
            : json["userName"],
    profileImage: json['profileImage'] != null && json['profileImage'] != ""
        ? "${GlobalConstants.imageLink}profile-pic/${json['profileImage']}"
        : "",
        id: json['_id'] != null ? json['_id'].toString() : json["_id"],
        email: json['email'] != null ? json['email'].toString() : json["email"],
        // userName: userNameValues.map[json["userName"]],
        // profileImage: profileImageValues.map[json["profileImage"]],
        // id: getUserDataIdValues.map[json["_id"]],
        // email: emailValues.map[json["email"]],
      );

  Map<String, dynamic> toJson() => {
        "userName": userNameValues.reverse![userName],
        "profileImage": profileImageValues.reverse![profileImage],
        "_id": getUserDataIdValues.reverse![id],
        "email": emailValues.reverse![email],
      };
}

enum ContentTpe { POST, QUESTION }

final contentTpeValues =
    EnumValues({"post": ContentTpe.POST, "question": ContentTpe.QUESTION});

enum PostImage { EMPTY, POST_614_C6_AAB0_CAEBA68_E0_F6851_F1632919338252_PNG }

final postImageValues = EnumValues({
  "": PostImage.EMPTY,
  "/post/614c6aab0caeba68e0f6851f1632919338252.png":
      PostImage.POST_614_C6_AAB0_CAEBA68_E0_F6851_F1632919338252_PNG
});

class Like {
  Like({
    this.createdAt,
    this.id,
    this.likedBy,
  });

  DateTime? createdAt;
  String? id;
  EdBy? likedBy;

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        createdAt: DateTime.parse(json["created_At"]),
        id: json["_id"],
        likedBy: EdBy.fromJson(json["likedBy"]),
      );

  Map<String, dynamic> toJson() => {
        "created_At": createdAt!.toIso8601String(),
        "_id": id,
        "likedBy": likedBy!.toJson(),
      };
}

enum PostType { NORMAL, SHARE }

final postTypeValues =
    EnumValues({"normal": PostType.NORMAL, "share": PostType.SHARE});

class SharePost {
  SharePost({
    this.postType,
    this.contentTpe,
    this.isDeleted,
    this.comments,
    this.likes,
    this.share,
    this.sharePostCreatedAt,
    this.id,
    this.subCategoryId,
    this.content,
    this.image,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.sharePost,
  });

  PostType? postType;
  ContentTpe? contentTpe;
  bool? isDeleted;
  List<String>? comments;
  List<String>? likes;
  List<String>? share;
  DateTime? sharePostCreatedAt;
  String? id;
  Id? subCategoryId;
  String? content;
  String? image;
  EdBy? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? sharePost;

  factory SharePost.fromJson(Map<String, dynamic> json) => SharePost(
        postType: postTypeValues.map[json["postType"]],
        contentTpe: contentTpeValues.map[json["contentTpe"]],
        isDeleted: json["isDeleted"],
        comments: List<String>.from(json["comments"].map((x) => x)),
        likes: List<String>.from(json["likes"].map((x) => x)),
        share: List<String>.from(json["share"].map((x) => x)),
        sharePostCreatedAt: DateTime.parse(json["created_At"]),
        id: json["_id"],
        subCategoryId: idValues.map[json["subCategoryId"]],
        content: json["content"],
        image: json["image"]!=null && json["image"]!="" ? "${GlobalConstants.imageLink}${json["image"]}" : "",
        createdBy: EdBy.fromJson(json["createdBy"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        sharePost: json["sharePost"] == null ? null : json["sharePost"],
      );

  Map<String, dynamic> toJson() => {
        "postType": postTypeValues.reverse![postType],
        "contentTpe": contentTpeValues.reverse![contentTpe],
        "isDeleted": isDeleted,
        "comments": List<dynamic>.from(comments!.map((x) => x)),
        "likes": List<dynamic>.from(likes!.map((x) => x)),
        "share": List<dynamic>.from(share!.map((x) => x)),
        "created_At": sharePostCreatedAt!.toIso8601String(),
        "_id": id,
        "subCategoryId": idValues.reverse![subCategoryId],
        "content": content,
        "image": postImageValues.reverse![image],
        "createdBy": createdBy!.toJson(),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "sharePost": sharePost == null ? null : sharePost,
      };
}

enum Id {
  THE_614814_FB5_DD2694_A3_BC4_DFDC,
  THE_614845_F65_DD2694_A3_BC4_E012,
  THE_614845845_DD2694_A3_BC4_E00_B,
  THE_614846_B45_DD2694_A3_BC4_E02_C,
  THE_6148451_C5_DD2694_A3_BC4_E004
}

final idValues = EnumValues({
  "614814fb5dd2694a3bc4dfdc": Id.THE_614814_FB5_DD2694_A3_BC4_DFDC,
  "6148451c5dd2694a3bc4e004": Id.THE_6148451_C5_DD2694_A3_BC4_E004,
  "614845845dd2694a3bc4e00b": Id.THE_614845845_DD2694_A3_BC4_E00_B,
  "614845f65dd2694a3bc4e012": Id.THE_614845_F65_DD2694_A3_BC4_E012,
  "614846b45dd2694a3bc4e02c": Id.THE_614846_B45_DD2694_A3_BC4_E02_C
});

class SubCategoryId {
  String? nameAre;
  String? image;
  List<Category>? category;

  String? description;
  String? id;
  String? name;
  String? hashtag;

  // bool? watchListed;
  // int? postCount;

  SubCategoryId({
    this.nameAre,
    this.image,
    this.category,
    this.description,
    this.id,
    this.name,
    this.hashtag,
    // this.watchListed,
    // this.postCount
  });

  SubCategoryId.fromJson(Map<String, dynamic> json) {
    nameAre = json['name_are'];
    if (json['category'] != null) {
      category = [];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    image = json['image'] != null
        ? "${GlobalConstants.imageLink}SubCategory/${json['image']}"
        : "";
    description = json['description'] != null
        ? json['description'].toString()
        : json["description"];
    id = json['_id'] != null ? json['_id'].toString() : json["_id"];
    name = json['name'] != null ? json['name'].toString() : json["name"];
    hashtag =
        json['hashtag'] != null ? json['hashtag'].toString() : json["hashtag"];
    // postCount = json['postCount']!=null ?json['postCount'] : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_are'] = this.nameAre;
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    data['description'] = this.description;
    data['_id'] = this.id;
    data['name'] = this.name;
    data['hashtag'] = this.hashtag;
    // data['postCount'] = this.postCount;
    return data;
  }
}

// class SubCategoryId {
//   SubCategoryId({
//     this.nameAre,
//     this.category,
//     this.image,
//     this.description,
//     this.id,
//     this.name,
//     this.hashtag,
//   });
//
//   String? nameAre;
//   List<Category>? category;
//   SubCategoryIdImage? image;
//   Description? description;
//   Id? id;
//   SubCategoryIdName? name;
//   Hashtag? hashtag;
//
//   factory SubCategoryId.fromJson(Map<String, dynamic> json) => SubCategoryId(
//
//
//       nameAre = json['name_are'];
//       category= List<Category>.from(json["category"].map((x) => Category.fromJson(x)));
//
//   image = json['image']!=null ? "${GlobalConstants.imageLink}SubCategory/${json['image']}" : "";
//   description = json['description']!=null ? json['description'].toString() : json["description"];
//   id = json['_id']!=null ? json['_id'].toString() : json["_id"];
//   name = json['name']!=null ? json['name'].toString() : json["name"];
//   hashtag = json['hashtag']!=null ? json['hashtag'].toString() : json["hashtag"];
//   // postCount = json['postCount']!=null ?json['postCount'] : 0;
//
//
//     // nameAre: nameAreValues.map[json["name_are"]],
//     // image: subCategoryIdImageValues.map[json["image"]],
//     // description: descriptionValues.map[json["description"]],
//     // id: idValues.map[json["_id"]],
//     // // name : json['name']!=null ? json['name'].toString() : json["name"],
//     // name: subCategoryIdNameValues.map[json["name"]],
//     // hashtag: hashtagValues.map[json["hashtag"]],
//   );
//
//   Map<String, dynamic> toJson(){
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['name_are'] = this.nameAre;
//   data['image'] = this.image;
//   data['description'] = this.description;
//   data['_id'] = this.id;
//   data['name'] = this.name;
//   data['hashtag'] = this.hashtag;
//   return data;
//   //   return {
//   //   "name_are": nameAreValues.reverse![nameAre],
//   //   "category": List<dynamic>.from(category!.map((x) => x.toJson())),
//   //   "image": subCategoryIdImageValues.reverse![image],
//   //   "description": descriptionValues.reverse![description],
//   //   "_id": idValues.reverse![id],
//   //   "name": subCategoryIdNameValues.reverse![name],
//   //   "hashtag": hashtagValues.reverse![hashtag],
//   // };
//   }
// }

class Category {
  Category({
    this.id,
    this.name,
  });

  CategoryId? id;
  CategoryName? name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: categoryIdValues.map[json["_id"]],
        name: categoryNameValues.map[json["name"]],
      );

  Map<String, dynamic> toJson() => {
        "_id": categoryIdValues.reverse![id],
        "name": categoryNameValues.reverse![name],
      };
}

enum CategoryId {
  THE_61449_AED2855_A54381838336,
  THE_61449_AFD2855_A54381838339,
  THE_6148464_B5_DD2694_A3_BC4_E018
}

final categoryIdValues = EnumValues({
  "61449aed2855a54381838336": CategoryId.THE_61449_AED2855_A54381838336,
  "61449afd2855a54381838339": CategoryId.THE_61449_AFD2855_A54381838339,
  "6148464b5dd2694a3bc4e018": CategoryId.THE_6148464_B5_DD2694_A3_BC4_E018
});

enum CategoryName { BEAUTY, MARRIAGE, HEALTH }

final categoryNameValues = EnumValues({
  "Beauty": CategoryName.BEAUTY,
  "Health": CategoryName.HEALTH,
  "Marriage": CategoryName.MARRIAGE
});

enum Description { SALONS, JEWELLERY, YOGA, MAKEUP, DIET }

final descriptionValues = EnumValues({
  "diet": Description.DIET,
  "jewellery": Description.JEWELLERY,
  "Makeup": Description.MAKEUP,
  "Salons": Description.SALONS,
  "yoga": Description.YOGA
});

enum Hashtag { SALONS, JEWELLERY, YOGA, MAKEUP, DIET }

final hashtagValues = EnumValues({
  "#DIET": Hashtag.DIET,
  "#JEWELLERY": Hashtag.JEWELLERY,
  "#MAKEUP": Hashtag.MAKEUP,
  "#SALONS": Hashtag.SALONS,
  "#YOGA": Hashtag.YOGA
});

enum SubCategoryIdImage {
  IMAGE_241632115016_JPG,
  IMAGE_5831632126453_JPG,
  IMAGE_5431632126644_JPG,
  IMAGE_8771632126236_JPG,
  IMAGE_5531632126594_JPG
}

final subCategoryIdImageValues = EnumValues({
  "image-24-1632115016.jpg": SubCategoryIdImage.IMAGE_241632115016_JPG,
  "image-543-1632126644.jpg": SubCategoryIdImage.IMAGE_5431632126644_JPG,
  "image-553-1632126594.jpg": SubCategoryIdImage.IMAGE_5531632126594_JPG,
  "image-583-1632126453.jpg": SubCategoryIdImage.IMAGE_5831632126453_JPG,
  "image-877-1632126236.jpg": SubCategoryIdImage.IMAGE_8771632126236_JPG
});

enum SubCategoryIdName { SALONS, JEWELLERY, YOGA, MAKEUP, DIET }

final subCategoryIdNameValues = EnumValues({
  "Diet": SubCategoryIdName.DIET,
  "Jewellery": SubCategoryIdName.JEWELLERY,
  "Makeup": SubCategoryIdName.MAKEUP,
  "Salons": SubCategoryIdName.SALONS,
  "Yoga": SubCategoryIdName.YOGA
});

enum NameAre { EMPTY, NAME_ARE, PURPLE, FLUFFY, TENTACLED }

final nameAreValues = EnumValues({
  "رياضات": NameAre.EMPTY,
  "ميك أب": NameAre.FLUFFY,
  "مجوهرات": NameAre.NAME_ARE,
  "اليوجا": NameAre.PURPLE,
  "حمية": NameAre.TENTACLED
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
