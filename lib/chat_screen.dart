import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stock_social/models/post_model.dart';
import 'bottombar/profile/post_details.dart';
import 'main.dart';
import 'models/api.dart';

class ChatScreen extends StatefulWidget {
  final name, image, toUserId, msgType, postData;
  const ChatScreen({Key? key, this.name, this.image, this.toUserId, this.msgType, this.postData}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin{
  TextEditingController msgController = TextEditingController();
  final _scrollController = ScrollController();
  List messagesResponseList = [];
  bool showLoader = true;
  bool flag = true;
  int count = 0;
  List<ChatMessage> messages = [
    // ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    // ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    // ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
    // ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    // ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];

  @override
  void initState() {
    super.initState();
    fetchMassagesDetails();
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (mounted) {fetchMassagesDetails();}
      else {timer.cancel();}
    });
  }

  _scrollToBottom(){
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  Future fetchMassagesDetails() async{
    final response = await API.fetchOneToOneMessages(
        userDetails!.userId, widget.toUserId);
    setState(() {
      showLoader = false;
      List temp = response['response_data']['message'];
      if(messagesResponseList.isNotEmpty){
        if(count < 5){
          _scrollToBottom();
          _scrollToBottom();
          _scrollToBottom();
          _scrollToBottom();
          _scrollToBottom();
          _scrollToBottom();
        }
        count++;
      }
      messagesResponseList = response['response_data']['message'];
      messages = [];
      for(var data in messagesResponseList){
        messages.add(ChatMessage(
          messageContent: data['message'],
          senderType: userDetails!.userId == data['fromUserId']['_id'] ?
            "sender" : "receiver",
          messageType: data['messageType'],
          postData: data['messageType'] == 'POST' ? data['postId'] : {}
        ));
      }
    });
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   //fetchMassagesDetails();
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(254, 153, 172, 1),

        title:
        Row(
          children: [
            ClipOval(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: CachedNetworkImage(
                    imageUrl: widget.image,
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
            ),
            Padding(padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.height * 0.02
            )),
            Text(widget.name),
          ],
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: showLoader ? Center(
          child: Padding(
            padding: EdgeInsets.only(top: 0.0),
            child: CircularProgressIndicator(color: Colors.pinkAccent,),
          ),
        ) :
        Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.075),
          child: Scrollbar(
            controller: _scrollController,
            isAlwaysShown: false,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return Row(
                  children: [
                    if(messages[index].senderType != "receiver")Padding(padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1
                    )),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                        child: Align(
                          alignment: (messages[index].senderType == "receiver"?Alignment.topLeft:Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (messages[index].senderType  == "receiver" ?
                              Colors.grey.shade200:Color.fromRGBO(252, 211, 206, 1)),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(messages[index].messageContent,
                                  style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                if(messages[index].messageType == "POST")
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>  PostDetails(
                                          id: messages[index].postData['_id'],
                                        )),
                                      );
                                    },
                                    child: Container(
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
                                                child:  Flexible(
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                    child:messages[index].postData['image'] == ""
                                                                        ? CircleAvatar(
                                                                      radius: 17,
                                                                      backgroundColor: Colors.white,
                                                                      backgroundImage:AssetImage("assets/images/user_profile.png",),
                                                                    )
                                                                        :ClipOval(
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                            color: Colors.white
                                                                        ),
                                                                        child: CachedNetworkImage(
                                                                            imageUrl: "http://nodeserver.mydevfactory.com:8086/img/profile-pic/"
                                                                                "${messages[index].postData['createdBy']['profileImage']}",//+messages[index].postData['image'],
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
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox( width: 10, ),
                                                              Container(
                                                                padding: EdgeInsets.symmetric(vertical:10),
                                                                child: Text(
                                                                  '${messages[index].postData['createdBy']['userName']}',
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
                                                          SizedBox( height: 8, ),
                                                          Visibility(
                                                            visible: messages[index].postData['image'] != "" ? true : false,
                                                            child: CachedNetworkImage(width: double.infinity,
                                                                height: MediaQuery.of(context).size.height /6,
                                                                imageUrl: "http://nodeserver.mydevfactory.com:8086/img"+messages[index].postData['image'],
                                                                imageBuilder: (context, imageProvider) => Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                                                    border: Border.all(color: Color(0XFFFFb0b0b0),width: 0.2),
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

                                                          Container(
                                                            margin: EdgeInsets.only(top:10,bottom: 10,),
                                                            child: Text(
                                                              '${messages[index].postData['content']}',
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
                                                                          child:Text('${messages[index].postData['likes'].length}',
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
                                                                          child:Text('${messages[index].postData['comments'].length}',
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
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: [

                                                                        Container(
                                                                            child: Image.asset("assets/images/share.png",width: MediaQuery.of(context).size.width/20,)
                                                                        ),

                                                                        SizedBox(width: 5,),

                                                                        Container(
                                                                          child:Text('${messages[index].postData['share'].length}',
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

                                                              ],
                                                            ),
                                                          )


                                                        ],
                                                      ),
                                                    )
                                                ),
                                              ),


                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            )
                          ),
                        ),
                      ),
                    ),
                    if(messages[index].senderType == "receiver")Padding(padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1
                    )),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: msgController,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)
                  ),
                  hintText: "Type message..."
                ),
              ),
            ),
            IconButton(
              onPressed: (){
                API.sendMessages(userDetails!.userId, widget.toUserId,
                  msgController.text, "NORMAL", ""
                );
                setState(() {
                  messages.add(ChatMessage(
                    messageContent: msgController.text,
                    senderType: "sender",
                    messageType: "NORMAL"
                  ));
                  Timer.periodic(Duration(milliseconds: 100), (timer) {
                    if (mounted) {
                      _scrollToBottom();
                      timer.cancel();
                    } else {

                    }
                  });
                  msgController.text = "";
                });
              },
              icon: Icon(IconData(0xe571, fontFamily: 'MaterialIcons', matchTextDirection: true))
            )
          ],
        ),
      ),
    );
  }
}

class ChatMessage{
  final String messageContent;
  final String senderType;
  final String messageType;
  final postData;
  final id;
  ChatMessage({required this.messageContent, required this.senderType,
    required this.messageType, this.postData, this.id});
}

