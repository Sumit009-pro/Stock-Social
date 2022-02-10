import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stock_social/bottombar/profile/post_details.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {

  // late final BuildContext context;

  //NotificationService a singleton object
  static final NotificationService _notificationService =
  NotificationService._internal();

  factory NotificationService() {
    // _notificationService.context=ctx!;
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = '123';
  String userId='';
  String? type;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: null);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification
    );

    var initializationSettingsIOs = IOSInitializationSettings();
    //
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    print('payload=');
    String? payload= notificationAppLaunchDetails!.payload;
    print(payload);


  }

  AndroidNotificationDetails _androidNotificationDetails =
  AndroidNotificationDetails(
    'high_importance_channel',
    'channel name',
    channelDescription: 'channel description',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
    // icon: android?.smallIcon,
    icon:"@mipmap/ic_launcher",
      setAsGroupSummary: true
  );

  Future<void> showNotifications(String msg,String id) async {

    this.userId=id;
    // this.context=context;
    await flutterLocalNotificationsPlugin.show(
      0,
      "Stock Social",
      msg,
      NotificationDetails(android: _androidNotificationDetails),
      payload: id

    );
  }

  Future<void> scheduleNotifications() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "Notification Title",
        "This is the Notification Body!",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        NotificationDetails(android: _androidNotificationDetails),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  void selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    }
    print('notification payload');
    // await Navigator.push(
    //   context!,
    //   MaterialPageRoute<void>(builder: (context) => PostDetails(id:'61cf04835f9c8551cc12893e')),
    // );
  }
}


