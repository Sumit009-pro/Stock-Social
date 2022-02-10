import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class UserModel extends ChangeNotifier {
  String? firstName;
  String? lastName;
  String? email;
  String? countryCode;
  String? phone;
  String? userId;
  String? loginId;
  String? profileImage;
  String? authToken;
  String? userName;
  String? about;
  String? shortAbout;
  String? coverImage;
  int? count=0;

  static UserModel? _singleTon;

  static UserModel? getInstance() => _singleTon ?? (_singleTon = UserModel());

  UserModel(
      {this.firstName,
        this.lastName,
      this.email,
      this.countryCode,
      this.phone,
      this.userId,
      this.loginId,
      this.profileImage,
      this.authToken,
      this.userName,
      this.about,
      this.shortAbout,
      this.coverImage,

        this.count
      });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final instance = getInstance();
    print("json...$json..");
    _singleTon?.firstName = json["userDetails"]["firstName"];
    _singleTon?.lastName = json["userDetails"]["lastName"];
    _singleTon?.email = json["userDetails"]["email"];
    _singleTon?.countryCode = json["userDetails"]["countryCode"];
    _singleTon?.phone = json["userDetails"]["phone"];
    _singleTon?.userId = json["userDetails"]["userId"];
    _singleTon?.loginId = json["userDetails"]["loginId"];
    _singleTon?.profileImage = json["userDetails"]["profileImage"];


    _singleTon?.userName = json["userDetails"]["userName"];
    _singleTon?.authToken = json["authToken"];

    _singleTon?.about = json["userDetails"]["about"];
    _singleTon?.shortAbout = json["userDetails"]["shortAbout"];
    _singleTon?.coverImage = json["userDetails"]["coverImage"];



    return instance!;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "userDetails": <String, dynamic>{
        "firstName": this.firstName,
        "lastName": this.lastName,
        "email": this.email,
        "countryCode": this.countryCode,
        "phone": this.phone,
        "userId": this.userId,
        "loginId": this.loginId,
        "profileImage": this.profileImage,
        "userName": this.userName,

        "about": this.about,
        "shortAbout": this.shortAbout,
        "coverImage": this.coverImage,

      },
      "authToken": this.authToken,
    };

    return json;
  }

  updateUserName(String userName) {
    this.userName = userName;
    saveToSharedPreferences();
    notifyListeners();
  }

  updateAbout(String about) {
    this.about = about;
    saveToSharedPreferences();
    notifyListeners();
  }

  updateShortAbout(String shortAbout) {
    this.shortAbout = shortAbout;
    saveToSharedPreferences();
    notifyListeners();
  }

  updateEmail(String email) {
    this.email = email;
    saveToSharedPreferences();
    notifyListeners();
  }

  updatePhone(String phone) {
    this.phone = phone;
    saveToSharedPreferences();
    notifyListeners();
  }

  updateProfileImage(String image) {
    this.profileImage = image;
    saveToSharedPreferences();
    notifyListeners();
  }

  updateCoverImage(String image) {
    this.coverImage = image;
    saveToSharedPreferences();
    notifyListeners();
  }

  setCount (int count){
    this.count = count;
    notifyListeners();
  }

  Future<bool> saveToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('userData', convert.jsonEncode(this.toJson()));
  }

  static Future<UserModel?> fromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    if (userData == null) {
      return null;
    }

    return UserModel.fromJson(convert.jsonDecode(userData));
  }
}
