import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stock_social/messages.dart';
import 'package:stock_social/models/user_model.dart';
import 'package:stock_social/notification.dart';

class RoomSettings extends StatefulWidget {
  const RoomSettings({Key? key}) : super(key: key);

  @override
  _RoomSettingsState createState() => _RoomSettingsState();
}

class _RoomSettingsState extends State<RoomSettings> {

  UserModel? userDetails;


  List<dynamic> list = [
    {"value":1, "name":"Mute","icon":Icons.notifications_off},
    {"value":2, "name":"Search","icon":Icons.search},
    {"value":3, "name":"Report","icon":Icons.info},
    {"value":4, "name":"Leave room","icon":Icons.meeting_room},
    {"value":5, "name":"Room settings","icon":Icons.settings},
  ];

  @override
  void initState() {
    super.initState();
    userDetails = UserModel.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'Room Settings',
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
                    Navigator.push(context,CupertinoPageRoute(builder: (context) => Notifications()));
                  }),
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
              onPressed: () {
                Navigator.push(context,CupertinoPageRoute(builder: (context) => Messages()));
              }),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              height: MediaQuery.of(context).size.height/4.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/vg-bg.png'),
                      fit: BoxFit.fill
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))
              ),
            ),

            SizedBox( height: 18, ),

            Expanded(
                child: Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: ListView(
                    shrinkWrap: true,
                    children: [

                      Container(
                        padding: const EdgeInsets.only(left: 14.0, right: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Flexible(
                              child: Container(
                                child: Text(
                                  '${userDetails!.firstName} ${userDetails!.lastName}',
                                  style: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                              ),
                            ),


                            Container(
                              child: PopupMenuButton(
                                  shape: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      )
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.width/10,
                                    width: MediaQuery.of(context).size.width/6,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                        color: Color(0XFFffe6ea)),
                                    child: Center(
                                        child: Icon(
                                          Icons.more_horiz,
                                          color: Color(0XFF9D9D9D),
                                        )),
                                  ),
                                  elevation: 40,
                                  enabled: true,
                                  offset: Offset(0, 50),
                                  onSelected: (value) {
                                  },
                                  itemBuilder:(context) {
                                    return list.map((dynamic choice) {
                                      return PopupMenuItem(
                                          value: choice["value"],
                                          child:Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [

                                                Container(child: Text(choice["name"],style: TextStyle(color:Color(0XFFFFb0b0b0),fontWeight: FontWeight.bold),)),

                                                SizedBox(width: 10,),

                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.grey
                                                  ),
                                                  child: Icon(choice["icon"],color:Colors.white,),
                                                )
                                              ],
                                            ),
                                          )
                                      );
                                    }).toList();
                                  }
                              ),
                            )

                          ],
                        ),
                      ),

                      SizedBox(
                        height: 6,
                      ),

                      Container(
                        padding: const EdgeInsets.only(left: 14.0, right: 14),
                        child: RichText(
                          text: TextSpan(
                              text: 'Type -  ',
                              style: TextStyle(
                                color: Color(0XFFFFb0b0b0),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: (17 / 12),
                                fontFamily: "Roboto",
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Private',
                                  style: TextStyle(
                                    color: Color(0XFFFE99AC),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    height: (17 / 12),
                                    fontFamily: "Roboto",
                                  ),
                                )
                              ]
                          ),
                        ),
                      ),

                      SizedBox( height: 5, ),

                      Container(
                        padding: const EdgeInsets.only(left: 14.0, right: 14),
                        child: RichText(
                          text: TextSpan(
                              text: '106 Members, ',
                              style: TextStyle(
                                color: Color(0XFFFFb0b0b0),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: (17 / 12),
                                fontFamily: "Roboto",
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '27 online',
                                  style: TextStyle(
                                    color: Color(0XFFFE99AC),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    height: (17 / 12),
                                    fontFamily: "Roboto",
                                  ),
                                )
                              ]
                          ),
                        ),
                      ),

                      SizedBox( height: 6,),

                      Divider(color: Color(0XFF9D9D9D), ),

                      SizedBox( height: 6,),

                      ListTile(
                        onTap: () { },
                        dense: true,
                        leading: Icon(Icons.search,color:Color(0XFFFE99AC),),
                        title: Text('Media, Link and Docs',
                          style: TextStyle(color:Color(0XFF9D9D9D),
                            fontSize: 14, fontWeight: FontWeight.w500, height: (17 / 14),
                            fontFamily: "Roboto",
                          ),
                        ),
                        trailing: Icon(Icons.chevron_right,color: Color(0XFF9D9D9D),),
                      ),

                      Divider(),

                      ListTile(
                        onTap: () { },
                        dense: true,
                        leading: Icon(Icons.push_pin,color:Color(0XFFFE99AC),),
                        title: Text('Pined Messages',
                          style: TextStyle(color:Color(0XFF9D9D9D),
                            fontSize: 14, fontWeight: FontWeight.w500, height: (17 / 14),
                            fontFamily: "Roboto",
                          ),
                        ),
                        trailing: Icon(Icons.chevron_right,color: Color(0XFF9D9D9D),),
                      ),

                      Divider(),

                      ListTile(
                        onTap: () { },
                        dense: true,
                        leading: Icon(Icons.save_alt,color:Color(0XFFFE99AC),),
                        title: Text('Save to Gallery',
                          style: TextStyle(color:Color(0XFF9D9D9D),
                            fontSize: 14, fontWeight: FontWeight.w500, height: (17 / 14),
                            fontFamily: "Roboto",
                          ),
                        ),
                        trailing: Icon(Icons.chevron_right,color: Color(0XFF9D9D9D),),
                      ),

                      Divider(),

                      ListTile(
                        onTap: () { },
                        dense: true,
                        leading:  SvgPicture.asset(
                          'assets/icons/rooms.svg',
                          color: Color(0XFFFE99AC),
                        ),
                        title: Text('Room Type',
                          style: TextStyle(color:Color(0XFF9D9D9D),
                            fontSize: 14, fontWeight: FontWeight.w500, height: (17 / 14),
                            fontFamily: "Roboto",
                          ),
                        ),
                        trailing: Icon(Icons.chevron_right,color: Color(0XFF9D9D9D),),
                      ),

                      Divider(),

                      ListTile(
                        onTap: () { },
                        dense: true,
                        leading:  SvgPicture.asset(
                          'assets/icons/rooms.svg',
                          color: Color(0XFFFE99AC),
                        ),
                        title: Text('Clear Chat',
                          style: TextStyle(color:Color(0XFF9D9D9D),
                            fontSize: 14, fontWeight: FontWeight.w500, height: (17 / 14),
                            fontFamily: "Roboto",
                          ),
                        ),
                        trailing: Icon(Icons.chevron_right,color: Color(0XFF9D9D9D),),
                      ),

                      Divider(),

                      ListTile(
                        onTap: () { },
                        dense: true,
                        leading:  SvgPicture.asset(
                          'assets/icons/rooms.svg',
                          color: Color(0XFFFE99AC),
                        ),
                        title: Text('About Room',
                          style: TextStyle(color:Color(0XFF9D9D9D),
                            fontSize: 14, fontWeight: FontWeight.w500, height: (17 / 14),
                            fontFamily: "Roboto",
                          ),
                        ),
                        trailing: Icon(Icons.chevron_right,color: Color(0XFF9D9D9D),),
                      ),


                    ],
                  ),
                )
            )


          ],
        ),
      ),
    );
  }
}
