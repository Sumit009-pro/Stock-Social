import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_social/bottombar/dashboard/category/comments.dart';
import 'package:stock_social/bottombar/dashboard/category/share_post.dart';
import 'package:stock_social/bottombar/profile/post_comments.dart';
import 'package:stock_social/models/api.dart';

// import 'package:stock_social/models/post_details_model.dart';
import 'package:stock_social/models/post_fetch_model.dart';
import 'package:stock_social/models/post_model.dart';
import 'package:stock_social/models/user_model.dart';
import 'package:stock_social/widgets/loading_spinner.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'image_full_screen.dart';
import 'other_profile.dart';

class PostDetails extends StatefulWidget {
  final String? id;

  const PostDetails({Key? key, this.id}) : super(key: key);

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails>
    with SingleTickerProviderStateMixin {
  bool process = true;

  UserModel? userDetails;

  List<Post> postList = [];

  // List<Post> postList = [];

  late AnimationController _controller;

  Animation? gradientPosition;

  ScrollController? scrollController;

  String id = "all";

  @override
  void initState() {
    // TODO: implement initState

    if (widget.id != null) id = "${widget.id}";

    fetchAllPostData(id);

    super.initState();

    scrollController = new ScrollController();

    userDetails = UserModel.getInstance();

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
          'Post',
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
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color:Colors.white,
          child: Container(
              padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
              child: process
                  ? Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: ClampingScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
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
                                        begin:
                                            Alignment(gradientPosition!.value, 0),
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  15,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
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
                                                MediaQuery.of(context).size.width /
                                                    5,
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
                                        begin:
                                            Alignment(gradientPosition!.value, 0),
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
                                        begin:
                                            Alignment(gradientPosition!.value, 0),
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
                            );
                          }),
                    )
                  : postList.length > 0
                      ? Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: postList.length > 0 ? postList.length : 0,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Container(
                                      child: Card(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8)),
                                        child: Container(
                                          padding:
                                              EdgeInsets.only(top: 8, bottom: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Visibility(
                                                visible: postList[index]
                                                                .sharePost !=
                                                            null &&
                                                        postList[index].postType ==
                                                            "share"
                                                    ? true
                                                    : false,
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    left: 8,
                                                    right: 8,
                                                    top: 7,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            if (postList[index]
                                                                        .postType ==
                                                                    "share" &&
                                                                postList[index]
                                                                        .createdBy!
                                                                        .id !=
                                                                    userDetails!
                                                                        .userId)
                                                              Navigator.of(context).push(
                                                                  CupertinoPageRoute(
                                                                      builder:
                                                                          (builder) =>
                                                                              OtherProfile()));
                                                          },
                                                          child: Container(
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  child:
                                                                      CircleAvatar(
                                                                    radius: 20.5,
                                                                    backgroundColor:
                                                                        Color(
                                                                            0XFFFFb0b0b0),
                                                                    child: CircleAvatar(
                                                                        radius: 20,
                                                                        backgroundColor: Colors.white,
                                                                        child: postList[index].createdBy!.profileImage == ""
                                                                            ? CircleAvatar(
                                                                                radius:
                                                                                    17,
                                                                                backgroundColor:
                                                                                    Colors.white,
                                                                                backgroundImage:
                                                                                    AssetImage(
                                                                                  "assets/images/user_profile.png",
                                                                                ),
                                                                              )
                                                                            : CircleAvatar(radius: 17, backgroundColor: Colors.white, backgroundImage: NetworkImage("${postList[index].createdBy!.profileImage}"))),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Flexible(
                                                                  child: Container(
                                                                    child: Text(
                                                                      '${postList[index].createdBy!.userName}',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0XFF9D9D9D),
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        height:
                                                                            (17 /
                                                                                14),
                                                                        fontFamily:
                                                                            "Roboto",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          "${timeago.format(DateTime.parse("${postList[index].createdAt}").subtract(new Duration(minutes: 1)), locale: 'en_short')}",
                                                          style: TextStyle(
                                                            color:
                                                                Color(0XFF9D9D9D),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            height: (17 / 14),
                                                            fontFamily: "Roboto",
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: postList[index]
                                                                .sharePost !=
                                                            null &&
                                                        postList[index].postType ==
                                                            "share"
                                                    ? true
                                                    : false,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                      left: 10,
                                                      right: 8),
                                                  child: Text(
                                                    '${postList[index].content}',
                                                    softWrap: true,
                                                    maxLines: 4,
                                                    style: TextStyle(
                                                      color: Color(0XFFFFb0b0b0),
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w500,
                                                      height: (17 / 14),
                                                      fontFamily: "Roboto",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                  visible:
                                                      postList[index].sharePost !=
                                                                  null &&
                                                              postList[index]
                                                                      .postType ==
                                                                  "share"
                                                          ? true
                                                          : false,
                                                  child: Divider(
                                                    thickness: 1,
                                                  )),
                                              Container(
                                                  padding: EdgeInsets.only(
                                                      left: 8, right: 8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          '${postList[index].subCategoryId?.name}',
                                                          style: TextStyle(
                                                            color:
                                                                Color(0XFF9D9D9D),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            height: (17 / 14),
                                                            fontFamily: "Roboto",
                                                          ),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: postList[index]
                                                                        .sharePost !=
                                                                    null &&
                                                                postList[index]
                                                                        .postType ==
                                                                    "share"
                                                            ? false
                                                            : true,
                                                        child: Container(
                                                          child: Text(
                                                            "${timeago.format(DateTime.parse("${postList[index].createdAt}").subtract(new Duration(minutes: 1)), locale: 'en_short')}",
                                                            style: TextStyle(
                                                              color:
                                                                  Color(0XFF9D9D9D),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              height: (17 / 14),
                                                              fontFamily: "Roboto",
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 8, right: 8),
                                                margin: EdgeInsets.only(top: 3),
                                                child: Text(
                                                  '${postList[index].subCategoryId!.hashtag}',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: Color(0XFF9D9D9D),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Roboto",
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: postList[index].image !=
                                                            "" ||
                                                        (postList[index]
                                                                    .sharePost !=
                                                                null &&
                                                            postList[index]
                                                                    .sharePost!
                                                                    .image !=
                                                                "")
                                                    ? true
                                                    : false,
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                                                      return ImageFullScreen(image:postList[index]
                                                          .postType ==
                                                      "share" &&
                                                      postList[index]
                                                          .sharePost !=
                                                      null
                                                      ?
                                                      "${postList[index].sharePost!.image}"
                                                          :
                                                      "${postList[index].image}");
                                                    }));
                                                  },
                                                  child: Hero(
                                                    tag: 'imageHero',
                                                    child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 5, left: 8, right: 8),
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                        height: MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            4,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(8)),
                                                            border: Border.all(
                                                                color:
                                                                    Color(0XFFFFb0b0b0),
                                                                width: 0.2),
                                                            image: DecorationImage(
                                                              image: postList[index]
                                                                              .postType ==
                                                                          "share" &&
                                                                      postList[index]
                                                                              .sharePost !=
                                                                          null
                                                                  ? NetworkImage(
                                                                      "${postList[index].sharePost!.image}")
                                                                  : NetworkImage(
                                                                      "${postList[index].image}"),
                                                              fit: BoxFit.fitWidth,
                                                            ))),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (postList[index].postType !=
                                                          "share" &&
                                                      postList[index]
                                                              .createdBy!
                                                              .id !=
                                                          userDetails!.userId)
                                                    Navigator.of(context).push(
                                                        CupertinoPageRoute(
                                                            builder: (builder) =>
                                                                OtherProfile()));
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    left: 8,
                                                    right: 8,
                                                    top: 7,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        child: CircleAvatar(
                                                          radius: 20.5,
                                                          backgroundColor:
                                                              Color(0XFFFFb0b0b0),
                                                          child: CircleAvatar(
                                                              radius: 20,
                                                              backgroundColor:
                                                                  Colors.white,
                                                              child: (postList[index].postType == "share" &&
                                                                          postList[index]
                                                                                  .sharePost !=
                                                                              null &&
                                                                          postList[index]
                                                                                  .sharePost!
                                                                                  .createdBy!
                                                                                  .profileImage ==
                                                                              "") ||
                                                                      postList[index]
                                                                              .createdBy!
                                                                              .profileImage ==
                                                                          ""
                                                                  ? CircleAvatar(
                                                                      radius: 17,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      backgroundImage:
                                                                          AssetImage(
                                                                        "assets/images/user_profile.png",
                                                                      ),
                                                                    )
                                                                  : CircleAvatar(
                                                                      radius: 17,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      backgroundImage: postList[index].postType ==
                                                                                  "share" &&
                                                                              postList[index].sharePost !=
                                                                                  null
                                                                          ? NetworkImage(
                                                                              "${postList[index].sharePost!.createdBy!.profileImage}")
                                                                          : NetworkImage(
                                                                              "${postList[index].createdBy!.profileImage}"))),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                          child: Text(
                                                            '${(postList[index].postType == "share" && postList[index].sharePost != null) ? postList[index].sharePost!.createdBy!.userName : postList[index].createdBy!.userName}',
                                                            style: TextStyle(
                                                              color:
                                                                  Color(0XFF9D9D9D),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              height: (17 / 14),
                                                              fontFamily: "Roboto",
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                    left: 10,
                                                    right: 8),
                                                child: Text(
                                                  '${(postList[index].postType == "share" && postList[index].sharePost != null) ? postList[index].sharePost!.content : postList[index].content}',
                                                  softWrap: true,
                                                  maxLines: 4,
                                                  style: TextStyle(
                                                    color: Color(0XFFFFb0b0b0),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    height: (17 / 14),
                                                    fontFamily: "Roboto",
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                thickness: 1,
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () async {
                                                          if (postList[index]
                                                                      .liked !=
                                                                  null &&
                                                              postList[index]
                                                                      .liked ==
                                                                  true) {
                                                            final response =
                                                                await API.removeLikes(
                                                                    "${postList[index].id}");

                                                            if (response[
                                                                    "STATUSCODE"] ==
                                                                200) {
                                                              setState(() {
                                                                postList[index]
                                                                    .liked = false;

                                                                for (int j = 0;
                                                                    j <
                                                                        postList[
                                                                                index]
                                                                            .likes!
                                                                            .length;
                                                                    j++) {
                                                                  if (postList[
                                                                              index]
                                                                          .likedId ==
                                                                      postList[
                                                                              index]
                                                                          .likes![j]
                                                                          .id)
                                                                    postList[index]
                                                                        .likes!
                                                                        .removeAt(
                                                                            j);
                                                                }
                                                              });
                                                            }

                                                            ScaffoldMessenger.of(
                                                                    context)
                                                                .showSnackBar((SnackBar(
                                                                    content: Text(
                                                                        response[
                                                                            "message"]))));
                                                          } else {
                                                            final response =
                                                                await API.addLikes(
                                                                    "${postList[index].id}");

                                                            if (response[
                                                                    "STATUSCODE"] ==
                                                                200) {
                                                              setState(() {
                                                                postList[index]
                                                                    .liked = true;
                                                                postList[index]
                                                                        .likedId =
                                                                    "${response["response_data"]["_id"]}";

                                                                var profileImage =
                                                                    userDetails!
                                                                        .profileImage!
                                                                        .split("/");
                                                                var data = {
                                                                  "created_At":
                                                                      "${response["response_data"]["created_At"]}",
                                                                  "_id":
                                                                      "${response["response_data"]["_id"]}",
                                                                  "likedBy": {
                                                                    "userName":
                                                                        "${userDetails!.userName}",
                                                                    "profileImage":
                                                                        "${profileImage[profileImage.length - 1]}",
                                                                    "_id":
                                                                        "${userDetails!.userId}",
                                                                    "email":
                                                                        "${userDetails!.email}"
                                                                  }
                                                                };
                                                                postList[index]
                                                                    .likes!
                                                                    .insert(
                                                                        0,
                                                                        Like.fromJson(
                                                                            data));
                                                              });
                                                            }

                                                            ScaffoldMessenger.of(
                                                                    context)
                                                                .showSnackBar((SnackBar(
                                                                    content: Text(
                                                                        response[
                                                                            "message"]))));
                                                          }
                                                        },
                                                        child: Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                child: Image.asset(
                                                                  "assets/images/like.png",
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      20,
                                                                  color: postList[index].liked !=
                                                                              null &&
                                                                          postList[index]
                                                                                  .liked ==
                                                                              true
                                                                      ? Color(
                                                                          0XFFFE99AC)
                                                                      : Colors.grey,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  '${postList[index].likes!.length}',
                                                                  maxLines: 1,
                                                                  style: TextStyle(
                                                                    color: Color(
                                                                        0XFF9D9D9D),
                                                                    fontSize: 12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontFamily:
                                                                        "Roboto",
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          showModalBottomSheet(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.vertical(
                                                                        top: Radius
                                                                            .circular(
                                                                                25.0)),
                                                              ),
                                                              context: context,
                                                              isDismissible: true,
                                                              isScrollControlled:
                                                                  true,
                                                              builder: (BuildContext
                                                                  buildContext) {
                                                                return Container(
                                                                    height: MediaQuery.of(
                                                                                context)
                                                                            .size
                                                                            .height /
                                                                        1.12,
                                                                    child: PostComments(
                                                                        postData:
                                                                            postList[
                                                                                index]));
                                                              }).whenComplete(() {});
                                                        },
                                                        child: Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                  child:
                                                                      Image.asset(
                                                                "assets/images/comment.png",
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    20,
                                                              )),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  '${postList[index].comments!.length}',
                                                                  maxLines: 1,
                                                                  style: TextStyle(
                                                                    color: Color(
                                                                        0XFF9D9D9D),
                                                                    fontSize: 12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontFamily:
                                                                        "Roboto",
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> SharePost(
                                                          //   postData:postList[index],subCategoryData: postList[index].subCategoryId,postUpdate: postUpdate,
                                                          // )));
                                                        },
                                                        child: Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                  child:
                                                                      Image.asset(
                                                                "assets/images/share.png",
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    20,
                                                              )),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  '${postList[index].share!.length}',
                                                                  maxLines: 1,
                                                                  style: TextStyle(
                                                                    color: Color(
                                                                        0XFF9D9D9D),
                                                                    fontSize: 12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontFamily:
                                                                        "Roboto",
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        child: PopupMenuButton(
                                                          child: Icon(
                                                              Icons.more_horiz),
                                                          onSelected:
                                                              (value) async {
                                                            if (value == "Delete") {
                                                              showLoadingSpinner(
                                                                  context,
                                                                  "Please wait...");
                                                              final response =
                                                                  await API.deletePost(
                                                                      "${postList[index].id}");
                                                              hideLoadingSpinner(
                                                                  context);

                                                              if (response[
                                                                      "STATUSCODE"] ==
                                                                  200) {
                                                                setState(() {
                                                                  process = true;
                                                                  fetchAllPostData(
                                                                      id);
                                                                });
                                                              }
                                                              ScaffoldMessenger.of(
                                                                      context)
                                                                  .showSnackBar((SnackBar(
                                                                      content: Text(
                                                                          response[
                                                                              "message"]))));
                                                            } else if (value ==
                                                                "Report") {
                                                              showLoadingSpinner(
                                                                  context,
                                                                  "Please wait...");
                                                              final response =
                                                                  await API.addReport(
                                                                      "${postList[index].id}");
                                                              hideLoadingSpinner(
                                                                  context);

                                                              if (response[
                                                                      "STATUSCODE"] ==
                                                                  200) {
                                                                setState(() {
                                                                  process = true;
                                                                  fetchAllPostData(
                                                                      id);
                                                                });
                                                              }
                                                              ScaffoldMessenger.of(
                                                                      context)
                                                                  .showSnackBar((SnackBar(
                                                                      content: Text(
                                                                          response[
                                                                              "message"]))));
                                                            }
                                                          },
                                                          itemBuilder: (BuildContext
                                                              context) {
                                                            List<String> options;
                                                            userDetails!.email ==
                                                                    postList[index]
                                                                        .createdBy!
                                                                        .email
                                                                ? options = [
                                                                    'Delete',
                                                                    'Report'
                                                                  ]
                                                                : options = [
                                                                    'Report'
                                                                  ];

                                                            return options.map(
                                                                (String choice) {
                                                              return PopupMenuItem(
                                                                value: choice,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      child: Icon(
                                                                        choice ==
                                                                                "Delete"
                                                                            ? Icons
                                                                                .delete_outline
                                                                            : Icons
                                                                                .report_gmailerrorred_outlined,
                                                                        color: Color(
                                                                            0XFFFE99AC),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Container(
                                                                        child: Text(
                                                                            choice,
                                                                            style: TextStyle(
                                                                                fontFamily:
                                                                                    "Roboto"))),
                                                                  ],
                                                                ),
                                                              );
                                                            }).toList();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                thickness: 1,
                                              ),
                                              Container(
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    itemCount: postList[index]
                                                                .comments!
                                                                .length >
                                                            0
                                                        ? postList[index]
                                                            .comments!
                                                            .length
                                                        : 0,
                                                    itemBuilder: (context, itx) {
                                                      return Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 9, top: 10),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              child: CircleAvatar(
                                                                radius: 20.5,
                                                                backgroundColor:
                                                                    Color(
                                                                        0XFFFFb0b0b0),
                                                                child: CircleAvatar(
                                                                    radius: 20,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    child: postList[index]
                                                                                .comments![
                                                                                    itx]
                                                                                .commentedBy!
                                                                                .profileImage ==
                                                                            ""
                                                                        ? CircleAvatar(
                                                                            radius:
                                                                                17,
                                                                            backgroundColor:
                                                                                Colors.white,
                                                                            backgroundImage:
                                                                                AssetImage(
                                                                              "assets/images/user_profile.png",
                                                                            ),
                                                                          )
                                                                        : CircleAvatar(
                                                                            radius:
                                                                                17,
                                                                            backgroundColor:
                                                                                Colors
                                                                                    .white,
                                                                            backgroundImage:
                                                                                NetworkImage("${postList[index].comments![itx].commentedBy!.profileImage}"))),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 15,
                                                            ),
                                                            Flexible(
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets.only(
                                                                        top: 8,
                                                                        bottom: 8,
                                                                        left: 15,
                                                                        right: 15),
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey,
                                                                        width: 0.2),
                                                                    color: Colors
                                                                        .grey[200],
                                                                    borderRadius: BorderRadius
                                                                        .all(Radius
                                                                            .circular(
                                                                                20))),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      child: Text(
                                                                        '${postList[index].comments![itx].commentedBy!.userName}',
                                                                        style:
                                                                            TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          height:
                                                                              (17 /
                                                                                  14),
                                                                          fontFamily:
                                                                              "Roboto",
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      child: Text(
                                                                        '${postList[index].comments![itx].comment}',
                                                                        softWrap:
                                                                            true,
                                                                        style:
                                                                            TextStyle(
                                                                          color: Color(
                                                                              0XFFFF808080),
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          height:
                                                                              (17 /
                                                                                  14),
                                                                          fontFamily:
                                                                              "Roboto",
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      );

                                                      /* InkWell(
                                              onTap: (){
                                              },
                                              child:
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 10),
                                                child: Container(
                                                  child: Card(
                                                    elevation: 0,
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                    child: Container(
                                                      padding: EdgeInsets.only(top:8,bottom: 4),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [



                                                          InkWell(
                                                            onTap: (){
                                                            /*  if(postList[index].postType!="share" && postList[index].createdBy!.id != userDetails!.userId)
                                                                Navigator.of(context).push(CupertinoPageRoute(builder: (builder)=>OtherProfile( )));*/
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets.only(left:8,right: 8,),
                                                              child:  Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                                children: [

                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        child: CircleAvatar(
                                                                          radius: 20.5,
                                                                          backgroundColor:Color(0XFFFFb0b0b0),
                                                                          child: CircleAvatar(
                                                                              radius: 20,
                                                                              backgroundColor: Colors.white,
                                                                              child:(postList[index].comments![itx].commentedBy!.profileImage ==null || postList[index].comments![itx].commentedBy!.profileImage ==''
                                                                                  ?CircleAvatar(
                                                                                radius: 17,
                                                                                backgroundColor: Colors.white,
                                                                                backgroundImage:AssetImage("assets/images/user_profile.png",),
                                                                              )
                                                                                  :CircleAvatar(
                                                                                  radius: 17,
                                                                                  backgroundColor: Colors.white,
                                                                                  backgroundImage:postList[index].comments![itx].commentedBy!.profileImage !=null
                                                                                      ?NetworkImage("${postList[index].comments![itx].commentedBy!.profileImage}")
                                                                                      :NetworkImage("${postList[index].comments![itx].commentedBy!.profileImage}")
                                                                              )
                                                                          ),
                                                                        ),
                                                                      ),),
                                                                      SizedBox( width: 10, ),

                                                                      Container(
                                                                        child: Text(
                                                                          '${(postList[index].comments![itx].commentedBy!=null) ? postList[index].comments![itx].commentedBy!.userName  :postList[index].comments![itx].commentedBy!.userName}',
                                                                          style: TextStyle(
                                                                            color: Color(0XFF9D9D9D),
                                                                            fontSize: 16,
                                                                            fontWeight: FontWeight.bold,
                                                                            height: (17 / 14),
                                                                            fontFamily: "Roboto",
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),


                                                                  // Spacer(),
                                                                  Visibility(
                                                                    visible: postList[index].sharePost!=null && postList[index].postType=="share" ? false : true,
                                                                    child: Container(
                                                                      // color: Colors.yellow,
                                                                      child: Text("${timeago.format(DateTime.parse("${postList[index].createdAt}").subtract(new Duration(minutes: 1)),
                                                                          locale: 'en_short')}",
                                                                        style: TextStyle(
                                                                          color: Color(0XFF9D9D9D),
                                                                          fontSize: 12,
                                                                          fontWeight: FontWeight.bold,
                                                                          height: (17 / 14),
                                                                          fontFamily: "Roboto",
                                                                        ),),
                                                                    ),
                                                                  )

                                                                ],
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            margin: EdgeInsets.only(top:10,bottom: 10,left: 60,right: 8),
                                                            child: Text(
                                                              '${postList[index].comments![itx].comment}',
                                                              softWrap: true,maxLines: 4,
                                                              style: TextStyle(
                                                                color: Color(0XFFFFb0b0b0),
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.w500,
                                                                height: (17 / 14),
                                                                fontFamily: "Roboto",
                                                              ),
                                                            ),
                                                          ),


                                                          Visibility(
                                                            visible: false,
                                                            child: Container(
                                                              margin: EdgeInsets.only(left: 35,right: 8),
                                                              child: Row(
                                                                children: [

                                                                  Expanded(
                                                                    child: InkWell(
                                                                      onTap:()async{
                                                                        if(postList[index].liked!=null && postList[index].liked==true){

                                                                          final response = await API.removeLikes("${postList[index].id}");

                                                                          if(response["STATUSCODE"] == 200){
                                                                            setState(() {
                                                                              postList[index].liked=false;

                                                                              for(int j=0;j<postList[index].likes!.length;j++){
                                                                                if(postList[index].likedId==postList[index].likes![j].id)
                                                                                  postList[index].likes!.removeAt(j);
                                                                              }

                                                                            });
                                                                          }

                                                                          ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text(response["message"]))));
                                                                        }
                                                                        else{
                                                                          final response = await API.addLikes("${postList[index].id}");

                                                                          if(response["STATUSCODE"] == 200){
                                                                            setState(() {
                                                                              postList[index].liked=true;
                                                                              postList[index].likedId="${response["response_data"]["_id"]}";

                                                                              var profileImage=userDetails!.profileImage!.split("/");
                                                                              var data={
                                                                                "created_At": "${response["response_data"]["created_At"]}",
                                                                                "_id": "${response["response_data"]["_id"]}",
                                                                                "likedBy": {
                                                                                  "userName": "${userDetails!.userName}",
                                                                                  "profileImage": "${profileImage[profileImage.length-1]}",
                                                                                  "_id": "${userDetails!.userId}",
                                                                                  "email": "${userDetails!.email}"
                                                                                }
                                                                              };
                                                                              postList[index].likes!.insert(0,Like.fromJson(data));
                                                                            });
                                                                          }

                                                                          ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text(response["message"]))));

                                                                        }

                                                                      },
                                                                      child:
                                                                      Container(
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [

                                                                            Container(
                                                                              child: Image.asset("assets/images/like.png",width: MediaQuery.of(context).size.width/25,
                                                                                color:postList[index].liked!=null && postList[index].liked==true ? Color(0XFFFE99AC)   : Colors.grey,),
                                                                            ),

                                                                            SizedBox(width: 5,),

                                                                            Container(
                                                                              child:Text('${postList[index].likes!.length}',
                                                                                maxLines:1,style: TextStyle(
                                                                                  color: Color(0XFF9D9D9D),
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontFamily: "Roboto",
                                                                                ),
                                                                              ),
                                                                            )

                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  SizedBox(width: 5,),

                                                                  Expanded(
                                                                    child: InkWell(
                                                                      onTap: (){
                                                                        showModalBottomSheet(
                                                                            shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),),
                                                                            context: context,
                                                                            isDismissible: true,
                                                                            isScrollControlled: true,
                                                                            builder: (BuildContext buildContext) {
                                                                              return Container(
                                                                                  height: MediaQuery.of(context).size.height / 1.12,
                                                                                  child:PostComments(postData:postList[index])

                                                                              );
                                                                            }).whenComplete(() {  });

                                                                      },
                                                                      child: Container(
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [

                                                                            Container(
                                                                                child: Image.asset("assets/images/comment.png",width: MediaQuery.of(context).size.width/25,)
                                                                            ),


                                                                            SizedBox(width: 5,),

                                                                            Container(
                                                                              child:Text('${postList[index].comments!.length}',
                                                                                maxLines:1,style: TextStyle(
                                                                                  color: Color(0XFF9D9D9D),
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontFamily: "Roboto",
                                                                                ),
                                                                              ),
                                                                            )

                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  SizedBox(width: 5,),

                                                                  Expanded(
                                                                    child: InkWell(
                                                                      onTap: (){
                                                                        // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> SharePost(
                                                                        //   postData:postList[index],subCategoryData: postList[index].subCategoryId,postUpdate: postUpdate,
                                                                        // )));
                                                                      },
                                                                      child: Container(
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [

                                                                            Container(
                                                                                child: Image.asset("assets/images/share.png",width: MediaQuery.of(context).size.width/25,)
                                                                            ),

                                                                            SizedBox(width: 5,),

                                                                            Container(
                                                                              child:Text('${postList[index].share!.length}',
                                                                                maxLines:1,style: TextStyle(
                                                                                  color: Color(0XFF9D9D9D),
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontFamily: "Roboto",
                                                                                ),
                                                                              ),
                                                                            )

                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  SizedBox(width: 5,),

                                                                  Expanded(
                                                                    child:  Container(
                                                                      alignment: Alignment.center,
                                                                      child: PopupMenuButton(
                                                                        child: Icon(Icons.more_horiz),
                                                                        onSelected: (value)async{
                                                                          if(value=="Delete"){
                                                                            showLoadingSpinner(context, "Please wait...");
                                                                            final response = await API.deletePost("${postList[index].id}");
                                                                            hideLoadingSpinner(context);

                                                                            if(response["STATUSCODE"] == 200){
                                                                              setState(() {
                                                                                process=true;
                                                                                fetchAllPostData(id);
                                                                              });
                                                                            }
                                                                            ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text(response["message"]))));
                                                                          }
                                                                          else if(value=="Report"){
                                                                            showLoadingSpinner(context, "Please wait...");
                                                                            final response = await API.addReport("${postList[index].id}");
                                                                            hideLoadingSpinner(context);

                                                                            if(response["STATUSCODE"] == 200){
                                                                              setState(() {
                                                                                process=true;
                                                                                fetchAllPostData(id);
                                                                              });
                                                                            }
                                                                            ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text(response["message"]))));
                                                                          }
                                                                        },
                                                                        itemBuilder: (BuildContext context) {
                                                                          List<String> options;
                                                                          userDetails!.email==postList[index].createdBy!.email
                                                                              ? options=['Delete','Report']
                                                                              : options=['Report'];

                                                                          return options.map((String choice) {
                                                                            return PopupMenuItem(
                                                                              value: choice,
                                                                              child:Row(
                                                                                children: [
                                                                                  Container(child:Icon(choice=="Delete"
                                                                                      ?Icons.delete_outline:Icons.report_gmailerrorred_outlined,
                                                                                    color: Color(0XFFFE99AC),),),
                                                                                  SizedBox(width: 5,),
                                                                                  Container(child:Text(choice,style: TextStyle(fontFamily: "Roboto"))),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }).toList();
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),

                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                              margin: EdgeInsets.only(left: 60),
                                                              child: Divider(thickness: 1,)),


                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );*/
                                                    }),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 20),
                          alignment: Alignment.center,
                          child: Text(
                            "No post available",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto",
                            ),
                          ),
                        )),
        ),
      ),
    );
  }

  void fetchAllPostData(String id) async {
    final response = await API.fetchAllPostDetails(id);
    if (response["STATUSCODE"] == 200) {
      var rest = response["response_data"];
      setState(() {
        postList =
            rest['post'].map<Post>((json) => Post.fromJson(json)).toList();
        for (int i = 0; i < postList.length; i++) {
          if (postList[i].likes != null && postList[i].likes!.length > 0) {
            for (int j = 0; j < postList[i].likes!.length; j++) {
              if (userDetails!.userId == postList[i].likes![j].likedBy!.id) {
                postList[i].liked = true;
                postList[i].likedId = "${postList[i].likes![j].id}";
              } else {
                postList[i].liked = false;
                postList[i].likedId = "0";
              }
            }
          }
        }
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

  void postUpdate(Post newPost, int post, int question, int engagement) {
    setState(() {
      postList.insert(0, newPost);
    });
  }
}
