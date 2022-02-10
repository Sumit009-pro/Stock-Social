import 'package:stock_social/models/categories_model.dart';
import 'package:stock_social/models/global_constants.dart';

class PostModel{
  List<CommentsModel> comments=[];
  List<LikesModel> likes=[];
  List<String> share=[];
  String? id;
  String? postType;
  String? contentType;
  SubCategory? subCategoryId;
  bool? liked;
  String? likedId;
  String? content;
  String? image;
  CreatedBy? createdBy;
  DateTime? createdAt;
  SharePostModel? sharePost;

  PostModel(
      {required this.comments,
        required this.likes,
        this.id,
        this.subCategoryId,
        this.content,
        this.createdBy,
        this.liked,
        this.likedId,
        this.sharePost,
        required this.share,
        this.createdAt
       });

  PostModel.fromJson(Map<String, dynamic> json) {
  // print("data..$json");
   if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments.add(new CommentsModel.fromJson(v));
      });
    }
   if (json['likes'] != null) {
      likes = [];
      json['likes'].forEach((v) {
        likes.add(new LikesModel.fromJson(v));
      });
    }
   if (json['share'] != null) {
     share = [];
     json['share'].forEach((v) {
       share.add(v);
     });
   }
    id = json['_id'];
    createdAt=json['createdAt']!=null ?  DateTime.parse(json['createdAt']) : DateTime.now();
    image=json["image"]!=null && json["image"]!="" ? "${GlobalConstants.imageLink}${json["image"]}" : "";
    subCategoryId = json['subCategoryId'] != null
        ? new SubCategory.fromJson(json['subCategoryId'])
        : null;
    content = json['content']!=null ? json['content'].toString() : json['content'];
    postType = json['postType']!=null ? json['postType'].toString() : "";
    contentType = json['contentTpe']!=null ? json['contentTpe'].toString() : json['contentTpe'];
    createdBy = json['createdBy'] != null
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
   sharePost = json['sharePost'] != null
       ? new SharePostModel.fromJson(json['sharePost'])
       : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    if (this.likes != null) {
      data['likes'] = this.likes.map((v) => v.toJson()).toList();
    }
    data['createdAt']=this.createdAt;
    data['postType']=this.postType;
    data['contentTpe']=this.contentType;
    data['_id'] = this.id;
    data['image']=this.image;
    if (this.subCategoryId != null) {
      data['subCategoryId'] = this.subCategoryId!.toJson();
    }
    data['content'] = this.content;
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy!.toJson();
    }
    if (this.sharePost != null) {
      data['sharePost'] = this.sharePost!.toJson();
    }
    return data;
  }
}

/*class SubCategory {
  String? nameAre;
//  late List<Category> category;
  String? image;
  String? description;
  String? sId;
  String? name;
  String? hashtag;

  SubCategory(
      {this.nameAre,
        required this.category,
        this.image,
        this.description,
        this.sId,
        this.name,
        this.hashtag});

  SubCategory.fromJson(Map<String, dynamic> json) {
    nameAre = json['name_are'];
    if (json['category'] != null) {
      category = [];
      json['category'].forEach((v) {
        category.add(new Category.fromJson(v));
      });
    }
    image = json['image']!=null ? "${GlobalConstants.imageLink}SubCategory/${json['image']}" : "";
    description = json['description'];
    sId = json['_id'];
    name = json['name'];
    hashtag = json['hashtag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_are'] = this.nameAre;
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    data['description'] = this.description;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['hashtag'] = this.hashtag;
    return data;
  }
}*/


class CreatedBy {
  String? userName;
  String? profileImage;
  String? sId;
  String? email;

  CreatedBy({this.userName, this.profileImage, this.sId, this.email});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    profileImage = json['profileImage']!=null && json['profileImage']!="" ? "${GlobalConstants.imageLink}profile-pic/${json['profileImage']}" : "";
    sId = json['_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['profileImage'] = this.profileImage;
    data['_id'] = this.sId;
    data['email'] = this.email;
    return data;
  }

}

class CommentsModel {
  String? createdAt;
  String? sId;
  String? comment;
  CreatedBy? commentedBy;

  CommentsModel({this.createdAt, this.sId, this.comment, this.commentedBy});

  CommentsModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_At'];
    sId = json['_id'];
    comment = json['comment'];
    commentedBy = json['commentedBy'] != null
        ? new CreatedBy.fromJson(json['commentedBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_At'] = this.createdAt;
    data['_id'] = this.sId;
    data['comment'] = this.comment;
    if (this.commentedBy != null) {
      data['commentedBy'] = this.commentedBy!.toJson();
    }
    return data;
  }
}


class LikesModel {
  String? createdAt;
  String? id;
  CreatedBy? likedBy;

  LikesModel({this.createdAt, this.id, this.likedBy});

  LikesModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_At'];
    id = json['_id'];
    likedBy =
    json['likedBy'] != null ? new CreatedBy.fromJson(json['likedBy']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_At'] = this.createdAt;
    data['_id'] = this.id;
    if (this.likedBy != null) {
      data['likedBy'] = this.likedBy!.toJson();
    }
    return data;
  }

}

class SharePostModel {
  String? id;
  String? postType;
  String? contentTpe;
//  List<Null> comments;
//  List<Null> likes;
//  List<String> share;
//  String createdAt;
  String? subCategoryId;
  String? content;
  String? image;
  CreatedBy? createdBy;

  SharePostModel(
      {this.id,
        this.postType,
        this.contentTpe,
      /*  this.comments,
        this.likes,
        this.share,*/
        this.subCategoryId,
        this.content,
        this.image,
        this.createdBy,
      });

  SharePostModel.fromJson(Map<String, dynamic> json) {
   // print("ssss..$json");
    id = json['_id'];
    postType = json['postType'];
    contentTpe = json['contentTpe'];
   /* if (json['comments'] != null) {
      comments = new List<Null>();
      json['comments'].forEach((v) {
        comments.add(new Null.fromJson(v));
      });
    }
    if (json['likes'] != null) {
      likes = new List<Null>();
      json['likes'].forEach((v) {
        likes.add(new Null.fromJson(v));
      });
    }
    share = json['share'].cast<String>();*/
    subCategoryId = json['subCategoryId'];
    content = json['content'];
    image = json['image']!=null && json["image"]!="" ? "${GlobalConstants.imageLink}${json["image"]}" : "";
    createdBy = json['createdBy'] != null
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['postType'] = this.postType;
   /* data['contentTpe'] = this.contentTpe;
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    if (this.likes != null) {
      data['likes'] = this.likes.map((v) => v.toJson()).toList();
    }
    data['share'] = this.share;*/
    data['subCategoryId'] = this.subCategoryId;
    data['content'] = this.content;
    data['image'] = this.image;
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy!.toJson();
    }
    return data;
  }
}
