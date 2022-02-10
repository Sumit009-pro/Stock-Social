import 'package:flutter/material.dart';
import 'package:stock_social/models/notification_settings_get_model.dart';
import 'package:stock_social/models/api.dart';
import 'package:stock_social/models/user_model.dart';
import 'package:stock_social/widgets/switch_list_tile.dart';

class PushNotifications extends StatefulWidget {
  const PushNotifications({Key? key}) : super(key: key);

  @override
  _PushNotificationsState createState() => _PushNotificationsState();
}

class _PushNotificationsState extends State<PushNotifications>
    with SingleTickerProviderStateMixin {
  bool process = false;
  bool _pushLikes = false;
   bool _pushComments = false;
  bool _pushFollows = false;
  bool _pushShares = false;
  bool _pushMentions = false;
  bool _pushDirectMessages = false;
  bool _pushRooms = true;
  bool _emailLikes = false;
  bool _emailComments = true;
  bool _emailFollows = false;
  bool _emailShares = false;
  bool _emailMentions = false;
  bool _emailDirectMessages = false;
  bool _emailRooms = false;
  bool _smsLikes = false;
  bool _smsComments = false;
  bool _smsFollows = false;
  bool _smsShares = false;
  bool _smsMentions = false;
  bool _smsDirectMessages = false;
  bool _smsRooms = false;

  late AnimationController _controller;
  Animation? gradientPosition;
  ResponseData? notificationSettings;
  UserModel? userDetails;

  @override
  void initState() {
    // TODO: implement initState
    userDetails = UserModel.getInstance();
    super.initState();
    fetchNotificationGet(userDetails!.userId??'');

    _controller = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    )..addListener(() {
        if (process) setState(() {});
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void fetchNotificationGet(String id) async {
    final response = await API.notificationSetttingsGet(id);
    print(response.toString());
    if (response["STATUSCODE"] == 200) {
      print("code : 200");
      var rest = response["response_data"] ;

      setState(() {
        // notificationSettings = rest
        //     .map<ResponseData>((json) => ResponseData.fromJson(json)) as ResponseData?;
        process = false;
         _pushLikes = response["response_data"]['usernotSetting']['Like']  ;
         print(_pushLikes.toString());
         _pushComments =response["response_data"]['usernotSetting']['Comment'];
         _pushFollows =response["response_data"]['usernotSetting']['Follow'];
         _pushShares = response["response_data"]['usernotSetting']['Share'];
         _pushDirectMessages =response["response_data"]['usernotSetting']['Message'];
      });
    } else {
      setState(() {
        process = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar((SnackBar(content: Text(response["message"]))));
    }
  } //func

   fetchNotificationPost() async {
    final response = await API.notificationSetttingsPost({'notificationData':'{ "Like": $_pushLikes, "Comment": $_pushComments, "Share": $_pushShares, "Message": $_pushDirectMessages, "Follow": $_pushFollows }'},userDetails!.userId??'');
    print(response.toString());
    if (response["STATUSCODE"] == 200) {
      print("code : 200");

    } else {
      setState(() {
        process = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar((SnackBar(content: Text(response["message"]))));
    }
  } //func

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0), // here the desired height

          child: AppBar(
            backgroundColor: Colors.transparent,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            centerTitle: true,
            title: Text(
              'Settings',
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
                      onPressed: () {}),
                  new Positioned(
                    right: 11,
                    top: 11,
                    child: new Container(
                      padding: EdgeInsets.all(2),
                      decoration: new BoxDecoration(
                        color: Color(0XFFFE99AC),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        '5',
                        style: TextStyle(
                          color: Colors.white,
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
                  onPressed: () {}),
            ],
          )),
      body: Column(children: [
        SizedBox(
          height: 32,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 16),
            width: double.infinity,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    blurRadius: 4.0, // soften the shadow
                    offset: Offset(
                      0.0, // Move to right 10  horizontally
                      -1.0, // Move to bottom 10 Vertically
                    ),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 24),
                  child: Text(
                    'Notifications',
                    style: TextStyle(
                      color: Color(0XFF9D9D9D),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: (22 / 18),
                      fontFamily: "Roboto",
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Divider(
                  color: Color(0XFF9D9D9D),
                ),
                MySwitchListTile(
                  title: 'Likes',
                  value: _pushLikes,
                  onChanged: (bool value) async{
                    setState(() {
                      _pushLikes = value;
                    });
                    await fetchNotificationPost();

                  },
                ),
                MySwitchListTile(
                  title: 'Comments',
                  value: _pushComments,
                  onChanged: (bool value) async{
                    setState(() {
                      _pushComments = value;

                    });
                    await fetchNotificationPost();

                  },
                ),
                MySwitchListTile(
                  title: 'Follows',
                  value: _pushFollows,
                  onChanged: (bool value) async{
                    setState(() {
                      _pushFollows = value;

                    });
                    await fetchNotificationPost();

                  },
                ),
                MySwitchListTile(
                  title: 'Shares',
                  value: _pushShares,
                  onChanged: (bool value) async{
                    setState(() {
                      _pushShares = value;

                    });
                    await fetchNotificationPost();

                  },
                ),
                /* MySwitchListTile(
                  title: 'Mentions',
                  value: _pushMentions,
                  onChanged: (bool value) {
                    setState(() {
                      _pushMentions = value;
                    });
                  },
                ),*/
                MySwitchListTile(
                  title: 'Direct messages',
                  value: _pushDirectMessages,
                  onChanged: (bool value) async {
                    setState(() {
                      _pushDirectMessages = value;
                    });
                    await fetchNotificationPost();

                  },
                ),
                /*MySwitchListTile(
                  title: 'Rooms',
                  value: _pushRooms,
                  onChanged: (bool value) {
                    setState(() {
                      _pushRooms = value;
                    });
                  },
                ),*/
                /* Padding(
                  padding: const EdgeInsets.only(top: 24.0, left: 24),
                  child: Text(
                    'Email Notifications',
                    style: TextStyle(
                      color:Color(0XFF9D9D9D),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: (22 / 18),
                      fontFamily: "Roboto",
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Divider(
                  color: Color(0XFF9D9D9D),
                ),
                MySwitchListTile(
                  title: 'Likes',
                  value: _emailLikes,
                  onChanged: (bool value) {
                    setState(() {
                      _emailLikes = value;
                    });
                  },
                ),
                MySwitchListTile(
                  title: 'Comments',
                  value: _emailComments,
                  onChanged: (bool value) {
                    setState(() {
                      _emailComments = value;
                    });
                  },
                ),
                MySwitchListTile(
                  title: 'Follows',
                  value: _emailFollows,
                  onChanged: (bool value) {
                    setState(() {
                      _emailFollows = value;
                    });
                  },
                ),
                MySwitchListTile(
                  title: 'Shares',
                  value: _emailShares,
                  onChanged: (bool value) {
                    setState(() {
                      _emailShares = value;
                    });
                  },
                ),
                MySwitchListTile(
                  title: 'Mentions',
                  value: _emailMentions,
                  onChanged: (bool value) {
                    setState(() {
                      _emailMentions = value;
                    });
                  },
                ),
                MySwitchListTile(
                  title: 'Direct messages',
                  value: _emailDirectMessages,
                  onChanged: (bool value) {
                    setState(() {
                      _emailDirectMessages = value;
                    });
                  },
                ),
                MySwitchListTile(
                  title: 'Rooms',
                  value: _emailRooms,
                  onChanged: (bool value) {
                    setState(() {
                      _emailRooms = value;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, left: 24),
                  child: Text(
                    'SMS Notifications',
                    style: TextStyle(
                      color: Color(0XFF9D9D9D),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: (22 / 18),
                      fontFamily: "Roboto",
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Divider(
                  color: Color(0XFF9D9D9D),
                ),
                MySwitchListTile(
                  title: 'Likes',
                  value: _smsLikes,
                  onChanged: (bool value) {
                    setState(() {
                      _smsLikes = value;
                    });
                  },
                ),
                MySwitchListTile(
                  title: 'Comments',
                  value: _smsComments,
                  onChanged: (bool value) {
                    setState(() {
                      _smsComments = value;
                    });
                  },
                ),
                MySwitchListTile(
                  title: 'Follows',
                  value: _smsFollows,
                  onChanged: (bool value) {
                    setState(() {
                      _smsFollows = value;
                    });
                  },
                ),
                MySwitchListTile(
                  title: 'Shares',
                  value: _smsShares,
                  onChanged: (bool value) {
                    setState(() {
                      _smsShares = value;
                    });
                  },
                ),
                MySwitchListTile(
                  title: 'Mentions',
                  value: _smsMentions,
                  onChanged: (bool value) {
                    setState(() {
                      _smsMentions = value;
                    });
                  },
                ),
                MySwitchListTile(
                  title: 'Direct messages',
                  value: _smsDirectMessages,
                  onChanged: (bool value) {
                    setState(() {
                      _smsDirectMessages = value;
                    });
                  },
                ),
                MySwitchListTile(
                  title: 'Rooms',
                  value: _smsRooms,
                  onChanged: (bool value) {
                    setState(() {
                      _smsRooms = value;
                    });
                  },
                ),*/
                SizedBox(
                  height: 42,
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
