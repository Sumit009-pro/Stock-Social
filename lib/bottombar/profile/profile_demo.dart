import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:readmore/readmore.dart';
import 'package:stock_social/bottombar/profile/activity.dart';
import 'package:stock_social/bottombar/profile/post_news.dart';
import 'package:stock_social/models/api.dart';
import 'package:stock_social/models/post_model.dart';
import 'package:stock_social/models/user_model.dart';
import 'package:stock_social/models/post_fetch_model.dart';
import 'package:stock_social/widgets/my_material_button.dart';

import 'follower_page.dart';
import 'following_page.dart';

class ProfileDemo extends StatefulWidget {
  const ProfileDemo({Key? key}) : super(key: key);

  @override
  _ProfileDemoState createState() => _ProfileDemoState();
}

class _ProfileDemoState extends State<ProfileDemo> with SingleTickerProviderStateMixin{

  bool process=true;

  UserModel? userDetails;
  List<Post> postList = [];
  GetUserData? userData;
  GetCount? count;

  // List<PostModel> postList = [];

  late AnimationController _controller;

  Animation? gradientPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userDetails = UserModel.getInstance();
    fetchAllPostData(userDetails!.userId??'');
    _controller = AnimationController(duration: Duration(milliseconds: 1500), vsync: this);

    gradientPosition = Tween<double>(  begin: -3, end: 10,
    ).animate(  CurvedAnimation( parent: _controller, curve: Curves.linear  ),
    )..addListener(() { if(process) setState(() { }); });

    _controller.repeat();
  }
