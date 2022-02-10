import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_social/bottombar/rooms/demo_room.dart';
import 'package:stock_social/messages.dart';
import 'package:stock_social/notification.dart';
import 'package:stock_social/menu/menu.dart';
import 'package:stock_social/bottombar/rooms/create_a_room.dart';
import 'package:stock_social/bottombar/rooms/joined_room.dart';
import 'package:stock_social/bottombar/rooms/public_room.dart';

class Rooms extends StatefulWidget {

  @override
  _RoomsState createState() => _RoomsState();
  }

class _RoomsState extends State<Rooms> with TickerProviderStateMixin{

  bool hide=false;

  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );

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
                icon: const Icon(Icons.sort),
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
      body: Container(
        color: Colors.white,
        child:Column(
            children: <Widget>[

              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[

                    Visibility(
                      visible: hide ? false : true,
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text(
                          'Rooms',
                          style: TextStyle(
                            color: Color(0XFF9D9D9D),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: (22 / 18),
                            fontFamily: "Roboto",
                          ),
                        ),
                      ),
                    ),

                   Visibility(
                     visible: hide ? false : true,
                     child: Container(
                        margin: EdgeInsets.only(top:5,bottom: 15),
                        width: MediaQuery.of(context).size.width/1.2,
                        child: Text(
                          'Rooms is chat platform where people can communicate with each other, to better invest and trade.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0XFFFFb0b0b0),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            height: (14 / 12),
                            fontFamily: "Roboto",
                          ),
                        ),
                      ),
                   ),

                   Visibility(
                     visible: hide ? false : true,
                     child: Container(
                        child: DefaultTabController(
                          length: 2,
                          child: Container(
                            margin: EdgeInsets.only(left:10,right: 10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color:Color(0XFFffe6ea),
                            ),
                            height: 50,
                            child: TabBar(
                              unselectedLabelColor:Color(0XFF9D9D9D),
                              onTap: (value){
                                if(value==0)
                                  Navigator.push(context,CupertinoPageRoute(builder: (context) =>
                                      CreateARoom()));
                                else
                                  Navigator.push(context,CupertinoPageRoute(builder: (context) =>
                                      DemoRoom()));
                              },
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0XFFFE99AC)
                              ),
                              unselectedLabelStyle: TextStyle(
                                color: Color(0XFF9D9D9D),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: (17 / 14),
                                fontFamily: "Roboto",
                              ),
                              labelStyle: TextStyle(
                                color: Color(0XFFFFFFFF),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: (17 / 14),
                                fontFamily: "Roboto",
                              ),
                              tabs: [
                                Tab(
                                  text: "Create",
                                ),
                                Tab(
                                  text: "My Rooms",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                   ),

                  /* Visibility(
                     visible: hide ? false : true,
                     child: MyMaterialButton(
                        width: MediaQuery.of(context).size.width/1.3,
                        tittle: 'Create Your Own Room',
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => CreateARoom()));
                        },
                      ),
                   ),*/

                    Visibility(
                      visible: hide ? false : true,
                      child: Container(
                        margin: EdgeInsets.only(top: 20,),
                        child: Text(
                          'Join Room',
                          style: TextStyle(
                            color: Color(0XFF9D9D9D),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: (22 / 18),
                            fontFamily: "Roboto",
                          ),
                        ),
                      ),
                    ),

                    Container(
                      child: DefaultTabController(
                        length: 2,
                        child: Container(
                          margin: EdgeInsets.only(left:10,right: 10,top: 20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color:Color(0XFFffe6ea),
                          ),
                          height: 50,
                          child: TabBar(
                            controller: _tabController,
                            unselectedLabelColor:Color(0XFF9D9D9D),
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(0XFFFE99AC)
                            ),
                            unselectedLabelStyle: TextStyle(
                              color: Color(0XFF9D9D9D),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: (17 / 14),
                              fontFamily: "Roboto",
                            ),
                            labelStyle: TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: (17 / 14),
                              fontFamily: "Roboto",
                            ),
                            tabs: [
                              Tab(
                                text: "All Rooms",
                              ),
                            /*  Tab(
                                text: "Private",
                              ),*/
                              Tab(
                                text: "Joined Rooms",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox( height: 5),

                    Divider(thickness: 2,),

                    SizedBox( height: 15),
                  ],
                ),
              ),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    PublicRoom(scrollScreen: scrollScreen,),
                  //  PrivateRoom(scrollScreen: scrollScreen,),
                    JoinedRoom(scrollScreen: scrollScreen,),
                  ],
                ),
              ),

            ],
          ),
        ),
    );
  }

  void scrollScreen(bool data){
    setState(() { hide=data; });
  }

}
