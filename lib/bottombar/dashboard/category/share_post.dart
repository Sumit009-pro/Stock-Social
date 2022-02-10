import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_social/models/api.dart';
import 'package:stock_social/models/categories_model.dart';
import 'package:stock_social/models/post_model.dart';
import 'package:stock_social/models/user_model.dart';
import 'package:stock_social/widgets/loading_spinner.dart';

import '../../../chat_screen.dart';
import '../../../messages.dart';

class SharePost extends StatefulWidget {
  final SubCategory? subCategoryData;
  final PostModel postData;
  final Function(PostModel,int,int,int) postUpdate;
  const SharePost({Key? key,this.subCategoryData,required this.postData,required this.postUpdate}) : super(key: key);

  @override
  _SharePostState createState() => _SharePostState();
}

class _SharePostState extends State<SharePost> {

  UserModel? userDetails;

  final _shareController=new TextEditingController();
  final _shareFocusNode=new FocusNode();
  List chatUsersList = [];
  bool showLoader = false;
  bool showMsgsList = false;

  @override
  void initState() {
    super.initState();
    userDetails = UserModel.getInstance();
  }

  fetchMassagesList() async{
    setState(() {
      showLoader = true;
    });
    final response = await API.fetchMessages(
        userDetails!.userId);
    setState(() {
      chatUsersList = response['response_data']['message'];
      showLoader = false;
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
                  tooltip:MaterialLocalizations.of(context).openAppDrawerTooltip,
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
          )
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 45),
                  padding: EdgeInsets.only(left: 16,right: 16,top: 30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.3),
                          blurRadius:4.0, // soften the shadow
                          offset: Offset(
                            0.0, // Move to right 10  horizontally
                            -1.0, // Move to bottom 10 Vertically
                          ),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [


                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                              child: CircleAvatar(
                                radius: 33.5,
                                backgroundColor:Color(0XFFFFb0b0b0),
                                child: CircleAvatar(
                                    radius: 33,
                                    backgroundColor: Colors.white,
                                    child:CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.white,
                                        backgroundImage:NetworkImage("${userDetails!.profileImage}")
                                    )
                                ),
                              ),
                            ),

