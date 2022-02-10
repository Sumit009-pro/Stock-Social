import 'dart:async';
import 'dart:convert';
import 'dart:convert' as convert;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_social/bottombar/profile/other_profile.dart';
import 'package:stock_social/models/app_notification.dart';
import 'package:stock_social/signup/get_started.dart';
import 'package:stock_social/signup/sign_in.dart';

import 'bottombar/profile/post_details.dart';
import 'firebase/message.dart';
import 'firebase/message_list.dart';
import 'firebase/notification_service.dart';
import 'firebase/permissions.dart';
import 'firebase/token_monitor.dart';
import 'home.dart';
import 'models/user_model.dart';

RemoteMessage? notificationMessage;
UserModel? userDetails;
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'channel name',
  // channelDescription: 'channel description',// description
  importance: Importance.high,
);

/// This is called on the beginning of main() to ensure when app is closed
/// user receives the notifications. Then it's called also in the build method of MyApp
/// so user receives foreground notifications.
Future<void> showNotification(RemoteMessage message) async {
  // RemoteNotification notification = message.notification;
  // AndroidNotification android = message.notification?.android;

  // if (notification != null && android != null) {
  var jsonResponse = convert.jsonDecode(message.data['alert']!);
  print('Message data: ${jsonResponse['message']}' +
      '${jsonResponse['otherData']}');
  notificationMessage = message;
  userDetails!.setCount(10);

  print("Showing notification");
  localNotifications.show(
      0,
      'Stock Social',
      '${jsonResponse['message']}',
      NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'channel name',
          channelDescription: 'channel description',
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: '@mipmap/ic_launcher',
        ),
      ),
      payload: notificationMessage?.data['alert']);
  // }
}

/// This is called when user clicks on the notification
Future<String?> onNotificationClick(String? message) async {
  print("Clicked on notification${message}");
  // if (message == null || message?.data == null) {
  //   print("onMessageClick: Message or message.data is null");
  //   return;
  // }

  /*final Map data = message?.data;

  print("onMessageClick: Message is not null");

  if (data['screen'] != null && data['screen_args'] != null) {
    switch (message.data['screen']) {
      case 'PostScreen':
        PostsProvider _postsProvider = Provider.of(
          navigatorKey.currentContext,
          listen: false,
        );

        _postsProvider.fetchPosts(reload: true).then((List<Post> posts) {
          Post post = posts.firstWhere((element) {
            Map<String, dynamic> _screenArgs =
            jsonDecode(message.data['screen_args']);
            return element.id == _screenArgs['post'];
          });
          Navigator.of(navigatorKey.currentContext).pushNamed(
              '/post', arguments: {
            'post': post,
          });
        });

        break;
    }
  }*/
}

final FlutterLocalNotificationsPlugin localNotifications =
    FlutterLocalNotificationsPlugin();

SharedPreferences? sharedPreferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await NotificationService().init();
  await Firebase.initializeApp();

  sharedPreferences = await SharedPreferences.getInstance();
  String? token = await FirebaseMessaging.instance.getToken();
  sharedPreferences!.setString("device_id", token!);
  runApp(ChangeNotifierProvider<UserModel>(
    create: (context) => UserModel.getInstance()!,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async{
    //   initNotification();
    //
    // });
    ///Configure notifications: initialization for iOS and android
    // _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    // var android =
    // new AndroidInitializationSettings('@mipmap/ic_launcher');
    // var iOS = new IOSInitializationSettings();
    // var initSetttings = new InitializationSettings(android: android, iOS: iOS);
    // _flutterLocalNotificationsPlugin.initialize(initSetttings);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0XFFfecdd6),
                Color(0XFFFE99AC),
                Color(0XFFfeb3c1),
              ],
            ),
            image: DecorationImage(
                image: AssetImage("assets/images/middle_bg.png"),
                fit: BoxFit.fill)),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Stock Social',
          theme: ThemeData(
              primarySwatch: Colors.blue, backgroundColor: Colors.transparent),
          home: FutureBuilder<UserModel?>(
              future: UserModel.fromSharedPreferences(),
              builder: (context, snapshot) {
               userDetails =UserModel.getInstance();
                initNotification(context);

                if (snapshot.connectionState != ConnectionState.done) {
                  return Container(color: Colors.transparent);
                } else {
                  if (snapshot.hasData) {
                    UserModel? model = snapshot.data;

                    if (model == null) {
                      return GetStarted();
                    } else {
                      return Home();
                    }
                  }
                }
                // handle error
                return GetStarted();
              }),
          routes: {
            "/signIn": (_) => new SignIn(),
            // '/': (context) => Application(),
            '/message': (context) => MessageView(),
          },
        ));
  }

  Future<void> initNotification(BuildContext context) async {
    await localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Permissions for background notifications
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Permissions for foreground notifications
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Local notification settings, which allows to make foreground notifications
    await localNotifications.initialize(
        InitializationSettings(
          android: AndroidInitializationSettings("@mipmap/ic_launcher"),
          // iOS: IOSInitializationSettings(),
        ), onSelectNotification: (payload) async {
      print(payload);
      var jsonResponse = convert.jsonDecode(payload!);
      print('Message data: ${jsonResponse['message']}' +
          '${jsonResponse['otherData']}');

      if ('${jsonResponse['notificationType']}' == 'Comment' ||
          '${jsonResponse['notificationType']}' == 'Like' ||
          '${jsonResponse['notificationType']}' == 'Share') {
        await Navigator.push(
          context,
          MaterialPageRoute<void>(
              builder: (context) =>
                  PostDetails(id: '${jsonResponse['otherData']}')),
        );
      } else if ('${jsonResponse['notificationType']}' == 'Follow') {
        await Navigator.push(
          context,
          MaterialPageRoute<void>(
              builder: (context) =>
                  OtherProfile(userId: '${jsonResponse['otherData']}')),
        );
      }
      // show('${jsonResponse['message']}','${jsonResponse['otherData']}',);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(showNotification);
    FirebaseMessaging.onMessage.listen(showNotification);
    // FirebaseMessaging.instance.getInitialMessage().then(onNotificationClick);
    FirebaseMessaging.onBackgroundMessage(showNotification);
  }
}