/* Fetch Details*/
  void fetchAllPostData(String id)async{

    final response = await API.fetchAllPostData(id);
    if (response["STATUSCODE"] == 200) {
      var rest =  response["response_data"] ;
      setState(() {

        postList=rest['post'].map<Post>((json) => Post.fromJson(json)).toList();
        userData=GetUserData.fromJson(rest['getUserData']);
        count=GetCount.fromJson(rest['getCount']);
        // activeCheck=ActiveCheck.fromJson(rest['activeCheck']);
        // follow=activeCheck?.follow ?? false;
        // block=activeCheck?.block ?? false;
        for(int i=0;i<postList.length;i++){
          if(postList[i].likes!=null && postList[i].likes!.length>0){
            for(int j=0;j<postList[i].likes!.length;j++){
              if(userDetails!.userId==postList[i].likes![j].likedBy!.id) {
                postList[i].liked = true;
                postList[i].likedId="${postList[i].likes![j].id}";
              }
              else {
                postList[i].liked = false;
                postList[i].likedId="0";
              }
            }
          }
        }
        process=false;
      });
    }
    else {
      setState(() {    process=false;   });
      ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text(response["message"]))));
    }
  }//func

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
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
          'My Profile',
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
      ),
      body:
      process? Center(child: Container(
          height: 24,
          width: 24,
          child : CircularProgressIndicator())):

      Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              height: MediaQuery.of(context).size.height/4,
              color: Colors.white,
              child: Stack(
                overflow: Overflow.visible,
                children: [

                  Container(
                    height: MediaQuery.of(context).size.height/4.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                            NetworkImage("${userDetails!.coverImage}"),
                            // image: AssetImage('assets/images/vg-bg.png'),
                            fit: BoxFit.cover
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))
                    ),
                  ),

                  Positioned(
                      left: 40,
                      bottom:0,
                      child:Container(
                        child: CircleAvatar(
                          radius: 38.5,
                          backgroundColor:Color(0XFFFFb0b0b0),
                          child: CircleAvatar(
                              radius: 38,
                              backgroundColor: Colors.white,
                              child:CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.white,
                                  backgroundImage:NetworkImage("${userDetails!.profileImage}")
                              )
                          ),
                        ),
                      )
                  ),

                ],
              ),
            ),

            Expanded(
              child: Container(
                child: ListView(
                  shrinkWrap: true,
                  children: [

                    Container(
                      padding:const EdgeInsets.only(left: 14.0, right: 14,top:10,bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text(
                                '${userDetails!.userName}',
                                softWrap: true,maxLines: 2,
                                style: TextStyle(
                                  color: Color(0XFF9D9D9D),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  height: (17 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),
                          ),


                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Container(
                                  child:  RichText(
                                    text: TextSpan(
                                        text: 'Posts ',
                                        style: TextStyle(
                                          color: Color(0XFF9D9D9D),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          height: (17 / 12),
                                          fontFamily: "Roboto",
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: count!.posts.toString(),
                                            style: TextStyle(
                                              color: Color(0XFF9D9D9D),
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

                                SizedBox(width:10),

                                InkWell(
                                onTap: () {
                                Navigator.of(
                                context)
                                    .push(CupertinoPageRoute(
                                builder: (builder) => FollowerPage(
                                userId: userDetails!.userId??'',

                                )));
                                },
                                  child: Container(
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'Follower ',
                                          style: TextStyle(
                                            color: Color(0XFF9D9D9D),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            height: (17 / 12),
                                            fontFamily: "Roboto",
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: count!.followers.toString(),
                                              style: TextStyle(
                                                color: Color(0XFF9D9D9D),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                height: (17 / 12),
                                                fontFamily: "Roboto",
                                              ),
                                            )
                                          ]),
                                    ),
                                  ),
                                ),

                                SizedBox(width:10),

                                InkWell(
                                  onTap: () {
                                    Navigator.of(
                                        context)
                                        .push(CupertinoPageRoute(
                                        builder: (builder) => FollowingPage(
                                          userId: userDetails!.userId??'',

                                        )));
                                  },
                                  child: Container(
                                    child:  RichText(
                                      text: TextSpan(
                                          text: 'Following ',
                                          style: TextStyle(
                                            color: Color(0XFF9D9D9D),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            height: (17 / 12),
                                            fontFamily: "Roboto",
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: count!.following.toString(),
                                              style: TextStyle(
                                                color: Color(0XFF9D9D9D),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                height: (17 / 12),
                                                fontFamily: "Roboto",
                                              ),
                                            )
                                          ]),
                                    ),
                                  ),
                                )


                              ],
                            ),
                          )

                        ],
                      ),
                    ),

                    Container(
                      margin:const EdgeInsets.only(left: 14.0, right: 14,bottom: 10),
                      child: Text(
                       userData!.shortAbout??'---',
                        style: TextStyle(
                          color:Color(0XFFFFb0b0b0),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),

                    /*
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      ' Lives in Australia',
                      style: TextStyle(
                        color: Color(0XFF808080),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto",
                      ),
                    ),*/

                    Container(
                      padding:const EdgeInsets.only(left: 14.0, right: 14,),
                      child: Text(' About',
                        style: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),

                    Padding(
                      padding:EdgeInsets.only(top: 5,left: 15,right: 14,),
                      child: ReadMoreText(
                        userData!.about??'---',
                        // 'The Flutter framework builds its layout via the composition of widgets, everything that you construct programmatically is a widget and these are compiled together to create the user interface.',
                        style: TextStyle(
                          color: Color(0XFFFFb0b0b0),
                          fontSize: 12,
                          fontFamily: "Roboto",
                        ),
                        trimLines: 3,
                        colorClickableText: Color(0XFFFFb0b0b0),
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'read more..',
                        trimExpandedText: ' less',
                        moreStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                        lessStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                      ),
                    ),

                    Container(
                      padding:const EdgeInsets.only(left: 13.0, right: 13,top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(builder: (builder)=>Activity( )));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.width/9,
                              width: MediaQuery.of(context).size.width/3.5,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                                  color: Color(0XFFE5E5E5)),
                              child: Center(
                                child: Text(
                                  'Activity',
                                  style: TextStyle(
                                    color: Color(0XFF808080),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    height: (17 / 14),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                              ),
                            ),
                          ),

                         SizedBox(width: 10,),

                          InkWell(
                            onTap: () {
                              Navigator.of(context,rootNavigator: true).pop();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.width/9,
                              width: MediaQuery.of(context).size.width/3,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                                  color: Color(0XFFE5E5E5)),
                              child: Center(
                                child: Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    color: Color(0XFF808080),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    height: (17 / 14),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 10,),

                          // Visibility(
                          //   visible: false,
                          //   child: InkWell(
                          //     onTap: () {
                          //     },
                          //     child: Container(
                          //       height: MediaQuery.of(context).size.width/9,
                          //       width: MediaQuery.of(context).size.width/5,
                          //       decoration: BoxDecoration(
                          //           borderRadius:
                          //           BorderRadius.all(Radius.circular(30)),
                          //           color: Color(0XFFE5E5E5)),
                          //       child: Center(
                          //         child:Icon(Icons.more_horiz,color:Color(0XFF808080) ,)
                          //         ),
                          //       ),
                          //   ),
                          // ),

                        ],
                      ),
                    ),

                    Container(
                        margin: EdgeInsets.only(top: 5,bottom: 10),
                        child: Divider()
                    ),

                    Container(
                      child: PostNews(),
                    )

                  ],
                ),
              ),
            ),


          ],
        ),
      ),

    );
  }
}
