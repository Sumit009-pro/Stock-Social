import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_social/bottombar/profile/other_profile.dart';
import 'package:stock_social/bottombar/profile/post_comments.dart';
import 'package:stock_social/bottombar/profile/post_details.dart';
import 'package:stock_social/messages.dart';
import 'package:stock_social/models/api.dart';
import 'package:stock_social/models/search_model.dart';
import 'package:stock_social/models/post_fetch_model.dart';
import 'package:stock_social/models/user_model.dart';
import 'package:stock_social/notification.dart';
import 'package:stock_social/search/search_user_item.dart';
import 'package:stock_social/widgets/loading_spinner.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'dashboard/category/comments.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // String? query;
  var type = 0;
  TextEditingController query = new TextEditingController();
  List<ResponseDatum> searchList = [];
  List<Post> postList = [];
  UserModel? userDetails;
  bool process=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userDetails = UserModel.getInstance();
  }

  Future<List<ResponseDatum>> searchUser() async {
    final response = await API.search('user', '${query.text}');
    print(response.toString());
    if (response["STATUSCODE"] == 200) {
      print("code : 200");
      var rest = response["response_data"] as List;
      setState(() {
        searchList = rest
            .map<ResponseDatum>((json) => ResponseDatum.fromJson(json))
            .toList();
        // process = false;
      });
    } else {
      // setState(() {
      //   process = false;
      // });
      // ScaffoldMessenger.of(context)
      //     .showSnackBar((SnackBar(content: Text(response["message"]))));
    }

    return searchList;
  } //func

  Future<List<Post>> searchPost() async {
    final response = await API.search('post', '${query.text}');
    print(response.toString());
    if (response["STATUSCODE"] == 200) {
      print("code : 200");
      var rest = response["response_data"]['post'] as List;
      setState(() {
        postList = rest.map<Post>((json) => Post.fromJson(json)).toList();
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
        process = false;
      });
    } else {
      setState(() {
        process = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar((SnackBar(content: Text(response["message"]))));
    }

    return postList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // here the desired height
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
                  //  Navigator.push(context,CupertinoPageRoute(builder: (context) => Menu()));
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          centerTitle: true,
          title: Container(
            height: MediaQuery.of(context).size.height / 20,
            child: TextFormField(
              controller: query,
              onChanged: (value) {
                print(value);
                if (type == 0) {
                  searchUser();
                }
                if (type == 1) {
                  searchPost();
                }
                if (value == '')
                  setState(() {
                    // query.text=value;
                    searchList = [];
                    postList = [];
                  });
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Color(0XFFffe6ea), width: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Color(0XFFffe6ea), width: 0.5),
                ),
                filled: true,
                fillColor: Color(0XFFffe6ea),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[400],
                  size: 20,
                ),
                // suffixIcon: Icon(
                //   Icons.filter_list_alt,
                //   color: Colors.grey[400],
                //   size: 20,
                // ),
                /* hintText: 'Search for rooms',
                hintStyle: TextStyle(
                    color: Color(0XFF9D9D9D),
                    fontWeight: FontWeight.w400,
                    fontSize: 14),*/
              ),
              cursorWidth: 1,
              maxLines: 1,
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
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: DefaultTabController(
                  length: 2,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 5,
                    ),
                    //  width: MediaQuery.of(context).size.width/1.8,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color(0XFFFFb0b0b0), width: 0.2),
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0XFFffe6ea),
                    ),
                    height: MediaQuery.of(context).size.height / 16,
                    child: TabBar(
                      onTap: (value) {
                        if (value == 0) {
                          searchUser();
                          setState(() {
                            type = 0;
                          });
                          // process=true;
                          // fetchAllPostData("");
                        } else if (value == 1) {
                          print('post');
                          searchPost();
                          setState(() {
                            type = 1;
                          });
                          // process=true;
                          // fetchAllPostData("question");
                        }
                      },
                      unselectedLabelColor: Color(0XFF9D9D9D),
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0XFFFE99AC)),
                      unselectedLabelStyle: TextStyle(
                        color: Color(0XFF9D9D9D),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: (17 / 14),
                        fontFamily: "Roboto",
                      ),
                      labelPadding: EdgeInsets.zero,
                      labelStyle: TextStyle(
                        color: Color(0XFFFFFFFF),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                      ),
                      tabs: [
                        Tab(
                          text: "User",
                        ),
                        Tab(
                          text: "Post",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            (query.text == '')
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.search,
                            color: Colors.black12,
                            size: 110,
                          ),
                        ),
                        Text(
                          'No results to display',
                          style: TextStyle(
                            color: Colors.black12,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  )
                :
                // Text('Hi'),
                (type == 0)
                    ? searchList.length > 0
                        ?
                Expanded(
                            child: ListView.builder(
                                itemCount: searchList.length,
                                itemBuilder: (ctx, index) => Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: ListTile(
                                          leading: searchList[index]
                                                      .profileImage ==
                                                  ''
                                              ? CircleAvatar(
                                                  radius: 24,
                                                  // backgroundColor: Colors.yellowAccent,
                                                  backgroundImage: AssetImage(
                                                    "assets/images/user_profile.png",
                                                  ),
                                                )
                                              : CircleAvatar(
                                                  radius: 24,
                                                  backgroundColor: Colors.white,
                                                  backgroundImage: NetworkImage(
                                                      "${searchList[index].profileImage}")),
                                          title: Text(
                                            '${searchList[index].userName}',
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
                                            '${searchList[index].email}',
                                            style: TextStyle(
                                              // letterSpacing: 1,
                                              color: Color(0XFF9D9D9D),
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              // height: (17 / 14),
                                              fontFamily: "Roboto",
                                            ),
                                          ),
                                        ),

                                        // Text('${searchList[index].firstName}'),
                                      ),
                                    )))
                        :
                Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black12,
                                    size: 110,
                                  ),
                                ),
                                Text(
                                  'No results to display',
                                  style: TextStyle(
                                    color: Colors.black12,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          )
                    : postList.length > 0
                        ? Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child:

                                Container(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:ClampingScrollPhysics(),
                                      itemCount:postList.length>0  ? postList.length : 0,
                                      itemBuilder: (context, index) {

                                        return InkWell(
                                          onTap: (){
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
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: 10),
                                            child: Container(
                                              child: Card(
                                                elevation: 8,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                child: Container(
                                                  padding: EdgeInsets.only(top:8,bottom: 8),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                      Visibility(
                                                        visible:postList[index].sharePost!=null && postList[index].postType=="share"? true : false,
                                                        child: Container(
                                                          padding: EdgeInsets.only(left:8,right: 8,top: 7,),
                                                          child:  Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [

                                                              Expanded(
                                                                child: InkWell(
                                                                  onTap: (){
                                                                    // if(postList[index].postType=="share" && postList[index].createdBy!.id != userDetails!.userId)
                                                                    //   Navigator.of(context).push(CupertinoPageRoute(builder: (builder)=>OtherProfile( )));
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
                                                                    child: Row(
                                                                      children: [

                                                                        Container(
                                                                          child: CircleAvatar(
                                                                            radius: 20.5,
                                                                            backgroundColor:Color(0XFFFFb0b0b0),
                                                                            child: CircleAvatar(
                                                                                radius: 20,
                                                                                backgroundColor: Colors.white,
                                                                                child:postList[index].createdBy!.profileImage==""
                                                                                    ?CircleAvatar(
                                                                                  radius: 17,
                                                                                  backgroundColor: Colors.white,
                                                                                  backgroundImage:AssetImage("assets/images/user_profile.png",),
                                                                                )
                                                                                    :CircleAvatar(
                                                                                    radius: 17,
                                                                                    backgroundColor: Colors.white,
                                                                                    backgroundImage:NetworkImage("${postList[index].createdBy!.profileImage}")
                                                                                )
                                                                            ),
                                                                          ),
                                                                        ),

                                                                        SizedBox( width: 10, ),

                                                                        Flexible(
                                                                          child: Container(
                                                                            child: Text(
                                                                              '${postList[index].createdBy!.userName}',
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
                                                              ),


                                                              Container(
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

                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      Visibility(
                                                        visible:postList[index].sharePost!=null && postList[index].postType=="share" ? true : false,
                                                        child: Container(
                                                          margin: EdgeInsets.only(top:10,bottom: 10,left: 10,right: 8),
                                                          child: Text(
                                                            '${postList[index].content}',
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
                                                      ),

                                                      Visibility(
                                                          visible:postList[index].sharePost!=null && postList[index].postType=="share" ? true : false,
                                                          child: Divider(thickness: 1,)
                                                      ),

                                                      Container(
                                                          padding: EdgeInsets.only(left:8,right: 8),
                                                          child:  Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [

                                                              Container(
                                                                child: Text(
                                                                  '${postList[index].subCategoryId?.name}',
                                                                  style: TextStyle(
                                                                    color: Color(0XFF9D9D9D),
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.bold,
                                                                    height: (17 / 14),
                                                                    fontFamily: "Roboto",
                                                                  ),
                                                                ),
                                                              ),

                                                              Visibility(
                                                                visible: postList[index].sharePost!=null && postList[index].postType=="share" ? false : true,
                                                                child: Container(
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
                                                          )
                                                      ),

                                                      Container(
                                                        padding: EdgeInsets.only(left:8,right: 8),
                                                        margin: EdgeInsets.only(top: 3),
                                                        child: Text('${postList[index].subCategoryId!.hashtag}',
                                                          maxLines:1,style: TextStyle(
                                                            color: Color(0XFF9D9D9D),
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily: "Roboto",
                                                          ),
                                                        ),
                                                      ),

                                                      Visibility(
                                                        visible: postList[index].image!="" || (postList[index].sharePost!=null && postList[index].sharePost!.image!="") ? true : false,
                                                        child: Container(
                                                            margin: EdgeInsets.only(top: 5,left: 8,right: 8),
                                                            width: MediaQuery.of(context).size.width,
                                                            height:MediaQuery.of(context).size.height/6 ,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                                                border: Border.all(color: Color(0XFFFFb0b0b0),width: 0.2),
                                                                image: DecorationImage(
                                                                  image:postList[index].postType=="share" && postList[index].sharePost!=null
                                                                      ?NetworkImage("${postList[index].sharePost!.image}")
                                                                      :NetworkImage("${postList[index].image}"),
                                                                  fit: BoxFit.fitWidth,
                                                                )
                                                            )
                                                        ),
                                                      ),

                                                      InkWell(
                                                        onTap: (){
                                                          // if(postList[index].postType!="share" && postList[index].createdBy!.id != userDetails!.userId)
                                                          //   Navigator.of(context).push(CupertinoPageRoute(builder: (builder)=>OtherProfile( )));
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
                                                          padding: EdgeInsets.only(left:8,right: 8,top: 7,),
                                                          child:  Row(
                                                            children: [

                                                              Container(
                                                                child: CircleAvatar(
                                                                  radius: 20.5,
                                                                  backgroundColor:Color(0XFFFFb0b0b0),
                                                                  child: CircleAvatar(
                                                                      radius: 20,
                                                                      backgroundColor: Colors.white,
                                                                      child:(postList[index].postType=="share" && postList[index].sharePost!=null && postList[index].sharePost!.createdBy!.profileImage=="") ||
                                                                          postList[index].createdBy!.profileImage==""
                                                                          ?CircleAvatar(
                                                                        radius: 17,
                                                                        backgroundColor: Colors.white,
                                                                        backgroundImage:AssetImage("assets/images/user_profile.png",),
                                                                      )
                                                                          :CircleAvatar(
                                                                          radius: 17,
                                                                          backgroundColor: Colors.white,
                                                                          backgroundImage:postList[index].postType=="share" && postList[index].sharePost!=null
                                                                              ?NetworkImage("${postList[index].sharePost!.createdBy!.profileImage}")
                                                                              :NetworkImage("${postList[index].createdBy!.profileImage}")
                                                                      )
                                                                  ),
                                                                ),
                                                              ),

                                                              SizedBox( width: 10, ),

                                                              Flexible(
                                                                child: Container(
                                                                  child: Text(
                                                                    '${(postList[index].postType=="share" && postList[index].sharePost!=null) ? postList[index].sharePost!.createdBy!.userName  :postList[index].createdBy!.userName}',
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

                                                      Container(
                                                        margin: EdgeInsets.only(top:10,bottom: 10,left: 10,right: 8),
                                                        child: Text(
                                                          '${(postList[index].postType=="share" && postList[index].sharePost!=null) ? postList[index].sharePost!.content : postList[index].content}',
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

                                                      Divider(thickness: 1,),

                                                      Container(
                                                        margin: EdgeInsets.only(left: 8,right: 8),
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
                                                                        child: Image.asset("assets/images/like.png",width: MediaQuery.of(context).size.width/20,
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
                                                                          child: Image.asset("assets/images/comment.png",width: MediaQuery.of(context).size.width/20,)
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
                                                                          child: Image.asset("assets/images/share.png",width: MediaQuery.of(context).size.width/20,)
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
                                                                          searchPost();
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
                                                                          searchPost();
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
                                                      )

                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );

                                      }
                                  ),
                                )
                            ),
                          )
                        :
                Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black12,
                                    size: 110,
                                  ),
                                ),
                                Text(
                                  'No results to display',
                                  style: TextStyle(
                                    color: Colors.black12,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          )
          ],
        ),
      ),

      // ],
      // ),
      // ),
    );
  }
}
