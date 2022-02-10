import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_social/chat_screen.dart';
import 'package:stock_social/main.dart';
import 'package:stock_social/models/api.dart';
import 'package:stock_social/notification.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {

  List chatUsersList = [];
  bool showLoader = true;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 3000), (timer) {
      if (mounted) {fetchMassagesList();}
      else {timer.cancel();}
    });
  }

  fetchMassagesList() async{
    final response = await API.fetchMessages(
        userDetails!.userId);
    setState(() {
      showLoader = false;
      chatUsersList = response['response_data']['message'];
    });
  }

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
              'Messages',
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

            ],
          )
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        color: Colors.white,
        child: ListView(
            children: [

              Padding(
                padding: EdgeInsets.only(left: 5,right: 5,top: 10),
                child: Container(
                  child: TextField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Color(0XFFFFFFFF), width: 0.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Color(0XFFFFFFFF), width: 0.5),
                      ),
                      filled: true,
                      fillColor:Color(0XFFFFf2f2f2),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey[400],
                        size: 20,
                      ),
                      hintText: 'Search for message',
                      hintStyle: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                    cursorWidth: 1,
                    maxLines: 1,
                  ),
                ),
              ),

              /*Container(
                child: DefaultTabController(
                  length: 3,
                  child: Container(
                    margin: EdgeInsets.only(left:10,right: 10,top: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color:Color(0XFFffe6ea),
                    ),
                    height: MediaQuery.of(context).size.height/12,
                    child: TabBar(
                      unselectedLabelColor:Color(0XFF9D9D9D),
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0XFFFE99AC)
                      ),
                      unselectedLabelStyle: TextStyle(
                        color: Color(0XFF9D9D9D),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: (17 / 14),
                        fontFamily: "Roboto",
                      ),
                      labelStyle: TextStyle(
                        color: Color(0XFFFFFFFF),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: (17 / 14),
                        fontFamily: "Roboto",
                      ),
                      tabs: [

                        Tab(
                          child: Text("Direct message",textAlign: TextAlign.center,)
                        ),

                        Tab(
                            child: Text("Private Room's message",textAlign: TextAlign.center,)
                        ),

                        Tab(
                            child: Text("Public Room's message",textAlign: TextAlign.center,)
                        ),

                      ],
                    ),
                  ),
                ),
              ),*/
              showLoader ? Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 100.0),
                  child: CircularProgressIndicator(color: Colors.pinkAccent,),
                ),
              ) :
          ListView.builder(
            controller: ScrollController(),
            itemCount: chatUsersList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, index){
              String userName = chatUsersList[index]['fromUserId'] !=
                  userDetails!.userId ? chatUsersList[index]['fromuser'][0]['firstName'] +
                  " " +chatUsersList[index]['fromuser'][0]['lastName'] :
              chatUsersList[index]['touser'][0]['firstName'] +
                  " " +chatUsersList[index]['fromuser'][0]['lastName'];

              String image = chatUsersList[index]['fromUserId'] !=
                  userDetails!.userId ? chatUsersList[index]['fromuser'][0]['profileImage']
                  : chatUsersList[index]['touser'][0]['profileImage'];

              String imageUrl = "http://nodeserver.mydevfactory.com:8086/img/profile-pic/"
                  + image;

              return GestureDetector(
                onTap: (){
                  print("?????????????"+userDetails!.userId.toString());
                  String userId = chatUsersList[index]['fromUserId'] !=
                      userDetails!.userId ? chatUsersList[index]['fromUserId'] :
                  chatUsersList[index]['toUserId'];
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  ChatScreen(
                      name: userName,
                      image: imageUrl,
                      toUserId: userId,
                      msgType: "NORMAL",
                    )),
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Color(0XFFFFFFFF),
                  ),
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      leading: ClipOval(
                        child:
                        // chatUsersList[index]['fromuser'][0]['profileImage'].toString().isEmpty ?
                        // CircleAvatar(
                        //   backgroundColor: Color(0XFFF1F1F1),
                        //      child: Image.asset('assets/images/user-profile.png')
                        // ) :
                        CachedNetworkImage(
                            imageUrl: imageUrl,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  // colorFilter:
                                  // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                ),
                              ),
                            ),
                            placeholder: (context, url) => ClipOval(
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset('assets/images/user_profile.png')),
                            ),
                            errorWidget: (context, url, error) => ClipOval(
                                child: Image.asset(
                                  'assets/images/user_profile.png',
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ))
                        ),
                      ),
                      title: Text(
                        userName,
                        style: TextStyle(
                          //color: Color(0XFFFFb0b0b0),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: (22 / 18),
                          fontFamily: "Roboto",
                        ),
                      ),
                      subtitle: Text(chatUsersList[index]['messageType'] == "POST" ?
                      chatUsersList[index]['fromUserId'] ==
                          userDetails!.userId ? "➦ You shared a post" : "➦ "+userName+" "
                          "shared a post" :
                        chatUsersList[index]['message'].toString().length > 30 ?
                        chatUsersList[index]['message'].toString().substring(0, 30)+"..."
                        : chatUsersList[index]['message'].toString(),
                        style: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: (16 / 14),
                          fontFamily: "Roboto",
                        ),
                      ),
                      trailing: Icon(Icons.more_horiz,
                        //color: Color(0XFFFFb0b0b0),
                      ),
                    ),
                  ),
                ),
              );
            },
          )

        ]),
      ),
    );
  }
}
