import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io' show File, Platform;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'user_model.dart';
import 'package:dio/dio.dart';

abstract class API {

  static final String _baseUrl = 'http://nodeserver.mydevfactory.com:8086/api';
  static final String _imageUrl = 'http://nodeserver.mydevfactory.com:8086/img/profile-pic/';

  // method =2 for post, method=1 for get
  static Future<Map<String, dynamic>> makeRequest(String path,   {Map<String, String>? headers,
      dynamic? body, String? storageKey,  bool authRequired = true, int method=2 }) async {
    print(path);
    try {
      if (authRequired) {
        headers = headers ?? <String, String>{};
        headers['Authorization'] ='Bearer ${UserModel.getInstance()?.authToken}';
      }

      var response;

       print("${Uri.parse(_baseUrl + path)}\n $body\n$headers");

        if(method==1) response= await http.get(Uri.parse(_baseUrl + path),headers: headers,);
        else response= await http.post(Uri.parse(_baseUrl + path),headers: headers, body: body);

      print("response from server ${response.statusCode} ${response.body}");

     // var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

        if (storageKey != null) {
          if (jsonResponse["STATUSCODE"] == 200) {
            final prefs = await SharedPreferences.getInstance();
            prefs.setString(storageKey, response.body);
          }
        }
        return jsonResponse;
      }
      else {
        print('Request failed with status: ${response.statusCode}.');
        return {
          "success": false,
          "STATUSCODE": response.statusCode,
       //   "message":jsonResponse["message"]
          "message": "Something Wrong",
        };
      }
    } catch (ex, stack) {
      print(ex);
      print(stack);
      var msg = ex.toString();
      if (RegExp(r'socketException', caseSensitive: false).hasMatch(msg)) {
        msg = "Something wrong, please try again..";
      }

      return {
        "success": false,
        "message": msg,
      };
    }
  }

  static Future<Map<String, dynamic>> register(
      Map<String, dynamic> body) async {
    print('Registered called $body');
    return makeRequest('/user/register', body: body, authRequired: false);
  }

  static Future<Map<String, dynamic>> fetchCategoriesData() async {
    print('Category called');
    return makeRequest('/user/category', body: {}, authRequired: false);
  }

  static Future<Map<String, dynamic>> fetchUserWatchListedData() async {
    print('User Watchlist called');
    return makeRequest('/post/users/watch/list', method: 1, authRequired: true);
  }

  static Future<Map<String, dynamic>> fetchCategoriesSortBy(String value) async {
    print('Categories sort by called');
    return makeRequest('/post/dashboard/category/sort/$value', method: 1, authRequired: true);
  }

  static Future<Map<String, dynamic>> fetchWatchListData() async {
    print('WatchList called');
    return makeRequest('/post/watch/list',authRequired: true,method: 1);
  }

  static Future<Map<String, dynamic>> fetchAllPostData(String id) async {
    print('Post list called');
    return makeRequest('/post/users/$id',authRequired: true,method: 1);
  }

  static Future<Map<String, dynamic>> fetchAllPostDetails(String id) async {
    print('Post list called');
    return makeRequest('/post/users/postDetails/$id',authRequired: true);
  }

  static Future<Map<String, dynamic>> fetchTopTrendingPost() async {
    print('Top Trending Post list called');
    return makeRequest('/post/top/trending',authRequired: true,method: 1);
  }

  static Future<Map<String, dynamic>> fetchAllPostDataByCategoryId(String categoryId,String type) async {
    print('Post list called');
    return makeRequest('/post/category/$categoryId?type=$type',authRequired: true,method: 1);
  }

  static Future<Map<String, dynamic>> fetchAllTopTrendingPost(String categoryId) async {
    print('Top Post list called');
    return makeRequest('/post/trending/category/$categoryId',authRequired: true,method: 1);
  }

  static Future<Map<String, dynamic>> addLikes(String postId) async {
    print('Likes called');
    return makeRequest('/post/like/$postId',authRequired: true,method: 1);
  }

  static Future<Map<String, dynamic>> removeLikes(String postId) async {
    print('UnLikes called');
    return makeRequest('/post/unlike/$postId',authRequired: true,method: 1);
  }

  static Future<Map<String, dynamic>> addToWatchList(Map<String, dynamic> body) async {
    print('Add to watchlist called $body');
    return makeRequest('/post/watch/add', body: body, authRequired: true);
  }

  static Future<Map<String, dynamic>> removeFromWatchList(Map<String, dynamic> body) async {
    print('Remove from watchlist called $body');
    return makeRequest('/post/watch/remove', body: body, authRequired: true);
  }

  static Future<Map<String, dynamic>> userFollowUnfollow(Map<String, dynamic> body) async {
    print('User follow unfollow called $body');
    return makeRequest('/user/userFollowUnfollow', body: body, authRequired: true);
  }

  static Future<Map<String, dynamic>> addPost(Map<String, dynamic> body) async {
    print('Post called $body');
    return makeRequest('/post/create', body: body, authRequired: true);
  }

  static Future<Map<String, dynamic>> sharePost(Map<String, dynamic> body) async {
    print('Share called $body');
    return makeRequest('/post/share', body: body, authRequired: true);
  }

  static Future<Map<String, dynamic>> deletePost(String postId) async {
    print('Delete called ');
    return makeRequest('/post/delete/$postId', body: {}, authRequired: true);
  }

  static Future<Map<String, dynamic>> addReport(String postId) async {
    print('Report called ');
    return makeRequest('/post/report/$postId', body: {}, authRequired: true);
  }

  static Future<Map<String, dynamic>> addComment(Map<String, dynamic> body,String postId) async {
    print('Comment called $body');
    return makeRequest('/post/comment/$postId', body: body, authRequired: true);
  }

  static Future<Map<String, dynamic>> fetchCount(Map<String, dynamic> body) async {
    print('Count called');
    return makeRequest('/user/followingFollowersCount', body: body,authRequired: true);
  }

  static Future<Map<String, dynamic>> fetchAllFollowing(String id) async {
    print('Following list called');
    return makeRequest('/user/following/List?userId=$id', body: {},authRequired: true);
  }

  static Future<Map<String, dynamic>> fetchAllFollowers(String id) async {
    print('Follower list called');
    return makeRequest('/user/followers/List?userId=$id', body: {},authRequired: true,);
  }

  static Future<Map<String, dynamic>> fetchNotification(String id) async {
    print('Notification list called');
    return makeRequest('/post/users/notificationList/$id', body: {},authRequired: true,method: 1);
  }

  static Future<Map<String, dynamic>> fetchBlockList(Map<String, dynamic> body) async {
    print('Follower list called');
    return makeRequest('/user/blockList', body: body,authRequired: true,);
  }

  static Future<Map<String, dynamic>> fetchActivityCount(Map<String, dynamic> body) async {
    print('activityCount list called');
    return makeRequest('/user/activityCount', body: body,authRequired: true,);
  }

  static Future<Map<String, dynamic>> search(String type,String r) async {
    print('Search list called');
    return makeRequest('/post/global/search?type=$type&keyword=$r',authRequired: true,);
  }

  static Future<Map<String, dynamic>> blockUser(Map<String, dynamic> body) async {
    print('Block User called');
    return makeRequest('/user/block', body: body,authRequired: true,);
  }

  static Future<Map<String, dynamic>> unBlockUser(Map<String, dynamic> body) async {
    print('Block User called');
    return makeRequest('/user/unblock', body: body,authRequired: true,);
  }

  static Future<Map<String, dynamic>> about(Map<String, dynamic> body) async {
    print('About called');
    return makeRequest('/company/getCmsPages', body: body,authRequired: true,);
  }

  static Future<Map<String, dynamic>> help(Map<String, dynamic> body) async {
    print('help called');
    return makeRequest('/company/getCmsPages', body: body,authRequired: true,);
  }

  static Future<Map<String, dynamic>> terms(Map<String, dynamic> body) async {
    print('terms called');
    return makeRequest('/company/getCmsPages', body: body,authRequired: true,);
  }

  static Future<Map<String, dynamic>> privacy(Map<String, dynamic> body) async {
    print('privacy called');
    return makeRequest('/company/getCmsPages', body: body,authRequired: true,);
  }

  static Future<Map<String, dynamic>> notificationSetttingsGet(String userId) async {
    print('getNotificationData called');
    return makeRequest('/post/users/getNotificationData/$userId', body: {},authRequired: true,);
  }

  static Future<Map<String, dynamic>> notificationSetttingsPost(Map<String, dynamic> body,String userId) async {
    print('updateNotificationData called');
    return makeRequest('/post/users/updateNotificationData/$userId', body: body,authRequired: true,);
  }

  static Future<Map<String, dynamic>> login(
      String user, String password) async {
    print('login called');
    final response = await makeRequest('/user/login',
        body: <String, dynamic>{
          "email": user,
          "password": password,
          "deviceToken": sharedPreferences!.getString("device_id"),
          "appType": "ANDROID",
        },
        authRequired: false,
        storageKey: "userData");

    if (response["STATUSCODE"] == 200) {
      print("calling usermodel");
      UserModel.fromJson(response["response_data"]);
    }

    return response;
  }

  static Future<Map<String, dynamic>> socialLogin(
      Map<String, dynamic> body) async {
    print('login called');
    final response = await makeRequest('/user/socialLogin',
        body: body,
        authRequired: false,
        storageKey: "userData");

    if (response["STATUSCODE"] == 200) {
      print("calling usermodel");
      UserModel.fromJson(response["response_data"]);
    }

    return response;
  }

  static Future<Map<String, dynamic>> forgotPassword(
      Map<String, dynamic> body) async {
    print('Forgot Password called $body');
    return makeRequest('/user/forgotPassword', body: body, authRequired: false);
  }

  static Future<Map<String, dynamic>> resetPassword(
      Map<String, dynamic> body) async {
    print('reset Password called $body');
    return makeRequest('/user/resetPassword', body: body, authRequired: false);
  }

  static Future<Map<String, dynamic>> verifyUser(String userId) async {
    print('Verify User called $userId');
    final response = await makeRequest('/user/verifyUser',
        body: <String, dynamic>{
          "userId": userId,
          "deviceToken": sharedPreferences!.getString("device_id"),
          "appType": "ANDROID",
        },
        authRequired: false,
        storageKey: "userData");

    if (response["STATUSCODE"] == 200) {
      print("calling usermodel");
      UserModel.fromJson(response["response_data"]);
    }

    return response;
  }

  static Future<Map<String, dynamic>> viewProfile(
      Map<String, dynamic> body) async {
    print('View Profile called $body');
    return makeRequest('/user/viewProfile', body: body);
  }

  static Future<Map<String, dynamic>> changeUsername(String username) async {
    print('Username called $username');
    final userDetails = UserModel.getInstance();
    userDetails?.updateUserName(username);

    return makeRequest('/user/changeUsername', body: {
      "userId": userDetails?.userId,
      "loginId": userDetails?.loginId,
      "appType": "ANDROID",
      "userName": username
    });
  }

  static Future<Map<String, dynamic>> changeAbout(String about) async {
    print('Username called $about');
    final userDetails = UserModel.getInstance();
    userDetails?.updateAbout(about);

    return makeRequest('/user/changeAbout', body: {
      "userId": userDetails?.userId,
      "loginId": userDetails?.loginId,
      "appType": "ANDROID",
      "about": about,
      "shortAbout":userDetails?.shortAbout
    });
  }

  static Future<Map<String, dynamic>> shortAbout(String shortAbout) async {
    print('Username called $shortAbout');
    final userDetails = UserModel.getInstance();
    userDetails?.updateShortAbout(shortAbout);

    return makeRequest('/user/changeAbout', body: {
      "userId": userDetails?.userId,
      "loginId": userDetails?.loginId,
      "appType": "ANDROID",
      "shortAbout": shortAbout,
      "about":userDetails?.about
    });
  }

  static Future<Map<String, dynamic>> updateUserPhone(String phone) async {
    print('Username called $phone');
    final userDetails = UserModel.getInstance();
    userDetails?.updatePhone(phone);
    return makeRequest('/user/updateUserPhone', body: {
      "userId": userDetails?.userId,
      "loginId": userDetails?.loginId,
      "appType": "ANDROID",
      "countryCode": "+91",
      "phone": phone,
      "sid": "1234"
    });
  }

  static Future<Map<String, dynamic>> updateUserEmail(String email) async {
    print('Username called $email');
    final userDetails = UserModel.getInstance();
    userDetails?.updateEmail(email);
    return makeRequest('/user/updateUserEmail', body: {
      "userId": userDetails?.userId,
      "loginId": userDetails?.loginId,
      "appType": "ANDROID",
      "email": email
    });
  }

  static Future<Map<String, dynamic>> changePassword(
      Map<String, dynamic> body) async {
    print('Password called $body');
    final userDetails = UserModel.getInstance();

    body.addAll({
      "userId": userDetails?.userId,
      "loginId": userDetails?.loginId,
      "appType": "ANDROID",
    });
    return makeRequest('/user/changePassword', body: body);
  }

  static Future<Map<String, dynamic>> logout() async {
    print('logout called');
    final userDetails = UserModel.getInstance();

    final body = {
      "userId": userDetails?.userId,
      "loginId": userDetails?.loginId,
      "appType": "ANDROID",
    };
    final response = await makeRequest('/user/logout', body: body);

    if (response["STATUSCODE"] == 200) {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove("userData");
    }

    return response;
  }

  static Future<Map<String, dynamic>> customerVerifyUser(
      {String? email, String? countryCode, String? phoneNumber}) async {
    print('customerVerifyUser called');
    final userDetails = UserModel.getInstance();

    final body = {
      "userId": userDetails?.userId,
      "loginId": userDetails?.loginId,
      "appType": "ANDROID",
      "verifyType": email != null ? "EMAIL" : "PHONE",
      "email": email,
    };

    if (email != null) {
      body["email"] = email;
    } else {
      body["phone"] = phoneNumber;
      body["countryCode"] = countryCode ?? '+91';
    }

    final response = await makeRequest('/user/customerVerifyUser', body: body);
    return response;
  }

  static Future<Map<String, dynamic>> profileImageUpload(File? image) async {
    print('profileImageUpload called');
    final userDetails = UserModel.getInstance();

    FormData formData = new FormData.fromMap({
      "userId": userDetails?.userId,
      "loginId": userDetails?.loginId,
      "appType": "ANDROID",
      "image": await MultipartFile.fromFile(image?.path ?? "",
          filename: 'upload.jpg'),
    });

    try {
      final response = await Dio().post(
         _baseUrl + "/user/profileImageUpload",
        data: formData,
      );

      if (response.statusCode == 200) {
        final body = response.data;
        print('response $body');
        if (body["STATUSCODE"] == 200) {
          userDetails
              ?.updateProfileImage(body['response_data']["profileImage"]);
        }
        return body;
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return {
          "success": false,
          "STATUSCODE": response.statusCode,
          "message": "Something Wrong",
        };
      }
    } catch (ex) {
      print(ex);
      var msg = ex.toString();
      if (RegExp(r'socketException', caseSensitive: false).hasMatch(msg)) {
        msg = "Something wrong, please try again..";
      }

      return {
        "success": false,
        "message": msg,
      };
    }
  }

  static Future<Map<String, dynamic>> coverImageUpload(File? image) async {
    print('coverImageUpload called');
    final userDetails = UserModel.getInstance();

    FormData formData = new FormData.fromMap({
      "userId": userDetails?.userId,
      "loginId": userDetails?.loginId,
      "appType": "ANDROID",
      "image": await MultipartFile.fromFile(image?.path ?? "",
          filename: 'upload.jpg'),
    });

    try {
      final response = await Dio().post(
        _baseUrl + "/user/coverImageUpload",
        data: formData,
      );

      if (response.statusCode == 200) {
        final body = response.data;
        print('response $body');
        if (body["STATUSCODE"] == 200) {
          userDetails
              ?.updateCoverImage(body['response_data']["coverImage"]);
        }
        return body;
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return {
          "success": false,
          "STATUSCODE": response.statusCode,
          "message": "Something Wrong",
        };
      }
    } catch (ex) {
      print(ex);
      var msg = ex.toString();
      if (RegExp(r'socketException', caseSensitive: false).hasMatch(msg)) {
        msg = "Something wrong, please try again..";
      }

      return {
        "success": false,
        "message": msg,
      };
    }
  }

  static Future<Map<String, dynamic>> fetchMessages(
      userId) async {
    var responseJson;
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserModel.getInstance()?.authToken}'
    };
    var request = http.Request('POST', Uri.parse('http://nodeserver.mydevfactory.com:8086/api/post/users/messageList/$userId'));
    request.bodyFields = {
      'fromUserId': userId
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      responseJson = jsonDecode(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>\n"+responseJson.toString()??"");
    return responseJson;
  }

  static Future<Map<String, dynamic>> fetchOneToOneMessages(
      fromUserId, toUserId) async {
    var responseJson;
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserModel.getInstance()?.authToken}'
    };
    var request = http.Request('POST', Uri.parse('http://nodeserver.mydevfactory.com:8086/api/post/users/oneToOneMessageList/$fromUserId'));
    request.bodyFields = {
      'fromUserId': fromUserId,
      'toUserId': toUserId
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      responseJson = jsonDecode(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    //print(">>>>>>>>>>>>>>>>>>>>>>>>>>\n"+responseJson.toString()??"");
    return responseJson;
  }

  static Future<Map<String, dynamic>> sendMessages(
      fromUserId, toUserId, message, msgType, postId) async {
    var responseJson;
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserModel.getInstance()?.authToken}'
    };
    var request = http.Request('POST', Uri.parse('http://nodeserver.mydevfactory.com:8086/api/post/users/sendMessagePost/$fromUserId'));
    final Map<String, String> body = {
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'messageType': msgType,
      'message': message,
      'postId': postId
    };
    print(body);
    request.bodyFields = body;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      responseJson = jsonDecode(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    //print(">>>>>>>>>>>>>>>>>>>>>>>>>>\n"+responseJson.toString()??"");
    return responseJson;
  }
}
