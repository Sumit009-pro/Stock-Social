import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:stock_social/bottombar/rooms/room_settings.dart';
import 'package:stock_social/messages.dart';
import 'package:stock_social/models/user_model.dart';

class DemoRoom extends StatefulWidget {
  const DemoRoom({Key? key}) : super(key: key);

  @override
  _DemoRoomState createState() => _DemoRoomState();
}

class _DemoRoomState extends State<DemoRoom> {

  UserModel? userDetails;

  final _commentController=TextEditingController();

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
                Navigator.pop(context);
              },
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'Demo Room',
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
      ),
      body:Container(
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

                                  if(value==5)
                                    Navigator.push(context,CupertinoPageRoute(builder: (context) => RoomSettings()));
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

                    Container(
                      padding: const EdgeInsets.only(left: 14.0, right: 14),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                padding: EdgeInsets.only(left:8,right: 8,top: 7,bottom: 7),
                                child:  Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Container(
                                      child: CircleAvatar(
                                        radius: 20.5,
                                        backgroundColor:Color(0XFFFFb0b0b0),
                                        child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.white,
                                            child:userDetails!.profileImage==""
                                                ?CircleAvatar(
                                              radius: 17,
                                              backgroundColor: Colors.white,
                                              backgroundImage:AssetImage("assets/images/user_profile.png",),
                                            )
                                                :CircleAvatar(
                                                radius: 17,
                                                backgroundColor: Colors.white,
                                                backgroundImage:NetworkImage("${userDetails!.profileImage}")
                                            )
                                        ),
                                      ),
                                    ),

                                    SizedBox( width: 10, ),

                                    Flexible(
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Container(
                                                padding: EdgeInsets.only(top:10),
                                                child: Text(
                                                  '${userDetails!.firstName} ${userDetails!.lastName}',
                                                  style: TextStyle(
                                                    color: Color(0XFF9D9D9D),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    height: (17 / 14),
                                                    fontFamily: "Roboto",
                                                  ),
                                                ),
                                              ),

                                              Container(
                                                margin: EdgeInsets.only(top:5,bottom: 10,),
                                                child: Text(
                                                  'Lorem Ipslum',
                                                  softWrap: true,maxLines: 1,
                                                  style: TextStyle(
                                                    color: Color(0XFFFFb0b0b0),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    height: (17 / 14),
                                                    fontFamily: "Roboto",
                                                  ),
                                                ),
                                              ),

                                              Container(
                                                margin: EdgeInsets.only(bottom: 10,),
                                                child: Text(
                                                  'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five',
                                                  softWrap: true,maxLines: 5,
                                                  style: TextStyle(
                                                    color: Color(0XFFFFb0b0b0),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    height: (17 / 14),
                                                    fontFamily: "Roboto",
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        )
                                    ),

                                  ],
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 6,),

                    Divider(color: Color(0XFF9D9D9D), ),

                    /* Center(
                        child: Icon(
                      Icons.lock,
                      color: Color(0XFF808080),
                    )
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Text(
                        'This is Private Room',
                        style: TextStyle(
                          color: Color(0XFF808080),
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Text(
                        'To Join this room please get subscription',
                        style: TextStyle(
                          color: Color(0XFF808080),
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Center(
                      child: MyMaterialButton(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddNewCreaditOrDebitCard()));
                      },
                      tittle: "Pay - 99 / Mont",
                      width: 220,
                    )),*/


                  ],
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                    child: Icon(Icons.camera_alt,color: Colors.grey,),
                  ),

                  SizedBox(width: 8,),

                  Container(
                    child: Icon(Icons.image,color: Colors.grey,),
                  ),

                  SizedBox(width: 8,),

                  Expanded(
                    child: Container(
                      //height: MediaQuery.of(context).size.height/15,
                      padding: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey,width: 0.2),
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child:TextFormField(
                        controller: _commentController,
                        keyboardType: TextInputType.multiline,
                        // maxLength: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          isDense: true, // important line
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          border: InputBorder.none,
                          hintText: 'Write a public comment...',
                          hintStyle: TextStyle(
                            color: Color(0XFFFFb0b0b0),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: (15 / 12),
                            fontFamily: "Roboto",
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 5,),

                  InkWell(
                    onTap: (){   },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      /* decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0XFFFE99AC)
                      ),*/
                      child: Icon(Icons.send,color: Color(0XFFFE99AC)),
                    ),
                  ),


                  InkWell(
                    onTap: (){   },
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: Icon(Icons.mic,color: Colors.white),
                    ),
                  )

                ],
              ),
            )

          ],
        ),
        // ),
      ),
    );
  }
}