                            SizedBox( width: 10, ),

                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child:Text("${userDetails!.userName}",
                                        style: TextStyle(  color: Color(0XFF9D9D9D),
                                            fontSize: 15,fontWeight: FontWeight.bold,fontFamily: "Roboto"),),
                                    ),


                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: TextFormField(
                                        controller: _shareController,
                                        keyboardType: TextInputType.multiline,
                                        maxLength: null,
                                        maxLines: null,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText: 'Say something about this...',
                                          hintStyle: TextStyle(
                                            color: Color(0XFFFFb0b0b0),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            height: (15 / 12),
                                            fontFamily: "Roboto",
                                          ),
                                        ),
                                        focusNode: _shareFocusNode,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: DefaultTabController(
                          length: 3,
                          child:Container(
                            decoration: BoxDecoration(
                              border: Border.all(color:Color(0XFFFFb0b0b0),width: 0.2),
                              borderRadius: BorderRadius.circular(50),
                              color:Color(0XFFffe6ea),
                            ),
                            height: MediaQuery.of(context).size.height/14,
                            child: TabBar(
                              isScrollable: true,
                              onTap: (value)async{
                                FocusScope.of(context).requestFocus(FocusNode());
                                  if(value==0){
                                    if(_shareController.text=="")  FocusScope.of(context).requestFocus(_shareFocusNode);
                                    else{
                                      //FocusScope.of(context).requestFocus(new FocusNode());

                                      showLoadingSpinner(context, "Please wait...");
                                      final response = await API.sharePost(
                                          {
                                            "content":"${_shareController.text}",
                                            "subCategoryId":"${widget.subCategoryData!.id}",
                                            "contentType":"post",
                                            "postId":"${widget.postData.id}"
                                          }
                                      );
                                      hideLoadingSpinner(context);

                                      if(response["STATUSCODE"] == 200){

                                         setState(() {

                                           var data;
                                           var image=widget.subCategoryData!.image!.split("/");
                                           var profileImage=userDetails!.profileImage!.split("/");
                                           var sharePostImage=widget.postData.image!.split("/");
                                           var sharePostProfileImage=widget.postData.createdBy!.profileImage!.split("/");

                                           data={
                                             "postType": "share",
                                             "contentTpe":"post",
                                             "comments": [],
                                             "likes": [],
                                             "createdAt": "${response["response_data"]["newPost"]["createdAt"]}",
                                             "_id": "${response["response_data"]["newPost"]["_id"]}",
                                             "subCategoryId": {
                                               "name_are": "${widget.subCategoryData!.nameAre}",
                                               "category": [ ],
                                               "image": "${image[image.length-1]}",
                                               "description": "${widget.subCategoryData!.description}",
                                               "_id": "${widget.subCategoryData!.id}",
                                               "name": "${widget.subCategoryData!.name}",
                                               "hashtag": "${widget.subCategoryData!.hashtag}"
                                             },
                                             "content": "${response["response_data"]["newPost"]["content"]}",
                                             "image":"${response["response_data"]["newPost"]["image"]}",
                                             "createdBy": {
                                               "userName": "${userDetails!.userName}",
                                               "profileImage": "${profileImage[profileImage.length-1]}",
                                               "_id": "${userDetails!.userId}",
                                               "email": "${userDetails!.email}"
                                             },
                                              "sharePost": {
                                                "content": "${widget.postData.content}",
                                                "image":"${widget.postData.image=="" ? "" : "/post/${sharePostImage[sharePostImage.length-1]}"}",
                                                "createdBy": {
                                                  "userName": "${widget.postData.createdBy!.userName}",
                                                  "profileImage": "${sharePostProfileImage[sharePostProfileImage.length-1]}",
                                                  "email": "${widget.postData.createdBy!.email}"
                                                },
                                              }
                                           };

                                         //  print("data....$data...\n${widget.postData.image}");

                                           widget.postUpdate(PostModel.fromJson(data),response["response_data"]["utils"]["totalPost"],response["response_data"]["utils"]["totalQuestion"],response["response_data"]["utils"]["engagementCount"]);

                                           widget.postData.share.insert(0,"");

                                         });
                                      }
                                      Navigator.of(context,rootNavigator: true).pop();
                                      ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text(response["message"]))));

                                    }//else
                                  }

                                  if(value == 1){
                                    fetchMassagesList();
                                    setState(() {
                                      showMsgsList = true;
                                    });
                                  }else{
                                    setState(() {
                                      chatUsersList = [];
                                      showMsgsList = false;
                                    });
                                  }

                              },
                             // controller: ,
                              unselectedLabelColor:Color(0XFF9D9D9D),
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0XFFFE99AC)
                              ),
                              unselectedLabelStyle: TextStyle(
                                color: Color(0XFF9D9D9D),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Roboto",
                              ),
                              labelStyle: TextStyle(
                                color: Color(0XFFFFFFFF),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Roboto",
                              ),
                              tabs: [
                                Tab(  child: Text("Share on your profile",softWrap: true,textAlign: TextAlign.center,),   ),
                                // Tab(  child: Text("Share on Rooms",softWrap: true,textAlign: TextAlign.center,),   ),
                                Tab(  child: Text("Send in message",textAlign: TextAlign.center,),   ),
                                Tab(  child: Text("Copy link",softWrap: true,textAlign: TextAlign.center,),   ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 20,bottom: 20),
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [


                                Container(
                                  padding: EdgeInsets.only(left:8,right: 8,top: 7,bottom: 7),
                                  child:  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Container(
                                        child: CircleAvatar(
                                          radius: 20.5,
                                          backgroundColor:Color(0XFFFFb0b0b0),
                                          child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.white,
                                              child:widget.postData.createdBy!.profileImage==""
                                                  ?CircleAvatar(
                                                radius: 17,
                                                backgroundColor: Colors.white,
                                                backgroundImage:AssetImage("assets/images/user_profile.png",),
                                              )
                                                  :CircleAvatar(
                                                  radius: 17,
                                                  backgroundColor: Colors.white,
                                                  backgroundImage:NetworkImage("${widget.postData.createdBy!.profileImage}")
                                              )
                                          ),
                                        ),
                                      ),

                                      SizedBox( width: 10, ),

                                      Flexible(
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Container(
                                                padding: EdgeInsets.only(top:10),
                                                child: Text(
                                                  '${widget.postData.createdBy!.userName}',
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
                                                visible: widget.postData.image!="" ?true : false,
                                                child: Container(
                                                    margin: EdgeInsets.only(top: 5,),
                                                    width: MediaQuery.of(context).size.width,
                                                    height:MediaQuery.of(context).size.height/6 ,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                                        border: Border.all(color: Color(0XFFFFb0b0b0),width: 0.2),
                                                        image: DecorationImage(
                                                          image:NetworkImage("${widget.postData.image}"),
                                                          fit: BoxFit.fitWidth,
                                                        )
                                                    )
                                                ),
                                              ),

                                              Container(
                                                margin: EdgeInsets.only(top:10,bottom: 10,),
                                                child: Text(
                                                  '${widget.postData.content}',
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

                                              Container(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [

                                                    Expanded(
                                                      child: Container(
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [

                                                              Container(
                                                                child: Image.asset("assets/images/like.png",width: MediaQuery.of(context).size.width/20,
                                                                  color:Colors.grey,),
                                                              ),

                                                              SizedBox(width: 5,),

                                                              Container(
                                                                child:Text('${widget.postData.likes.length}',
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

                                                    //SizedBox(width: 5,),

                                                    Expanded(
                                                      child: Container(
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [

                                                              Container(
                                                                  child: Image.asset("assets/images/comment.png",width: MediaQuery.of(context).size.width/20,)
                                                              ),


                                                              SizedBox(width: 5,),

                                                              Container(
                                                                child:Text('${widget.postData.comments.length}',
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

                                                    SizedBox(width: 5,),

                                                    Expanded(
                                                      child:Container(
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [

                                                              Container(
                                                                  child: Image.asset("assets/images/share.png",width: MediaQuery.of(context).size.width/20,)
                                                              ),

                                                              SizedBox(width: 5,),

                                                              Container(
                                                                child:Text('${widget.postData.share.length}',
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

                                                    SizedBox(width: 5,),

                                                    Expanded(
                                                      child:  Container(
                                                        alignment: Alignment.center,
                                                        child: Icon(Icons.more_horiz,color: Colors.grey,),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              )


                                            ],
                                          ),
                                        )
                                      ),

                                    ],
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),
                      ),

                      if(showMsgsList)Stack(
                        children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(height: 40,thickness: 1,),
                              Text(
                                'Share with:',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  //color: Color(0XFFFFFFFF),
                                  //fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  //height: (30 / 24),
                                  fontFamily: "Roboto",
                                ),
                              ),
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

                                      API.sendMessages(userDetails!.userId, userId,
                                          _shareController.text,"POST",
                                          widget.postData.toJson()['_id']
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>  ChatScreen(
                                          name: userName,
                                          image: imageUrl,
                                          toUserId: userId,
                                          msgType: "POST",
                                          postData: widget.postData,
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
                                          subtitle: Text(
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
                              ),
                            ],
                          ),
                          if(showLoader)Center(
                            child: CircularProgressIndicator(color: Colors.pinkAccent,),
                          )
                        ],
                      )

                    ],
                  ),
                )
            ),


          ],
        ),
      ),
    );
  }
}
