import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_social/menu/settings/blocked.dart';
import 'package:stock_social/menu/settings/display_and_sound.dart';
import 'package:stock_social/menu/settings/muted.dart';
import 'package:stock_social/menu/settings/push_notifications.dart';
import 'package:stock_social/menu/settings/social_network.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0), // here the desired height

          child: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
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
          )
      ),
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
                    blurRadius:4.0, // soften the shadow
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

               /* ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            //settings: RouteSettings(name: '/account-details'),
                            builder: (context) => AccountDetails()));
                  },
                  dense: true,
                  title: Text(
                    'Account Info',
                    style: TextStyle(
                      color:  Color(0XFFFFb0b0b0),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: (17 / 14),
                      fontFamily: "Roboto",
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(),*/

                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => DisplayAndSound()));
                  },
                  dense: true,
                  title: Text(
                    'Display and Sound',
                    style: TextStyle(
                      color:  Color(0XFFFFb0b0b0),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: (17 / 14),
                      fontFamily: "Roboto",
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => PushNotifications()));
                  },
                  dense: true,
                  title: Text(
                    'Notifications',
                    style: TextStyle(
                      color:  Color(0XFFFFb0b0b0),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: (17 / 14),
                      fontFamily: "Roboto",
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(),
                /*ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => SocialNetwork()));
                  },
                  dense: true,
                  title: Text(
                    'Social Network',
                    style: TextStyle(
                      color:  Color(0XFFFFb0b0b0),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: (17 / 14),
                      fontFamily: "Roboto",
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => Muted()));
                  },
                  dense: true,
                  title: Text(
                    'Muted',
                    style: TextStyle(
                      color:  Color(0XFFFFb0b0b0),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: (17 / 14),
                      fontFamily: "Roboto",
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(),*/
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => Blocked()));
                  },
                  dense: true,
                  title: Text(
                    'Blocked',
                    style: TextStyle(
                      color:  Color(0XFFFFb0b0b0),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: (17 / 14),
                      fontFamily: "Roboto",
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
