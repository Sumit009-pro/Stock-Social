import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stock_social/models/api.dart';
import 'package:stock_social/models/block_list_model.dart';
import 'package:stock_social/models/user_model.dart';

class Blocked extends StatefulWidget {
  const Blocked({Key? key}) : super(key: key);

  @override
  _BlockedState createState() => _BlockedState();
}

class _BlockedState extends State<Blocked> with SingleTickerProviderStateMixin {
  bool process = false;
  List<ResponseDatum> blockList = [];

// FollowingModel following
  late AnimationController _controller;
  Animation? gradientPosition;
  UserModel? userDetails;

  @override
  void initState() {
    // TODO: implement initState
    userDetails = UserModel.getInstance();
    fetchBlockList(userDetails?.userId ?? '');
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

  void fetchBlockList(String id) async {
    final response = await API.fetchBlockList({'userId': id});
    print(response.toString());
    if (response["STATUSCODE"] == 200) {
      print("code : 200");
      var rest = response["response_data"] as List;
      setState(() {
        blockList = rest
            .map<ResponseDatum>((json) => ResponseDatum.fromJson(json))
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
              'Block List',
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
      body:
      process
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
          :

      blockList.length > 0 ?   blockList[0].blockList!.length>0 ?

      Column(children: [
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
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: blockList.length > 0
                          ? blockList[0].blockList!.length
                          : 0,
                      // followingList.length > 0? followingList!.length
                      //     :0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 16, bottom: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [

                                  blockList[0].blockList![index]
                                      .profileImage ==
                                      ''||blockList[0].blockList![index]
                                  .profileImage ==null
                                      ? CircleAvatar(
                                    radius: 20,
                                    // backgroundColor: Colors.yellowAccent,
                                    backgroundImage: AssetImage(
                                      "assets/images/profile.png",
                                    ),
                                  )
                                      : ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: "${blockList[0].blockList![index]
                                          .profileImage}",
                                      imageBuilder:
                                          (context, imageProvider) =>
                                          Container(
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
                                      placeholder: (context, url) =>
                                          ClipOval(
                                            child: Container(
                                                height: 40,
                                                width: 40,
                                                child: Image.asset(
                                                    'assets/logo.png')),
                                          ),
                                      errorWidget:
                                          (context, url, error) => Icon(
                                        Icons.error,
                                        size: 40,
                                      ),
                                    ),
                                  ),


                                 /* CircleAvatar(
                                    backgroundColor: Color(0XFFF1F1F1),
                                    child: const Text('SK'),
                                  ),*/
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    '${blockList[0].blockList![index].userName}',
                                    style: TextStyle(
                                      color: Color(0XFF808080),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: (16 / 14),
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Blocked',
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
                                  InkWell(
                                    onTap: () async {
                                      final response = await API.unBlockUser({
                                        'userId':'${blockList[0].blockList![index].id}'
                                      });
                                      print(response.toString());
                                      if (response["STATUSCODE"] == 200) {
                                        print("code : 200");

                                        // var rest = response["response_data"] as List;
                                        setState(() {
                                          fetchBlockList(userDetails?.userId ?? '');
                                          // followingList = rest
                                          //     .map<ResponseDatum>((json) => ResponseDatum.fromJson(json))
                                          //     .toList();
                                          // block = !block;
                                        });
                                      } else {
                                        // setState(() {
                                        //   process = false;
                                        // });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar((SnackBar(content: Text(response["message"]))));
                                      }
                                    },
                                    child: Text(
                                      'Unblock',
                                      style: TextStyle(
                                        color: Color(0XFFFFb0b0b0),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        height: (16 / 14),
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }),

                  /*  ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 16, bottom: 16),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0XFFF1F1F1),
                            child: const Text('SK'),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            'Lorem Ipsum',
                            style: TextStyle(
                              color: Color(0XFF808080),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: (16 / 14),
                              fontFamily: "Roboto",
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Blocked',
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
                            'Unblock',
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
                ),*/

                  // ],
                ),
              ),
              // )
            ]):
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.person_outline,
              color: Colors.black12,
              size: 110,
            ),
          ),
          Text(
            'No user in block list',
            style: TextStyle(
              color: Colors.black12,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ):
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.person_outline,
              color: Colors.black12,
              size: 110,
            ),
          ),
          Text(
            'No user in block list',
            style: TextStyle(
              color: Colors.black12,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
