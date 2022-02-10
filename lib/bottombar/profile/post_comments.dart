import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_social/models/api.dart';
import 'package:stock_social/models/post_fetch_model.dart';
import 'package:stock_social/models/post_model.dart';
import 'package:stock_social/models/user_model.dart';
import 'package:stock_social/widgets/loading_spinner.dart';

class PostComments extends StatefulWidget {
  final Post postData;

  const PostComments({Key? key,required this.postData}) : super(key: key);

  @override
  _PostCommentsState createState() => _PostCommentsState();
}

class _PostCommentsState extends State<PostComments> {

  final _commentController=TextEditingController();

  UserModel? userDetails;

  @override
  void initState() {
    super.initState();
    userDetails = UserModel.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        children: [

          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child:widget.postData.comments!.length>0
                  ?ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount:widget.postData.comments!.length >0  ? widget.postData.comments!.length : 0,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context,index){

                    return
                      Container(
                      margin: EdgeInsets.only(bottom: 18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            child: CircleAvatar(
                              radius: 20.5,
                              backgroundColor:Color(0XFFFFb0b0b0),
                              child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child:widget.postData.comments![index].commentedBy!.profileImage==""
                                      ?CircleAvatar(
                                    radius: 17,
                                    backgroundColor: Colors.white,
                                    backgroundImage:AssetImage("assets/images/user_profile.png",),
                                  )
                                      :CircleAvatar(
                                      radius: 17,
                                      backgroundColor: Colors.white,
                                      backgroundImage:NetworkImage("${widget.postData.comments![index].commentedBy!.profileImage}")
                                  )
                              ),
                            ),
                          ),

                          SizedBox(width: 15,),

                          Flexible(
                            child: Container(
                              padding:EdgeInsets.only(top:8,bottom: 8,left: 15,right: 15),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey,width: 0.2),
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                    child: Text(
                                      '${widget.postData.comments![index].commentedBy!.userName}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        height: (17 / 14),
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                  ),

                                  Container(
                                    child: Text(
                                      '${widget.postData.comments![index].comment}',
                                      softWrap: true,style: TextStyle(
                                      color:Color(0XFFFF808080),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      height: (17 / 14),
                                      fontFamily: "Roboto",
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

                  }
              )
                  :Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width/2,
                  margin: EdgeInsets.only(top:10,bottom: 10,left: 20,right: 20),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: RichText(
                      text: TextSpan(
                          text: 'No Comments Yet',
                          style: TextStyle(
                            color: Color(0XFFFFb0b0b0),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                          ),
                          children: [

                            TextSpan(
                              text: '\nBe the first to comment.',
                              style:TextStyle(
                                color: Color(0XFFFFb0b0b0),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                height: (17 / 14),
                                fontFamily: "Roboto",
                              ),
                            )


                          ]
                      ),
                    ),
                  )

              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: [

                Expanded(
                  child: Container(
                    //height: MediaQuery.of(context).size.height/15,
                    padding: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey,width: 0.2),
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child:TextFormField(
                      controller: _commentController,
                      keyboardType: TextInputType.multiline,
                      // maxLength: null,
                      maxLines: null,
                      autofocus: true,
                      decoration: InputDecoration(
                        isDense: true, // important line
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        border: InputBorder.none,
                        hintText: 'Write a public comment...',
                        hintStyle: TextStyle(
                          color: Color(0XFFFFb0b0b0),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: (15 / 12),
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10,),

                InkWell(
                  onTap: ()async{
                    if(_commentController.text!="") {

                      FocusScope.of(context).requestFocus(new FocusNode());

                      showLoadingSpinner(context, "Please wait...");
                      final response = await API.addComment(
                          {
                            "comment":"${_commentController.text}",
                          },
                          "${ widget.postData.id}"
                      );
                      hideLoadingSpinner(context);

                      _commentController.text="";

                      if (response["STATUSCODE"] == 200) {
                        setState(() {
                          var profileImage=userDetails!.profileImage!.split("/");
                          var data={
                            "created_At": "${response["response_data"]["created_At"]}",
                            "_id": "${response["response_data"]["_id"]}",
                            "comment": "${response["response_data"]["comment"]}",
                            "commentedBy": {
                              "userName": "${userDetails!.userName}",
                              "profileImage": "${profileImage[profileImage.length-1]}",
                              "_id": "${userDetails!.userId}",
                              "email": "${userDetails!.email}"
                            }
                          };
                          widget.postData.comments!.insert(0,Comment.fromJson(data));
                        });
                      }
                      else  ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text(response["message"]))));
                    }//if
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 8,right: 8),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0XFFFE99AC)
                    ),
                    child: Icon(Icons.send,color: Colors.white,),
                  ),
                )

              ],
            ),
          )

        ],
      ),
    );
  }
}
