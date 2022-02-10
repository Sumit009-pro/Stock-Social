import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:stock_social/bottombar/dashboard/category/category_details.dart';
import 'package:stock_social/messages.dart';
import 'package:stock_social/models/api.dart';
import 'package:stock_social/bottombar/dashboard/category.dart';
import 'package:stock_social/models/categories_model.dart';
import 'package:stock_social/models/post_model.dart';
import 'package:stock_social/notification.dart';
import 'package:stock_social/menu/menu.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  List<PostModel> trendingPostList = [];

  List<Categories> categoriesData = [];

  bool watchList = false;
  bool process = true;
  bool trendingProcess = true;
  bool hide = false;

  late AnimationController _controller;

  Animation? gradientPosition;

  String _value = "";

  List<dynamic> sortByList = [
    {"value": 1, "name": "Highest  Engagement"},
    {"value": 2, "name": "Highest  Posts"},
    {"value": 3, "name": "Highest  Questions"},
  ];

  @override
  void initState() {
    fetchTopTrendingPost();
    fetchCategoriesData();
    super.initState();

    _controller = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    )..addListener(() {
        if (process || trendingProcess) setState(() {});
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0), // here the desired height
        child: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Image(
            image: AssetImage(
              "assets/images/top_bg.png",
            ),
            fit: BoxFit.fill,
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => Menu()));
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
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => Messages()));
              },
            ),
          ],
        ),
      ),
      body:

      Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: hide ? false : true,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 15),
                child: Text(
                  "Trending",
                  style: TextStyle(
                      color: Color(0XFFFFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Roboto"),
                ),
              ),
            ),
            Visibility(
              visible: hide ? false : true,
              child: Container(
                margin: const EdgeInsets.only(
                    left: 15.0, right: 15, top: 5, bottom: 10),
                height: MediaQuery.of(context).size.height / 5.5,
                child: trendingProcess
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return
                            Container(
                            child: Card(
                                color: Colors.white,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 5.5,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 15, top: 10, right: 15),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
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
                                      Expanded(
                                        child: Container(
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Ionicons.heart_outline,
                                                  color: Colors.grey,
                                                  size: 18,
                                                ),
                                                Icon(
                                                  Ionicons.chatbubble_outline,
                                                  color: Colors.grey,
                                                  size: 18,
                                                ),
                                                Container(
                                                  height: 14,
                                                  width: 14,
                                                  child: SvgPicture.asset(
                                                    'assets/icons/share.svg',
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                14,
                                        padding: EdgeInsets.only(
                                            left: 4,
                                            right: 4,
                                            top: 3,
                                            bottom: 3),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(12),
                                              bottomRight: Radius.circular(12)),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 15, top: 10, right: 15),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  6,
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
                                            SizedBox(height: 2),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 15,
                                                  top: 5,
                                                  bottom: 5,
                                                  right: 15),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
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
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          );
                        },
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: trendingPostList.length > 0
                            ? trendingPostList.length
                            : 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => CategoryDetails(
                                            mainCategoryName: "",
                                            subCategoryData:
                                                trendingPostList[index]
                                                    .subCategoryId,
                                            postId: trendingPostList[index].id,
                                          )));
                            },
                            child: Container(
                              child: Card(
                                  color: Colors.black,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        5.5,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 15, top: 10),
                                          child: Text(
                                            '${trendingPostList[index].subCategoryId!.name}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Roboto"),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  "assets/images/trending_bg.png",
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Ionicons.heart_outline,
                                                        color: Colors.white,
                                                        size: 18,
                                                      ),
                                                      Text(
                                                        ' ${trendingPostList[index].likes.length}',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                "Roboto"),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Ionicons
                                                            .chatbubble_outline,
                                                        color: Colors.white,
                                                        size: 18,
                                                      ),
                                                      Text(
                                                        ' ${trendingPostList[index].comments.length}',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                "Roboto"),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 14,
                                                        width: 14,
                                                        child: SvgPicture.asset(
                                                          'assets/icons/share.svg',
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        ' ${trendingPostList[index].share.length}',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                "Roboto"),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              14,
                                          padding: EdgeInsets.only(
                                              left: 4,
                                              right: 4,
                                              top: 3,
                                              bottom: 3),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(12),
                                                bottomRight:
                                                    Radius.circular(12)),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                '${trendingPostList[index].createdBy!.userName}',
                                                style: TextStyle(
                                                    color: Color(0XFF9D9D9D),
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Roboto"),
                                              ),
                                              SizedBox(height: 2),
                                              Text(
                                                '${trendingPostList[index].content}',
                                                softWrap: true,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    color: Color(0XFF9D9D9D),
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Roboto"),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          );
                        },
                      ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 12),
              color: Colors.white10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 17.5,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              watchList = false;
                              categoriesData.clear();
                              process = true;
                              fetchCategoriesData();
                            });
                          },
                          child:
                          Container(
                              child: Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: CircleAvatar(
                                    radius: 11.0,
                                    backgroundColor: watchList
                                        ? Colors.white
                                        : Color(0XFFFE99AC),
                                    child: CircleAvatar(
                                      radius: 4.8,
                                      backgroundColor: Colors.white,
                                    ),
                                  )),
                              Container(
                                child: Text(
                                  "All Categories",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              watchList = true;
                              categoriesData.clear();
                              process = true;
                              fetchWatchListData();
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(right: 5),
                                      child: CircleAvatar(
                                        radius: 11.0,
                                        backgroundColor: !watchList
                                            ? Colors.white
                                            : Color(0XFFFE99AC),
                                        child: CircleAvatar(
                                          radius: 4.8,
                                          backgroundColor: Colors.white,
                                        ),
                                      )),
                                  Container(
                                    child: Text(
                                      " Watchlist",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
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
                                  child: Icon(
                                    Icons.swap_vert,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                      left: 5,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Text(
                                            "Sort By",
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
                            watchList = false;
                            process = true;

                            if (value == 1)
                              sortBy("engagement");
                            else if (value == 2)
                              sortBy("post");
                            else if (value == 3) sortBy("question ");
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
                  )
                ],
              ),
            ),
            Expanded(
              child: !process
                  ? categoriesData.length > 0
                      ? Container(
                          child: Category(
                              categoriesData: categoriesData,
                              watchListSelected: watchList,
                              scrollScreen: scrollScreen),
                        )
                      :
              Container(
                          alignment: Alignment.center,
                          child: Text(
                            "No data available",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto",
                            ),
                          ),
                        )
                  : Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: 3,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
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
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 3,
                                          physics:
                                              AlwaysScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
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
                                            );
                                          }))
                                ],
                              ),
                            );
                          }),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void fetchCategoriesData() async {
    final response = await API.fetchCategoriesData();
    if (response["STATUSCODE"] == 200) {
      var rest = response["response_data"]["categories"] as List;

      final response2 = await API.fetchUserWatchListedData();

      setState(() {
        categoriesData =
            rest.map<Categories>((json) => Categories.fromJson(json)).toList();

        for (int j = 0; j < categoriesData.length; j++) {
          for (int k = 0; k < categoriesData[j].subCategory.length; k++) {
            categoriesData[j].subCategory[k].watchListed = false;
          } //subcategory
        } //cate

        if (response2["STATUSCODE"] == 200) {
          if (response2["response_data"]["userWatchList"] != null &&
              response2["response_data"]["userWatchList"].length > 0 &&
              response2["response_data"]["userWatchList"][0]["subCategory"]
                      .length >
                  0) {
            for (int i = 0;
                i <
                    response2["response_data"]["userWatchList"][0]
                            ["subCategory"]
                        .length;
                i++) {
              for (int j = 0; j < categoriesData.length; j++) {
                for (int k = 0; k < categoriesData[j].subCategory.length; k++) {
                  if (categoriesData[j].subCategory[k].id ==
                          response2["response_data"]["userWatchList"][0]
                              ["subCategory"][i] &&
                      categoriesData[j].subCategory[k].watchListed == false)
                    categoriesData[j].subCategory[k].watchListed = true;
                } //subcategory
              } //category
            } //for

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

  void fetchWatchListData() async {
    final response = await API.fetchWatchListData();
    if (response["STATUSCODE"] == 200) {
      var rest = response["response_data"]["watchList"] as List;
      setState(() {
        categoriesData =
            rest.map<Categories>((json) => Categories.fromJson(json)).toList();
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

  void scrollScreen(bool data) {
    setState(() {
      if (trendingPostList.length == 0)
        hide = true;
      else
        hide = data;
    });
  }

  void fetchTopTrendingPost() async {
    final response = await API.fetchTopTrendingPost();

    if (response["STATUSCODE"] == 200) {
      var rest = response["response_data"]["post"] as List;
      setState(() {
        trendingPostList =
            rest.map<PostModel>((json) => PostModel.fromJson(json)).toList();

        if (trendingPostList.length == 0) hide = true;

        trendingProcess = false;
      });
    } else {
      setState(() {
        trendingProcess = false;
        trendingPostList = [];
        hide = true;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar((SnackBar(content: Text(response["message"]))));
    }
  } //func

  void sortBy(String value) async {
    final response = await API.fetchCategoriesSortBy(value);
    if (response["STATUSCODE"] == 200) {
      var rest = response["response_data"]["categories"] as List;

      final response2 = await API.fetchUserWatchListedData();

      setState(() {
        categoriesData.clear();

        categoriesData =
            rest.map<Categories>((json) => Categories.fromJson(json)).toList();

        for (int j = 0; j < categoriesData.length; j++) {
          for (int k = 0; k < categoriesData[j].subCategory.length; k++) {
            categoriesData[j].subCategory[k].watchListed = false;
          } //subcategory
        } //cate

        if (response2["STATUSCODE"] == 200) {
          if (response2["response_data"]["userWatchList"] != null &&
              response2["response_data"]["userWatchList"].length > 0 &&
              response2["response_data"]["userWatchList"][0]["subCategory"]
                      .length >
                  0) {
            for (int i = 0;
                i <
                    response2["response_data"]["userWatchList"][0]
                            ["subCategory"]
                        .length;
                i++) {
              for (int j = 0; j < categoriesData.length; j++) {
                for (int k = 0; k < categoriesData[j].subCategory.length; k++) {
                  if (categoriesData[j].subCategory[k].id ==
                          response2["response_data"]["userWatchList"][0]
                              ["subCategory"][i] &&
                      categoriesData[j].subCategory[k].watchListed == false)
                    categoriesData[j].subCategory[k].watchListed = true;
                } //subcategory
              } //category
            } //for

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
  }
}
