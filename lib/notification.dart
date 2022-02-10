import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_social/messages.dart';

import 'models/notification_model.dart';
import 'models/api.dart';
import 'models/user_model.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications>  with SingleTickerProviderStateMixin {
  bool process = false;
  List<Notify> followingList = [];

  UserModel? userDetails;

  // FollowingModel following
  late AnimationController _controller;
  Animation? gradientPosition;

  @override
  void initState() {
    // TODO: implement initState
    userDetails = UserModel.getInstance();
    fetchNotification(userDetails!.userId??'');
    super.initState();
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

  void fetchNotification(String id) async {
    final response = await API.fetchNotification('61a949d8a03df26cd979aa21');
    print(response.toString());
    if (response["STATUSCODE"] == 200) {
      print("code : 200");
      var rest = response["response_data"]["notification"] as List;
      setState(() {
        followingList = rest
            .map<Notify>((json) => Notify.fromJson(json))
            .toList();
        process = false;
      });
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
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              },
            ),
            centerTitle: true,
            title: Text(
              'Notifications',
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

              new IconButton(
                icon: Icon(
                  Icons.mail,
                  color: Color(0XFFE5E5E5),
                  size: 22,
                ),
                onPressed: () {
                  Navigator.push(context,CupertinoPageRoute(builder: (context) => Messages()));
                },
              ),

            ],
          )
      ),
      body:process
          ? Container(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          margin: EdgeInsets.only(bottom: 10),
                          height: 10,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(gradientPosition!.value, 0),
                                end: Alignment(-1, 0),
                                colors: [
                                  Color.fromRGBO(0, 0, 0, 0.1),
                                  Color(0x44CCCCCC),
                                  Color.fromRGBO(0, 0, 0, 0.1)
                                ],
                              )),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height:
                            MediaQuery.of(context).size.height / 8,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                gradient: LinearGradient(
                                  begin: Alignment(
                                      gradientPosition!.value, 0),
                                  end: Alignment(-1, 0),
                                  colors: [
                                    Color.fromRGBO(0, 0, 0, 0.1),
                                    Color(0x44CCCCCC),
                                    Color.fromRGBO(0, 0, 0, 0.1)
                                  ],
                                ))),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                  width:
                                  MediaQuery.of(context).size.width /
                                      15,
                                  height:
                                  MediaQuery.of(context).size.height /
                                      15,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        begin: Alignment(
                                            gradientPosition!.value, 0),
                                        end: Alignment(-1, 0),
                                        colors: [
                                          Color.fromRGBO(0, 0, 0, 0.1),
                                          Color(0x44CCCCCC),
                                          Color.fromRGBO(0, 0, 0, 0.1)
                                        ],
                                      ))),
                              Container(
                                width:
                                MediaQuery.of(context).size.width / 5,
                                margin: EdgeInsets.only(left: 10),
                                height: 10,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(
                                          gradientPosition!.value, 0),
                                      end: Alignment(-1, 0),
                                      colors: [
                                        Color.fromRGBO(0, 0, 0, 0.1),
                                        Color(0x44CCCCCC),
                                        Color.fromRGBO(0, 0, 0, 0.1)
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 5,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(gradientPosition!.value, 0),
                                end: Alignment(-1, 0),
                                colors: [
                                  Color.fromRGBO(0, 0, 0, 0.1),
                                  Color(0x44CCCCCC),
                                  Color.fromRGBO(0, 0, 0, 0.1)
                                ],
                              )),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top: 5),
                          height: 5,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(gradientPosition!.value, 0),
                                end: Alignment(-1, 0),
                                colors: [
                                  Color.fromRGBO(0, 0, 0, 0.1),
                                  Color(0x44CCCCCC),
                                  Color.fromRGBO(0, 0, 0, 0.1)
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      )
          : SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.width/10,
                      width: MediaQuery.of(context).size.width/5,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(30)),
                          color: Color(0XFFFE99AC)),
                      child: Center(
                        child: Text(
                          'Clear',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: (22 / 18),
                            fontFamily: "Roboto",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,

                  child: ListView.builder(
                      // shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: followingList.length > 0
                          ? followingList.length
                          : 0,
                      itemBuilder: (context, index) {
                        print("${followingList[index].otherUserId!.profileImage}");
                        return

                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child:
                            // ListView(
                            //     children: [



                                  Container(
                                    padding: EdgeInsets.only(left:5,right:8,top: 10, bottom: 10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        followingList[index].otherUserId!.profileImage != '' && followingList[index].otherUserId!.profileImage != null?
                                        Container(
                                          child: ClipOval(
                                            child: CachedNetworkImage(
                                              imageUrl: "${followingList[index].otherUserId!.profileImage}",
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                  Container(
                                                    width: 48,
                                                    height: 48,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                        // colorFilter:
                                                        // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                      ),
                                                    ),
                                                  ),
                                              placeholder: (context, url) =>
                                                  ClipOval(
                                                    child: Container(
                                                        height: 48,
                                                        width: 48,
                                                        child: Image.asset(
                                                            'assets/logo.png')),
                                                  ),
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                Icons.error,
                                                size: 48,
                                              ),
                                            ),
                                          )
                                        ): Container(
                                          child:  CircleAvatar(
                                            backgroundColor: Colors.yellow,
                                            //   child: const Text('SK'),
                                          ),
                                        ),

                                        SizedBox(width: 10,),

                                        Flexible(
                                          child: Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [

                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [

                                                      Container(
                                                        child: Text(
                                                          followingList[index].otherUserId!.userName??'',
                                                          style: TextStyle(
                                                            color: Color(0XFF9D9D9D),
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w700,
                                                            height: (22 / 18),
                                                            fontFamily: "Roboto",
                                                          ),
                                                        ),
                                                      ),

                                                      Container(
                                                        child: Icon(Icons.more_horiz,color: Color(0XFFFFb0b0b0),),
                                                      )

                                                    ],
                                                  ),
                                                ),

                                                SizedBox(height: 4,),

                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Container(
                                                    child: Text(

                                                      followingList[index].message??'',
                                                      softWrap:true,style: TextStyle(
                                                      color: Color(0XFF9D9D9D),
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w400,
                                                      height: (16 / 14),
                                                      fontFamily: "Roboto",
                                                    ),
                                                    ),
                                                  ),
                                                )

                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Divider(),

                                // ]
                            // ),
                          );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),









    );
  }
}
