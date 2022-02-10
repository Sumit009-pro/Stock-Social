import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_social/models/api.dart';
import 'package:stock_social/models/following_model.dart';

class FollowingPage extends StatefulWidget {
  final String userId;
  const FollowingPage({Key? key, required this.userId}) : super(key: key);

  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage>
    with SingleTickerProviderStateMixin {
  bool process = false;
  List<ResponseDatum> followingList = [];

  // FollowingModel following
  late AnimationController _controller;
  Animation? gradientPosition;

  @override
  void initState() {
    // TODO: implement initState
    fetchAllFollowing(widget.userId);
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

  void fetchAllFollowing(String id) async {
    final response = await API.fetchAllFollowing(id);
    print(response.toString());
    if (response["STATUSCODE"] == 200) {
      print("code : 200");
      var rest = response["response_data"] as List;
      setState(() {
        followingList = rest
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
          'Following',
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
      body:
      process
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
          : Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      followingList.length >0? '${followingList[0].following!.length} Following':'',
                      softWrap: true,
                      maxLines: 2,
                      style: TextStyle(
                        color: Color(0XFF9D9D9D),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: (17 / 14),
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: followingList.length > 0
                              ? followingList[0].following!.length
                              : 0,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: followingList[0].following![index]
                                          .profileImage ==
                                      ''
                                  ? CircleAvatar(
                                      radius: 24,
                                      // backgroundColor: Colors.yellowAccent,
                                      backgroundImage: AssetImage(
                                        "assets/images/user_profile.png",
                                      ),
                                    )
                                  :
                              ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: "${followingList[0].following![index].profileImage}",
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
                              ),


                              // CircleAvatar(
                              //         radius: 24,
                              //         backgroundColor: Colors.white,
                              //         backgroundImage:
                              //
                              //         // NetworkImage(
                              //         //     "${followingList[index].userId!.profileImage}")
                              //
                              // ),
                              title: Text(
                                '${followingList[0].following![index].userName}',
                                softWrap: true,
                                maxLines: 1,
                                style: TextStyle(
                                  // letterSpacing: 1,
                                  color: Color(0XFF9D9D9D),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  // height: (17 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                              subtitle: Text(
                                '${followingList[0].following![index].email}',
                                style: TextStyle(
                                  // letterSpacing: 1,
                                  color: Color(0XFF9D9D9D),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  // height: (17 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
