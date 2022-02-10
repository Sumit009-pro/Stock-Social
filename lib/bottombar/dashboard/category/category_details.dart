import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:stock_social/bottombar/dashboard/category/share_post.dart';
import 'package:stock_social/bottombar/profile/other_profile.dart';
import 'package:stock_social/bottombar/dashboard/category/comments.dart';
import 'package:stock_social/bottombar/dashboard/category/create_post.dart';
import 'package:stock_social/bottombar/profile/post_details.dart';
import 'package:stock_social/models/api.dart';
import 'package:stock_social/models/categories_model.dart';
import 'package:stock_social/models/post_model.dart';
import 'package:stock_social/models/user_model.dart';
import 'package:stock_social/widgets/loading_spinner.dart';
import 'package:stock_social/widgets/my_progress_indicator.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../messages.dart';

class CategoryDetails extends StatefulWidget {
  final String? mainCategoryName;
  final SubCategory? subCategoryData;

  final String? postId;

  const CategoryDetails(
      {Key? key,
      this.mainCategoryName,
      required this.subCategoryData,
      this.postId})
      : super(key: key);

  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails>
    with SingleTickerProviderStateMixin, TickerProviderStateMixin {
  bool process = true;

  List<PostModel> postList = [];

  late AnimationController _controller;

  Animation? gradientPosition;

  UserModel? userDetails;
  int totalPost = 0;
  int totalQuestion = 0;
  int engagementCount = 0;

  late TabController _tabController;

  ScrollController? scrollController;

  @override
  void initState() {
    // TODO: implement initState
    print('Category details');
    print(widget.subCategoryData!.watchListed.toString());
    fetchAllPostData("");
    super.initState();

    userDetails = UserModel.getInstance();

    _tabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    );

    scrollController = new ScrollController();

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
                Navigator.of(context).pop();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        centerTitle: true,
        title: Text(
          "${widget.mainCategoryName}",
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
              onPressed: () {
                Navigator.of(context).push(
                    CupertinoPageRoute(
                        builder: (builder) =>
                            Messages()));
              }),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4,
              color: Colors.white,
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 4.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/vg-bg.png'),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                  ),
                  Positioned(
                      left: 40,
                      bottom: 0,
                      child: Container(
                        child: CircleAvatar(
                          radius: 38.5,
                          backgroundColor: Color(0XFFFFb0b0b0),
                          child: CircleAvatar(
                              radius: 38,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                      "${widget.subCategoryData!.image}"))),
                        ),
                      )),
                ],
              ),
            ),
            Expanded(
                child: Container(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 14.0,
                      right: 14,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 18,
                                  color: Color(0XFFFE99AC),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Flexible(
                                  child: Container(
                                    child: Text(
                                      '${widget.subCategoryData!.name}',
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
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        widget.subCategoryData!.watchListed == true
                            ? InkWell(
                                onTap: () async {
                                  showLoadingSpinner(context, "");
                                  final response =
                                      await API.removeFromWatchList({
                                    "categoryId": widget.subCategoryData!.id,
                                  });
                                  hideLoadingSpinner(context);
                                  if (response["STATUSCODE"] == 200) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        (SnackBar(
                                            content:
                                                Text(response["message"]))));
                                    setState(() {
                                      widget.subCategoryData!.watchListed = false;
                                      // if (widget.subCategoryData!.watchListed)
                                      //   widget.categoriesData.removeAt(index);
                                    });
                                  } else
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        (SnackBar(
                                            content:
                                                Text(response["message"]))));
                                },
                                child: Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                        top: 5, bottom: 5, left: 15, right: 15),
                                    decoration: BoxDecoration(
                                        color: Color(0XFFFE99AC),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Container(
                                      child: Text(
                                        "Remove",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Roboto"),
                                      ),
                                    )),
                              )
                            :
                        InkWell(
                                onTap: () async {
                                  showLoadingSpinner(context, "Please wait...");
                                  final response = await API.addToWatchList({
                                    "categoryId": widget.subCategoryData!.id,
                                  });
                                  hideLoadingSpinner(context);
                                  if (response["STATUSCODE"] == 200) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        (SnackBar(
                                            content:
                                                Text(response["message"]))));
                                    setState(() {
                                      widget.subCategoryData!.watchListed = true;
                                    });
                                  } else
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        (SnackBar(
                                            content:
                                                Text(response["message"]))));
                                },
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 15, right: 15),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 0.2),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "  Add to watchlist",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Roboto"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                        Visibility(
                          visible: false,
                          // visible: widget.subCategoryData!.watchListed==false ? true  : false,
                          child: InkWell(
                            onTap: () async {
                              if (widget.subCategoryData!.watchListed ==
                                  false) {
                                showLoadingSpinner(context, "Please wait...");
                                final response = await API.addToWatchList({
                                  "categoryId": widget.subCategoryData!.id,
                                });
                                hideLoadingSpinner(context);
                                if (response["STATUSCODE"] == 200)
                                  setState(() {
                                    widget.subCategoryData!.watchListed = true;
                                  });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    (SnackBar(
                                        content: Text(response["message"]))));
                              } else if (widget.subCategoryData!.watchListed ==
                                  true) {
                                print('remove');
                              }
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                  top: 5, bottom: 5, left: 15, right: 15),
                              decoration: BoxDecoration(
                                  color: Color(0XFFFE99AC),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(.3),
                                      blurRadius: 2.0, // soften the shadow
                                      offset: Offset(
                                        0.0,
                                        // Move to right 10  horizontally
                                        1.0, // Move to bottom 10 Vertically
                                      ),
                                    ),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  widget.subCategoryData!.watchListed == false
                                      ? Container(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        )
                                      : Container(),
                                  Container(
                                    child: Text(
                                      widget.subCategoryData!.watchListed ==
                                              false
                                          ? " Add to Watchlist"
                                          : "Remove",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Roboto"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 14.0,
                      right: 14,
                    ),
                    child: Text(
                      ' About',
                      style: TextStyle(
                        color: Color(0XFF9D9D9D),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5, left: 15, right: 14),
                    child: ReadMoreText(
                      '${widget.subCategoryData!.description}',
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
                      moreStyle:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      lessStyle:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 14.0,
                      right: 14,
                    ),
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "assets/icons/engagement.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              33,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 2, right: 2),
                                        child: Text(
                                          "Engagement",
                                          style: TextStyle(
                                              color: Color(0XFF9D9D9D),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Roboto"),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${NumberFormat.compactCurrency(
                                            decimalDigits: engagementCount
                                                        .toString()
                                                        .length <
                                                    3
                                                ? 0
                                                : 1,
                                            symbol: '',
                                          ).format(engagementCount)}",
                                          style: TextStyle(
                                              color: Color(0XFF9D9D9D),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Roboto"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: MyProgressIndicator(
                                    progressColor: Colors.blue,
                                    backgroundColor: Color(0XFFFFb0b0b0),
                                    value: 2,
                                    activity: 1,
                                    height: 4,
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "assets/icons/post.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              33,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 2, right: 2),
                                        child: Text(
                                          "Total Post",
                                          style: TextStyle(
                                              color: Color(0XFF9D9D9D),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Roboto"),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${NumberFormat.compactCurrency(
                                            decimalDigits:
                                                totalPost.toString().length < 3
                                                    ? 0
                                                    : 1,
                                            symbol: '',
                                          ).format(totalPost)}",
                                          style: TextStyle(
                                              color: Color(0XFF9D9D9D),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Roboto"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: MyProgressIndicator(
                                    progressColor: Colors.green,
                                    backgroundColor: Color(0XFFFFb0b0b0),
                                    value: widget.subCategoryData!.postCount,
                                    activity: 2,
                                    height: 4,
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "assets/icons/questions.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              33,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 2, right: 2),
                                        child: Text(
                                          "Questions",
                                          style: TextStyle(
                                              color: Color(0XFF9D9D9D),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Roboto"),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${NumberFormat.compactCurrency(
                                            decimalDigits: totalQuestion
                                                        .toString()
                                                        .length <
                                                    3
                                                ? 0
                                                : 1,
                                            symbol: '',
                                          ).format(totalQuestion)}",
                                          style: TextStyle(
                                              color: Color(0XFF9D9D9D),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Roboto"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: MyProgressIndicator(
                                    progressColor: Colors.orange,
                                    backgroundColor: Color(0XFFFFb0b0b0),
                                    value: 200,
                                    activity: 3,
                                    height: 4,
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Divider()),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 14.0,
                      right: 14,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (builder) => CreatePost(
                                    subCategoryData: widget.subCategoryData,
                                    postUpdate: postUpdate)));
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 16,
                              decoration: BoxDecoration(
                                color: Color(0XFFFE99AC),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              padding: EdgeInsets.only(
                                  top: 5, bottom: 5, left: 5, right: 5),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      " Create Post",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Expanded(
                          child: Container(
                            child: DefaultTabController(
                              length: 3,
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: 5,
                                ),
                                //  width: MediaQuery.of(context).size.width/1.8,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0XFFFFb0b0b0), width: 0.2),
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0XFFffe6ea),
                                ),
                                height: MediaQuery.of(context).size.height / 16,
                                child: TabBar(
                                  controller: _tabController,
                                  onTap: (value) {
                                    setState(() {
                                      if (value == 0) {
                                        process = true;
                                        fetchAllPostData("");
                                      } else if (value == 1) {
                                        process = true;
                                        fetchAllPostData("top");
                                      } else if (value == 2) {
                                        process = true;
                                        fetchAllPostData("question");
                                      }
                                    });
                                  },
                                  unselectedLabelColor: Color(0XFF9D9D9D),
                                  indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0XFFFE99AC)),
                                  unselectedLabelStyle: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    height: (17 / 14),
                                    fontFamily: "Roboto",
                                  ),
                                  labelPadding: EdgeInsets.zero,
                                  labelStyle: TextStyle(
                                    color: Color(0XFFFFFFFF),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Roboto",
                                  ),
                                  tabs: [
                                    Tab(
                                      text: "Latest",
                                    ),
                                    Tab(
                                      text: "Top",
                                    ),
                                    Tab(
                                      text: "Questions",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Container(
                        padding: EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        child: process
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
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  margin: EdgeInsets.only(
                                                      bottom: 10),
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                    begin: Alignment(
                                                        gradientPosition!.value,
                                                        0),
                                                    end: Alignment(-1, 0),
                                                    colors: [
                                                      Color.fromRGBO(
                                                          0, 0, 0, 0.1),
                                                      Color(0x44CCCCCC),
                                                      Color.fromRGBO(
                                                          0, 0, 0, 0.1)
                                                    ],
                                                  )),
                                                ),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            8,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8)),
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment(
                                                              gradientPosition!
                                                                  .value,
                                                              0),
                                                          end: Alignment(-1, 0),
                                                          colors: [
                                                            Color.fromRGBO(
                                                                0, 0, 0, 0.1),
                                                            Color(0x44CCCCCC),
                                                            Color.fromRGBO(
                                                                0, 0, 0, 0.1)
                                                          ],
                                                        ))),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              15,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              15,
                                                          decoration:
                                                              BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  gradient:
                                                                      LinearGradient(
                                                                    begin: Alignment(
                                                                        gradientPosition!
                                                                            .value,
                                                                        0),
                                                                    end:
                                                                        Alignment(
                                                                            -1,
                                                                            0),
                                                                    colors: [
                                                                      Color.fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.1),
                                                                      Color(
                                                                          0x44CCCCCC),
                                                                      Color.fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.1)
                                                                    ],
                                                                  ))),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            5,
                                                        margin: EdgeInsets.only(
                                                            left: 10),
                                                        height: 10,
                                                        decoration:
                                                            BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                          begin: Alignment(
                                                              gradientPosition!
                                                                  .value,
                                                              0),
                                                          end: Alignment(-1, 0),
                                                          colors: [
                                                            Color.fromRGBO(
                                                                0, 0, 0, 0.1),
                                                            Color(0x44CCCCCC),
                                                            Color.fromRGBO(
                                                                0, 0, 0, 0.1)
                                                          ],
                                                        )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 5,
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                    begin: Alignment(
                                                        gradientPosition!.value,
                                                        0),
                                                    end: Alignment(-1, 0),
                                                    colors: [
                                                      Color.fromRGBO(
                                                          0, 0, 0, 0.1),
                                                      Color(0x44CCCCCC),
                                                      Color.fromRGBO(
                                                          0, 0, 0, 0.1)
                                                    ],
                                                  )),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  margin:
                                                      EdgeInsets.only(top: 5),
                                                  height: 5,
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                    begin: Alignment(
                                                        gradientPosition!.value,
                                                        0),
                                                    end: Alignment(-1, 0),
                                                    colors: [
                                                      Color.fromRGBO(
                                                          0, 0, 0, 0.1),
                                                      Color(0x44CCCCCC),
                                                      Color.fromRGBO(
                                                          0, 0, 0, 0.1)
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
                            : postList.length > 0
                                ?
                        Container(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        controller: scrollController,
                                        physics: ClampingScrollPhysics(),
                                        itemCount: postList.length > 0
                                            ? postList.length
                                            : 0,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  CupertinoPageRoute(
                                                      builder: (builder) =>
                                                          PostDetails(
                                                            id:
                                                            postList[index].id??'',

                                                          )));
                                            },
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Container(
                                                child: Card(
                                                  elevation: 8,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 8, bottom: 8),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Visibility(
                                                          visible: postList[index]
                                                                          .sharePost !=
                                                                      null &&
                                                                  postList[index]
                                                                          .postType ==
                                                                      "share"
                                                              ? true
                                                              : false,
                                                          child: InkWell(
                                                            onTap: () {
                                                              if (postList[index]
                                                                          .postType ==
                                                                      "share" &&
                                                                  postList[index]
                                                                          .createdBy!
                                                                          .sId !=
                                                                      userDetails!
                                                                          .userId)
                                                                Navigator.of(
                                                                        context)
                                                                    .push(CupertinoPageRoute(
                                                                        builder: (builder) => OtherProfile(
                                                                              name: postList[index].createdBy!.userName,
                                                                              userId: postList[index].createdBy!.sId,
                                                                              image: postList[index].createdBy!.profileImage,
                                                                            )));
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: 8,
                                                                right: 8,
                                                                top: 7,
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    child:
                                                                        CircleAvatar(
                                                                      radius:
                                                                          20.5,
                                                                      backgroundColor:
                                                                          Color(
                                                                              0XFFFFb0b0b0),
                                                                      child: CircleAvatar(
                                                                          radius: 20,
                                                                          backgroundColor: Colors.white,
                                                                          child: postList[index].createdBy != null && postList[index].createdBy!.profileImage == ""
                                                                              ? CircleAvatar(
                                                                                  radius: 17,
                                                                                  backgroundColor: Colors.white,
                                                                                  backgroundImage: AssetImage(
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
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Text(
                                                                        '${postList[index].createdBy!.userName}',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0XFF9D9D9D),
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          height:
                                                                              (17 / 14),
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
                                                        Visibility(
                                                          visible: postList[index]
                                                                          .sharePost !=
                                                                      null &&
                                                                  postList[index]
                                                                          .postType ==
                                                                      "share"
                                                              ? true
                                                              : false,
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 10,
                                                                    bottom: 10,
                                                                    left: 10,
                                                                    right: 8),
                                                            child: Text(
                                                              '${postList[index].content}',
                                                              softWrap: true,
                                                              maxLines: 4,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0XFFFFb0b0b0),
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height:
                                                                    (17 / 14),
                                                                fontFamily:
                                                                    "Roboto",
                                                              ),
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
                                                                ? true
                                                                : false,
                                                            child: Divider(
                                                              thickness: 1,
                                                            )),
                                                        Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 8,
                                                                    right: 8),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Container(
                                                                      child: Text(
                                                                        '${postList[index].subCategoryId!.name}',
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
                                                                    if(postList[index].contentType=='question')Icon(
                                                                      Icons.quiz_rounded,
                                                                      size: 18,
                                                                      color: Color(0XFFFE99AC),
                                                                    ),
                                                                  ],
                                                                ),

                                                                Container(
                                                                  child: Text(
                                                                    "${timeago.format(DateTime.parse("${postList[index].createdAt}").subtract(new Duration(minutes: 1)), locale: 'en_short')}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0XFF9D9D9D),
                                                                      fontSize:
                                                                          12,
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
                                                            )),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8,
                                                                  right: 8),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 3),
                                                          child: Text(
                                                            '${postList[index].subCategoryId!.hashtag}',
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
                                                        ),
                                                        Visibility(
                                                          visible: postList[index]
                                                                          .image !=
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
                                                          child:
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.of(context).push(
                                                                  CupertinoPageRoute(
                                                                      builder: (builder) =>
                                                                          PostDetails(
                                                                            id:
                                                                            postList[index].id??'',
                                                                          /*  userId:
                                                                            postList[index].createdBy?.sId??'',
                                                                            image:
                                                                            postList[index].createdBy?.profileImage??'',*/
                                                                          )));
                                                            },
                                                            child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top: 5,
                                                                        left: 8,
                                                                        right: 8),
                                                                width:
                                                                    MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    6,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(
                                                                                8)),
                                                                        border: Border.all(
                                                                            color:
                                                                                Color(0XFFFFb0b0b0),
                                                                            width: 0.2),
                                                                        image: DecorationImage(
                                                                          image: postList[index].postType == "share" &&
                                                                                  postList[index].sharePost != null
                                                                              ? NetworkImage("${postList[index].sharePost!.image}")
                                                                              : NetworkImage("${postList[index].image}"),
                                                                          fit: BoxFit
                                                                              .fitWidth,
                                                                        ))),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            if (postList[index]
                                                                        .postType !=
                                                                    "share" &&
                                                                postList[index]
                                                                        .createdBy!
                                                                        .sId !=
                                                                    userDetails!
                                                                        .userId)
                                                              Navigator.of(context).push(
                                                                  CupertinoPageRoute(
                                                                      builder: (builder) =>
                                                                          OtherProfile(
                                                                            name:
                                                                                postList[index].createdBy?.userName??'',
                                                                            userId:
                                                                                postList[index].createdBy?.sId??'',
                                                                            image:
                                                                                postList[index].createdBy?.profileImage??'',
                                                                          )));
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: 8,
                                                              right: 8,
                                                              top: 7,
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  child:
                                                                      CircleAvatar(
                                                                    radius:
                                                                        20.5,
                                                                    backgroundColor:
                                                                        Color(
                                                                            0XFFFFb0b0b0),
                                                                    child: CircleAvatar(
                                                                        radius: 20,
                                                                        backgroundColor: Colors.white,
                                                                        child: (postList[index].postType == "share" && postList[index].sharePost != null && postList[index].sharePost!.createdBy!.profileImage == "") || postList[index].createdBy!.profileImage == ""
                                                                            ? CircleAvatar(
                                                                                radius: 17,
                                                                                backgroundColor: Colors.white,
                                                                                backgroundImage: AssetImage(
                                                                                  "assets/images/user_profile.png",
                                                                                ),
                                                                              )
                                                                            : CircleAvatar(radius: 17, backgroundColor: Colors.white, backgroundImage: postList[index].postType == "share" && postList[index].sharePost != null ? NetworkImage("${postList[index].sharePost!.createdBy!.profileImage}") : NetworkImage("${postList[index].createdBy!.profileImage}"))),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Flexible(
                                                                  child:
                                                                      Container(
                                                                    child: Text(
                                                                      '${(postList[index].postType == "share" && postList[index].sharePost != null) ? postList[index].sharePost!.createdBy!.userName : postList[index].createdBy!.userName}',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0XFF9D9D9D),
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        height: (17 /
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
                                                        InkWell(
                                                          onTap: () => Navigator.of(context).push(
                                                              CupertinoPageRoute(
                                                                  builder: (builder) =>
                                                                      PostDetails(
                                                                        id:
                                                                        postList[index].id??'',
                                                                        /*  userId:
                                                                            postList[index].createdBy?.sId??'',
                                                                            image:
                                                                            postList[index].createdBy?.profileImage??'',*/
                                                                      ))),
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 10,
                                                                    bottom: 10,
                                                                    left: 10,
                                                                    right: 8),
                                                            child: Text(
                                                              '${(postList[index].postType == "share" && postList[index].sharePost != null) ? postList[index].sharePost!.content : postList[index].content}',
                                                              softWrap: true,
                                                              maxLines: 4,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0XFFFFb0b0b0),
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height: (17 / 14),
                                                                fontFamily:
                                                                    "Roboto",
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Divider(
                                                          thickness: 1,
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 8,
                                                                  right: 8),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    if (postList[index].liked !=
                                                                            null &&
                                                                        postList[index].liked ==
                                                                            true) {
                                                                      final response =
                                                                          await API
                                                                              .removeLikes("${postList[index].id}");

                                                                      if (response[
                                                                              "STATUSCODE"] ==
                                                                          200) {
                                                                        setState(
                                                                            () {
                                                                          postList[index].liked =
                                                                              false;

                                                                          for (int j = 0;
                                                                              j < postList[index].likes.length;
                                                                              j++) {
                                                                            if (postList[index].likedId ==
                                                                                postList[index].likes[j].id)
                                                                              postList[index].likes.removeAt(j);
                                                                          }
                                                                        });

                                                                        engagementCount=engagementCount-1;
                                                                      }

                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              (SnackBar(content: Text(response["message"]))));
                                                                    } else {
                                                                      final response =
                                                                          await API
                                                                              .addLikes("${postList[index].id}");

                                                                      fetchAllPostData("");

                                                                      if (response[
                                                                              "STATUSCODE"] ==
                                                                          200) {
                                                                        setState(
                                                                            () {
                                                                          postList[index].liked =
                                                                              true;
                                                                          postList[index].likedId =
                                                                              "${response["response_data"]["_id"]}";

                                                                          var profileImage = userDetails!
                                                                              .profileImage!
                                                                              .split("/");
                                                                          var data =
                                                                              {
                                                                            "created_At":
                                                                                "${response["response_data"]["created_At"]}",
                                                                            "_id":
                                                                                "${response["response_data"]["_id"]}",
                                                                            "likedBy":
                                                                                {
                                                                              "userName": "${userDetails!.userName}",
                                                                              "profileImage": "${profileImage[profileImage.length - 1]}",
                                                                              "_id": "${userDetails!.userId}",
                                                                              "email": "${userDetails!.email}"
                                                                            }
                                                                          };
                                                                          postList[index].likes.insert(
                                                                              0,
                                                                              LikesModel.fromJson(data));
                                                                        });
                                                                        engagementCount=engagementCount+1;

                                                                      }

                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              (SnackBar(content: Text(response["message"]))));
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          child:
                                                                              Image.asset(
                                                                            "assets/images/like.png",
                                                                            width:
                                                                                MediaQuery.of(context).size.width / 20,
                                                                            color: postList[index].liked != null && postList[index].liked == true
                                                                                ? Color(0XFFFE99AC)
                                                                                : Colors.grey,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Container(
                                                                          child:
                                                                              Text(
                                                                            '${postList[index].likes.length}',
                                                                            maxLines:
                                                                                1,
                                                                            style:
                                                                                TextStyle(
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
                                                                              BorderRadius.vertical(top: Radius.circular(25.0)),
                                                                        ),
                                                                        context:
                                                                            context,
                                                                        isDismissible:
                                                                            true,
                                                                        isScrollControlled:
                                                                            true,
                                                                        builder:
                                                                            (BuildContext
                                                                                buildContext) {
                                                                          return Container(
                                                                              height: MediaQuery.of(context).size.height / 1.12,
                                                                              child: Comments(postData: postList[index]));
                                                                        }).whenComplete(() {
                                                                      setState(
                                                                          () {});
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                            child:
                                                                                Image.asset(
                                                                          "assets/images/comment.png",
                                                                          width:
                                                                              MediaQuery.of(context).size.width / 20,
                                                                        )),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Container(
                                                                          child:
                                                                              Text(
                                                                            '${postList[index].comments.length}',
                                                                            maxLines:
                                                                                1,
                                                                            style:
                                                                                TextStyle(
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
                                                              SizedBox(
                                                                width: 5,
                                                              ),

                                                              Expanded(
                                                          child: InkWell(
                                                            onTap: (){
                                                              Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>SharePost(
                                                                postData:postList[index],subCategoryData: widget.subCategoryData,postUpdate: postUpdate,
                                                              )));
                                                            },
                                                            child: Container(
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [

                                                                  Container(
                                                                      child: Image.asset("assets/images/share.png",width: MediaQuery.of(context).size.width/20,)
                                                                  ),

                                                                  SizedBox(width: 5,),

                                                                  Container(
                                                                    child:Text('${postList[index].share.length}',
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
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      PopupMenuButton(
                                                                    child: Icon(
                                                                      Icons
                                                                          .more_horiz,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    onSelected:
                                                                        (value) async {
                                                                      if (value ==
                                                                          "Delete") {
                                                                        showLoadingSpinner(
                                                                            context,
                                                                            "Please wait...");
                                                                        final response =
                                                                            await API.deletePost("${postList[index].id}");
                                                                        hideLoadingSpinner(
                                                                            context);

                                                                        if (response["STATUSCODE"] ==
                                                                            200) {
                                                                          setState(
                                                                              () {
                                                                            process =
                                                                                true;
                                                                            _tabController.index =
                                                                                0;
                                                                            fetchAllPostData("");
                                                                          });
                                                                        }
                                                                        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
                                                                            content:
                                                                                Text(response["message"]))));
                                                                      } else if (value ==
                                                                          "Report") {
                                                                        showLoadingSpinner(
                                                                            context,
                                                                            "Please wait...");
                                                                        final response =
                                                                            await API.addReport("${postList[index].id}");
                                                                        hideLoadingSpinner(
                                                                            context);

                                                                        if (response["STATUSCODE"] ==
                                                                            200) {
                                                                          setState(
                                                                              () {
                                                                            process =
                                                                                true;
                                                                            _tabController.index =
                                                                                0;
                                                                            fetchAllPostData("");
                                                                          });
                                                                        }
                                                                        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
                                                                            content:
                                                                                Text(response["message"]))));
                                                                      }
                                                                    },
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                            context) {
                                                                      List<String>
                                                                          options;
                                                                      userDetails!.email == postList[index].createdBy!.email
                                                                          ? options =
                                                                              [
                                                                              'Delete',
                                                                              'Report'
                                                                            ]
                                                                          : options =
                                                                              [
                                                                              'Report'
                                                                            ];

                                                                      return options.map(
                                                                          (String
                                                                              choice) {
                                                                        return PopupMenuItem(
                                                                          value:
                                                                              choice,
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Container(
                                                                                child: Icon(
                                                                                  choice == "Delete" ? Icons.delete_outline : Icons.report_gmailerrorred_outlined,
                                                                                  color: Color(0XFFFE99AC),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Container(child: Text(choice, style: TextStyle(fontFamily: "Roboto"))),
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
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  void fetchAllPostData(String type) async {
    var response;

    if (type == "top")
      response =
          await API.fetchAllTopTrendingPost("${widget.subCategoryData!.id}");
    else
      response = await API.fetchAllPostDataByCategoryId(
          "${widget.subCategoryData!.id}", type);

    if (response["STATUSCODE"] == 200) {
      var rest = response["response_data"]["post"] as List;
      setState(() {
        totalPost = response["response_data"]["utils"]["totalPost"];
        totalQuestion = response["response_data"]["utils"]["totalQuestion"];
        engagementCount = response["response_data"]["utils"]["engagementCount"];

        postList =
            rest.map<PostModel>((json) => PostModel.fromJson(json)).toList();

        for (int i = 0; i < postList.length; i++) {
          if (postList[i].likes != null && postList[i].likes.length > 0) {
            for (int j = 0; j < postList[i].likes.length; j++) {
              if (userDetails!.userId == postList[i].likes[j].likedBy!.sId) {
                postList[i].liked = true;
                postList[i].likedId = "${postList[i].likes[j].id}";
              } else {
                postList[i].liked = false;
                postList[i].likedId = "0";
              }
            }
          }
        }

        if (widget.postId != null) {
          for (int i = 0; i < postList.length; i++) {
            if (postList[i].id == widget.postId) {
              postList.insert(0, postList[i]);
              postList.removeAt(i + 1);
            }
          }
        } //if

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

  void postUpdate(PostModel newPost, int post, int question, int engagement) {
    setState(() {
      postList.insert(0, newPost);
      _tabController.index = 0;
      totalPost = post;
      totalQuestion = question;
      engagementCount = engagement;
    });
  }
}
