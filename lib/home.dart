import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stock_social/bottombar/dashboard/dashboard.dart';
import 'package:stock_social/bottombar/rooms/rooms.dart';
import 'package:stock_social/bottombar/search.dart';
import 'package:stock_social/bottombar/profile/account_details.dart';
import 'package:stock_social/models/notification_data_model.dart';
import 'dart:convert' as convert;

import 'bottombar/profile/post_details.dart';
import 'firebase/firebase_notification.dart';
import 'firebase/notification_service.dart';
import 'main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String messageTitle = "Empty";
  String notificationAlert = "alert";

  String notificationTitle = 'No Title';
  String notificationBody = 'No Body';
  String notificationData = 'No Data';
  int _currentIndex = 0;
  var tabs = [];
  NotificationService? _notificationService=NotificationService() ;

  show(String msg,String id) async {
    await _notificationService!.showNotifications(msg,id);
    // _notificationService!.selectNotification('payload');

  }
  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      // _notificationService=NotificationService();
    });



   /* WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
        print('getInitialMessage data: ${message!.data}');
        // _serialiseAndNavigate(message);
      });
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Got a message whilst in the foreground! ${message.data} ${message.notification.toString()!}');
        final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

          flutterLocalNotificationsPlugin.show(
              0,
              "Stock Social",
              "Stock Social",
              NotificationDetails(
                android: AndroidNotificationDetails(
                  'high_importance_channel',
                  'channel name',
                  channelDescription: 'channel description',
                  // TODO add a proper drawable resource to android, for now using
                  //      one that already exists in example app.
                  icon: '@mipmap/ic_launcher',
                ),
              ));



        // NotificationDataModel? notificationDataModel;

        // show('Title','Body',);


        if (message.notification != null) {
          print('Message also contained a notification: ${message.notification}');
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
        Navigator.push(
          context!,
          MaterialPageRoute<void>(builder: (context) => PostDetails(id:'61cf04835f9c8551cc12893e')),
        );
      });
    });*/





  /*  FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
       /* Navigator.pushNamed(
          context,
          '/message',
          arguments: MessageArguments(message, true),
        );*/
      }
    });*/

   /* FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('A new onMessage event was published! ${message.data}');
      // RemoteNotification? notification = message.data as RemoteNotification?;
      var jsonResponse = convert.jsonDecode(message.data['alert']);
      // AndroidNotification? android = message.data as AndroidNotification?;
      if (jsonResponse != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          0,
          'Stock Social',
          '${jsonResponse['message']}',
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
     /* Navigator.pushNamed(
        context,
        '/message',
        arguments: MessageArguments(message, true),
      );*/
    });*/
    /*final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();

    firebaseMessaging.streamCtlr.stream.listen(_changeData);
    firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    firebaseMessaging.titleCtlr.stream.listen(_changeTitle);*/
    super.initState();
    tabs = [Dashboard(), Rooms(), Search(), AccountDetails()];
  }
  Future<void> onActionSelected(String value) async {
    switch (value) {
      case 'subscribe':
        {
          print(
            'FlutterFire Messaging Example: Subscribing to topic "fcm_test".',
          );
          await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
          print(
            'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.',
          );
        }
        break;
      case 'unsubscribe':
        {
          print(
            'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".',
          );
          await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
          print(
            'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.',
          );
        }
        break;
      case 'get_apns_token':
        {
          if (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.macOS) {
            print('FlutterFire Messaging Example: Getting APNs token...');
            String? token = await FirebaseMessaging.instance.getAPNSToken();
            print('FlutterFire Messaging Example: Got APNs token: $token');
          } else {
            print(
              'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.',
            );
          }
        }
        break;
      default:{ print(
        'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.',
      );}
        break;
    }
  }
  _changeData(String msg) => setState(() => notificationData = msg);
  _changeBody(String msg) => setState(() => notificationBody = msg);
  _changeTitle(String msg) => setState(() => notificationTitle = msg);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
     /* appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0), // here the desired height
        child: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Image(
            image: AssetImage("assets/images/top_bg.png",),
            fit: BoxFit.fill,
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Navigator.push(context,CupertinoPageRoute(builder: (context) => Menu()));
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          centerTitle: true,
          title: Text(
            'StockSocial',
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Color(0XFFFFFFFF),
              fontSize: 24,
              fontWeight: FontWeight.w600,
              height: (30 / 24),
              fontFamily: "Roboto",
            ),
          ),
          elevation: 0,
          actions: [
            new Stack(
              children: <Widget>[
                new IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Color(0XFFE5E5E5),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Notifications()));
                  },
                ),
                new Positioned(
                  right: 11,
                  top: 11,
                  child: new Container(
                    padding: EdgeInsets.all(2),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      '5',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            new IconButton(
              icon: Icon(
                Icons.mail,
                color: Color(0XFFE5E5E5),
                size: 22,
              ),
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => Messages()));
              },
            ),
          ],
        ),
      ),*/
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0XFFFE99AC),
          selectedItemColor:Color(0XFFFE99AC),
          unselectedItemColor: Colors.white,
          unselectedIconTheme: IconThemeData(color: Colors.white, opacity: 0.5),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              label: '',
              activeIcon:Container(
                padding:EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: SvgPicture.asset(
                  'assets/icons/home.svg',
                  color: Color(0XFFFE99AC),
                ),
              ),
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                color: Colors.white,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              activeIcon: Container(
                padding:EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: SvgPicture.asset(
                  'assets/icons/rooms.svg',
                  color: Color(0XFFFE99AC),
                ),
              ),
              icon: SvgPicture.asset(
                'assets/icons/rooms.svg',
                color: Colors.white,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              activeIcon: Container(
                padding:EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: SvgPicture.asset(
                  'assets/icons/search.svg',
                  color:Color(0XFFFE99AC),
                ),
              ),
              icon: SvgPicture.asset(
                'assets/icons/search.svg',
                color: Colors.white,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              activeIcon: Container(
                padding:EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: SvgPicture.asset(
                  'assets/icons/profile_icon.svg',
                  color:Color(0XFFFE99AC),
                ),
              ),
              icon: SvgPicture.asset(
                'assets/icons/profile_icon.svg',
                color: Colors.white,
              ),
            ),
          ]),
    );
  }
}
