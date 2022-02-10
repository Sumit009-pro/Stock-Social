import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SocialNetwork extends StatefulWidget {
  const SocialNetwork({Key? key}) : super(key: key);

  @override
  _SocialNetworkState createState() => _SocialNetworkState();
}

class _SocialNetworkState extends State<SocialNetwork> {
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
                        color:Color(0XFFFE99AC),
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
      body: Column(
          children: [
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
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 16, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.facebook,
                        color: Colors.blue,
                      ),
                      Row(
                        children: [
                          Text(
                            'Connected',
                            style: TextStyle(
                              color: Color(0XFFFE99AC),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: (16 / 14),
                              fontFamily: "Roboto",
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            'Disconnet',
                            style: TextStyle(
                              color: Color(0XFFFFb0b0b0),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: (16 / 14),
                              fontFamily: "Roboto",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Color(0XFF9D9D9D),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 16, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Ionicons.logo_twitter,
                        color: Colors.blue,
                      ),
                      Row(
                        children: [
                          Text(
                            'Connected',
                            style: TextStyle(
                              color: Color(0XFFFE99AC),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: (16 / 14),
                              fontFamily: "Roboto",
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            'Disconnet',
                            style: TextStyle(
                              color: Color(0XFFFFb0b0b0),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: (16 / 14),
                              fontFamily: "Roboto",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Color(0XFF9D9D9D),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
