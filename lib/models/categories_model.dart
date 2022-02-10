
import 'package:stock_social/models/global_constants.dart';

class Categories {
  late List<SubCategory> subCategory;
  String? id;
  String? name;
  String? nameAre;

  Categories(
      { required this.subCategory,
        this.id,
        this.name,
        this.nameAre,
      });

  Categories.fromJson(Map<String, dynamic> json) {
   // print("Categories json..$json");
    if (json['subCategory'] != null) {
      subCategory = [];
      json['subCategory'].forEach((v) {
        subCategory.add(new SubCategory.fromJson(v));
      });
    }
    id = json['_id']!=null ? json['_id'].toString() : json["_id"];
    name = json['name']!=null ? json['name'].toString() : json["name"];
    nameAre = json['name_are'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subCategory != null) {
      data['subCategory'] = this.subCategory.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.id;
    data['name'] = this.name;
    data['name_are'] = this.nameAre;
    return data;
  }
}


class SubCategory {
  String? nameAre;
  String? image;
  String? description;
  String? id;
  String? name;
  String? hashtag;
  bool? watchListed;
  int? postCount;

  SubCategory(
      {this.nameAre,
        this.image,
        this.description,
        this.id,
        this.name,
        this.hashtag,
        this.watchListed,
      this.postCount});

  SubCategory.fromJson(Map<String, dynamic> json) {
    nameAre = json['name_are'];
    image = json['image']!=null ? "${GlobalConstants.imageLink}SubCategory/${json['image']}" : "";
    description = json['description']!=null ? json['description'].toString() : json["description"];
    id = json['_id']!=null ? json['_id'].toString() : json["_id"];
    name = json['name']!=null ? json['name'].toString() : json["name"];
    hashtag = json['hashtag']!=null ? json['hashtag'].toString() : json["hashtag"];
    postCount = json['postCount']!=null ?json['postCount'] : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_are'] = this.nameAre;
    data['image'] = this.image;
    data['description'] = this.description;
    data['_id'] = this.id;
    data['name'] = this.name;
    data['hashtag'] = this.hashtag;
    data['postCount'] = this.postCount;
    return data;
  }
}


class Post {
  String? sId;
  String? createdAt;
  String? name;
  String? content;
  String? postType;

  Post({this.sId, this.createdAt, this.name, this.content, this.postType});

  Post.fromJson(Map<String, dynamic> json) {
    sId = json['_id']!=null ? json['_id'].toString() : json["_id"];
    createdAt = json['created_At']!=null ? json['created_At'].toString() : json["created_At"];
    name = json['name']!=null ? json['name'].toString() : json["name"];
    content = json['content']!=null ? json['content'].toString() : json["content"];
    postType = json['postType']!=null ? json['postType'].toString() : json["postType"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['created_At'] = this.createdAt;
    data['name'] = this.name;
    data['content'] = this.content;
    data['postType'] = this.postType;
    return data;
  }

}
