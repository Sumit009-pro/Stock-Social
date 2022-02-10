import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_social/messages.dart';
import 'package:stock_social/models/activity_count_model.dart';
import 'package:stock_social/models/api.dart';
import 'package:stock_social/models/user_model.dart';
import 'package:stock_social/notification.dart';


class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> with SingleTickerProviderStateMixin {
  bool process = false;
  ResponseData? actvityCount;
  var popMenu='Last 1 day';

// FollowingModel following
  late AnimationController _controller;
  Animation? gradientPosition;
  UserModel? userDetails;
  List<dynamic> sortByList = [
    {"value": 1, "name": "Last 1 day"},
    {"value": 2, "name": "Last 7 days"},
    {"value": 3, "name": "Last 1 month"},
  ];

  @override
  void initState() {
    // TODO: implement initState
    userDetails = UserModel.getInstance();
    fetchActivityCount(userDetails?.userId ?? '','1');
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
  var followers,
  following,
  posts,
  like,
  share,
  comment;

  void fetchActivityCount(String id,String day) async {
    final response = await API.fetchActivityCount({'userId': id,'day':day});
    print(response.toString());
    if (response["STATUSCODE"] == 200) {
      print("code : 200");
      var rest = response["response_data"];
      setState(() {
        followers=rest['followers'].toString();
            following=rest['following'].toString();
            posts=rest['posts'].toString();
            like=rest['like'].toString();
            share=rest['share'].toString();
            comment=rest['comment'].toString();
        // actvityCount = rest
        //     .map<ResponseData>((json) => ResponseData.fromJson(json));
        process = false;
      });
    } else {
      setState(() {
        process = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar((SnackBar(content: Text(response["message"]))));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
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
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          centerTitle: true,
          title: Text(
            'Activity',
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
              },
            ),
          ],
        ),
      ),
      body:process
          ?
      Container(
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
          : Container(
        color: Colors.white,
        constraints: BoxConstraints.expand(),
        child: Column(
          children: [

            Container(
              margin: EdgeInsets.only(top: 20,),
              child: CircleAvatar(
                radius: 21,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.bar_chart_rounded,color: Colors.grey,),
                ),
              )
            ),

            Container(
              padding: EdgeInsets.only(top:10,left: 20,right: 20),
              child: Text('Activity  Overview',
              softWrap: true,maxLines: 2,
              style: TextStyle(
                color: Color(0XFF9D9D9D),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: (17 / 14),
                fontFamily: "Roboto",
               ),
              )
            ),

            Container(
              margin: EdgeInsets.only(top: 5,left: 30,right: 30),
                child: Text('Take a deeper look how your profile and content are performing during selected period.',
                  softWrap: true,maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0XFFFFb0b0b0),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    height: (17 / 14),
                    fontFamily: "Roboto",
                  ),
                )
            ),
            Container(
              margin: EdgeInsets.only(top: 20,left: 20,right: 20,),
              height:MediaQuery.of(context).size.height/17.5,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(6), ),
              ),
              child:
              PopupMenuButton(
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                  child: Container(
                      height: MediaQuery.of(context).size.height / 17.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height:
                            MediaQuery.of(context).size.height / 17.5,
                            decoration: BoxDecoration(
                              color: Color(0XFFFE99AC),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  bottomLeft: Radius.circular(6)),
                            ),
                            width: MediaQuery.of(context).size.width / 13,
                            child:
                            Icon(Icons.title,color: Colors.white,),
                          ),
                          Container(
                              alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only( topRight: Radius.circular(6),
                                    bottomRight: Radius.circular(6)),
                                color:Color(0XFFffe6ea),),
                              padding: EdgeInsets.only(
                                left: 5,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    child: Text(
                                     popMenu,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      )),
                  elevation: 40,
                  enabled: true,
                  offset: Offset(0, 50),
                  onSelected: (value) {
                   setState(() {
                     /* watchList = false;
                      process = true;*/

                      if (value == 1){
                        popMenu='Last 1 day';
                        fetchActivityCount(userDetails?.userId ?? '','1');}

                      else if (value == 2){
                        popMenu='Last 7 days';

                        fetchActivityCount(userDetails?.userId ?? '','7');}

                      else if (value == 3)   {
                        popMenu='Last 1 month';

                        fetchActivityCount(userDetails?.userId ?? '','30');}

                   });
                  },
                  itemBuilder: (context) {
                    return sortByList.map((dynamic choice) {
                      return PopupMenuItem(
                        value: choice["value"],
                        child: Text(
                          choice["name"],
                          style: TextStyle(
                              color: Color(0XFFFFb0b0b0),
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList();
                  }),
            ),
            /*Container(
                margin: EdgeInsets.only(top: 20,left: 20,right: 20,),
                height:MediaQuery.of(context).size.height/17.5,
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6), ),
                ),
                child:Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Container(
                      height:MediaQuery.of(context).size.height/17.5,
                      decoration: BoxDecoration(
                        color: Color(0XFFFE99AC),
                        borderRadius: BorderRadius.only( topLeft: Radius.circular(6),
                            bottomLeft: Radius.circular(6)),
                      ),
                      width: MediaQuery.of(context).size.width/13,
                      child:Icon(Icons.title,color: Colors.white,),
                    ),

                    Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only( topRight: Radius.circular(6),
                              bottomRight: Radius.circular(6)),
                          color:Color(0XFFffe6ea),
                        ),
                        padding: EdgeInsets.only(left: 5,),
                        child:Row(
                          children: [

                            Container(
                              child:  Text("Last 7 days",
                                textAlign: TextAlign.center,
                                style: TextStyle( color: Colors.grey,fontSize: 10,
                                  fontFamily: "Roboto",),),
                            ),

                            Container(
                              child:Icon(Icons.arrow_drop_down,color: Colors.grey,),
                            ),

                          ],
                        )
                    ),

                  ],
                )
            ),*/

            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 15,bottom: 20),
                child: ListView(
                  shrinkWrap: true,
                  children: [

                    Divider(thickness: 1,),

                  /*  Container(
                      margin: EdgeInsets.only(top: 15,left: 20,right: 20,bottom: 15),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Flexible(
                            child: Container(
                              child: Text('Account Reached',
                                softWrap: true,maxLines: 2,
                                style: TextStyle(
                                  color: Color(0XFF9D9D9D),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  height: (17 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 15,),

                          Container(
                            child: Text('600',
                              style: TextStyle(
                                color: Color(0XFFFFb0b0b0),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: (17 / 14),
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),

                        ],
                      )
                    ),

                    Divider(thickness: 1,),

                    Container(
                        margin: EdgeInsets.only(top: 15,left: 20,right: 20,bottom: 15),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Flexible(
                              child: Container(
                                child: Text('Content Interactions',
                                  softWrap: true,maxLines: 2,
                                  style: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: (17 / 14),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 15,),

                            Container(
                              child: Text('600',
                                style: TextStyle(
                                  color: Color(0XFFFFb0b0b0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: (17 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),

                          ],
                        )
                    ),

                    Divider(thickness: 1,),*/

                    Container(
                        margin: EdgeInsets.only(top: 15,left: 20,right: 20,bottom: 15),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Flexible(
                              child: Container(
                                child: Text('Followers',
                                  softWrap: true,maxLines: 2,
                                  style: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: (17 / 14),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 15,),

                            Container(
                              child: Text(followers??'0',
                                style: TextStyle(
                                  color: Color(0XFFFFb0b0b0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: (17 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),

                          ],
                        )
                    ),

                    Divider(thickness: 1,),

                    Container(
                        margin: EdgeInsets.only(top: 15,left: 20,right: 20,bottom: 15),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Flexible(
                              child: Container(
                                child: Text('Following',
                                  softWrap: true,maxLines: 2,
                                  style: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: (17 / 14),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 15,),

                            Container(
                              child: Text(following??'0',
                                style: TextStyle(
                                  color: Color(0XFFFFb0b0b0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: (17 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),

                          ],
                        )
                    ),

                    Divider(thickness: 1,),

                    Container(
                        margin: EdgeInsets.only(top: 15,left: 20,right: 20,bottom: 15),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Flexible(
                              child: Container(
                                child: Text('Your Posts',
                                  softWrap: true,maxLines: 2,
                                  style: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: (17 / 14),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 15,),

                            Container(
                              child: Text(posts??'0',
                                style: TextStyle(
                                  color: Color(0XFFFFb0b0b0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: (17 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),

                          ],
                        )
                    ),

                    Divider(thickness: 1,),

                    Container(
                        margin: EdgeInsets.only(top: 15,left: 20,right: 20,bottom: 15),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Flexible(
                              child: Container(
                                child: Text('Posts You Shared',
                                  softWrap: true,maxLines: 2,
                                  style: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: (17 / 14),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 15,),

                            Container(
                              child: Text(share??'0',
                                style: TextStyle(
                                  color: Color(0XFFFFb0b0b0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: (17 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),

                          ],
                        )
                    ),

                    Divider(thickness: 1,),

                    Container(
                        margin: EdgeInsets.only(top: 15,left: 20,right: 20,bottom: 15),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Flexible(
                              child: Container(
                                child: Text('Posts You Liked',
                                  softWrap: true,maxLines: 2,
                                  style: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: (17 / 14),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 15,),

                            Container(
                              child: Text(like??'0',
                                style: TextStyle(
                                  color: Color(0XFFFFb0b0b0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: (17 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),

                          ],
                        )
                    ),

                    Divider(thickness: 1,),

                    Container(
                        margin: EdgeInsets.only(top: 15,left: 20,right: 20,bottom: 15),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Flexible(
                              child: Container(
                                child: Text('Posts You Comment',
                                  softWrap: true,maxLines: 2,
                                  style: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: (17 / 14),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 15,),

                            Container(
                              child: Text(comment??'0',
                                style: TextStyle(
                                  color: Color(0XFFFFb0b0b0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: (17 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),

                          ],
                        )
                    ),

                   /* Divider(thickness: 1,),

                    Container(
                        margin: EdgeInsets.only(top: 15,left: 20,right: 20,bottom: 15),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Flexible(
                              child: Container(
                                child: Text('Total Likes You Got',
                                  softWrap: true,maxLines: 2,
                                  style: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: (17 / 14),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 15,),

                            Container(
                              child: Text('600',
                                style: TextStyle(
                                  color: Color(0XFFFFb0b0b0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: (17 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),

                          ],
                        )
                    ),

                    Divider(thickness: 1,),

                    Container(
                        margin: EdgeInsets.only(top: 15,left: 20,right: 20,bottom: 15),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Flexible(
                              child: Container(
                                child: Text('Total Comments You Got',
                                  softWrap: true,maxLines: 2,
                                  style: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: (17 / 14),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 15,),

                            Container(
                              child: Text('600',
                                style: TextStyle(
                                  color: Color(0XFFFFb0b0b0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: (17 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),

                          ],
                        )
                    ),

                    Divider(thickness: 1,),

                    Container(
                        margin: EdgeInsets.only(top: 15,left: 20,right: 20,bottom: 15),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Flexible(
                              child: Container(
                                child: Text('Total Shares You Got',
                                  softWrap: true,maxLines: 2,
                                  style: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: (17 / 14),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 15,),

                            Container(
                              child: Text('600',
                                style: TextStyle(
                                  color: Color(0XFFFFb0b0b0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: (17 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),

                          ],
                        )
                    ),*/

                    Divider(thickness: 1,),

                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
