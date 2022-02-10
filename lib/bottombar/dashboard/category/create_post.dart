import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_social/models/api.dart';
import 'package:stock_social/models/categories_model.dart';
import 'package:stock_social/models/post_model.dart';
import 'package:stock_social/models/user_model.dart';
import 'package:stock_social/widgets/loading_spinner.dart';

class CreatePost extends StatefulWidget {
  final SubCategory? subCategoryData;
  final Function(PostModel,int,int,int) postUpdate;

  const CreatePost({Key? key,required this.subCategoryData,required this.postUpdate,}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {

  final _postController=new TextEditingController();
  final _postFocusNode=new FocusNode();

  File? imageFile;

  UserModel? userDetails;

  bool showImage=false;
  bool questionType=false;

  @override
  void initState() {
    super.initState();
    userDetails = UserModel.getInstance();
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
                  onPressed: () {}),
            ],
          )
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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

                            Flexible(
                              child: Container(
                                child: Row(
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
                                                backgroundImage:NetworkImage("${widget.subCategoryData!.image}")
                                            )
                                        ),
                                      ),
                                    ),

                                    SizedBox( width: 10, ),

                                    Expanded(
                                      child: Container(
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [


                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child:Text("Share a post...",
                                                style: TextStyle( color:Color(0XFFFFb0b0b0),
                                                    fontSize: 15,fontWeight: FontWeight.bold,fontFamily: "Roboto"),),
                                            ),

                                            InkWell(
                                              onTap:(){
                                                _imgFromGallery();
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(top:10),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0XFFFE99AC),
                                                ),
                                                child: Icon(Icons.collections_outlined,color: Colors.white,size: 15,),
                                              ),
                                            ),

                                          ],
                                        )

                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),

                            SizedBox( width: 10),

                            InkWell(
                              onTap: ()async{
                                if(_postController.text=="")  FocusScope.of(context).requestFocus(_postFocusNode);
                                else{
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  String base64Image="";
                                 // print("kkk..$imageFile..$base64Image");
                                 if(imageFile!=null){
                                   List<int> imageBytes = imageFile!.readAsBytesSync();
                                   base64Image = base64Encode(imageBytes);
                                 }
                                //  print("image.....$base64Image");

                                  showLoadingSpinner(context, "Please wait...");
                                  final response = await API.addPost(
                                      {
                                        "content":"${_postController.text}",
                                        "image":"$base64Image",
                                        "subCategoryId":"${widget.subCategoryData!.id}",
                                         "contentType":questionType ?"question"  :"post"
                                      }
                                  );
                                  hideLoadingSpinner(context);

                                  var data;
                                   if(response["STATUSCODE"] == 200){
                                     var image=widget.subCategoryData!.image!.split("/");
                                     var profileImage=userDetails!.profileImage!.split("/");

                                      data={
                                        "postType": "normal",
                                        "contentTpe":questionType ? "question" : "post",
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
                                      };
                                      widget.postUpdate(PostModel.fromJson(data),response["response_data"]["utils"]["totalPost"],response["response_data"]["utils"]["totalQuestion"],response["response_data"]["utils"]["engagementCount"]);
                                   }
                                    Navigator.of(context,rootNavigator: true).pop();
                                    ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text(response["message"]))));

                               }//else

                              },
                              child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width/4,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(top:5,bottom: 5,left: 20,right: 20),
                                  decoration: BoxDecoration(
                                      color:Color(0XFFFE99AC),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(.3),
                                          blurRadius:2.0, // soften the shadow
                                          offset: Offset(
                                            0.0, // Move to right 10  horizontally
                                            1.0, // Move to bottom 10 Vertically
                                          ),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  child:  Container(
                                    child:Text("Post",
                                      style: TextStyle( color:Colors.white,
                                          fontSize: 15,fontWeight: FontWeight.bold,fontFamily: "Roboto"),),
                                  )
                              ),
                            ),


                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                        child: TextFormField(
                          controller: _postController,
                          keyboardType: TextInputType.multiline,
                          maxLength: null,
                          maxLines: null,
                          autofocus: true,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: 'Type here...',
                            hintStyle: TextStyle(
                              color: Color(0XFFFFb0b0b0),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: (15 / 12),
                              fontFamily: "Roboto",
                            ),
                          ),
                          focusNode: _postFocusNode,
                        ),
                      ),

                      Visibility(
                        visible: showImage ? true : false,
                        child:Container(
                          margin: EdgeInsets.only(top:30,bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
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
                            border: Border.all(color: Color(0XFFFFb0b0b0),width: 0.2),
                          ),
                          child: Stack(
                            children: [

                              Container(
                                 width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(2),
                                child: showImage ? Image.file(imageFile!,fit: BoxFit.fitWidth) : Container(),
                              ),

                              Positioned(
                                top:0.0,
                                right: 0.0,
                                child:InkWell(
                                    onTap: (){
                                     setState(() {
                                       showImage=false;
                                       imageFile=null;
                                     });
                                    },
                                    child:Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: new Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        margin: EdgeInsets.only(top:10),
                                        padding: EdgeInsets.all(8),
                                        child:Icon(Icons.close,size: 25,)
                                      ),
                                    )
                                ),
                              ),

                            ],
                          ),
                        )
                      ),

                      Container(
                        margin: EdgeInsets.only(top:50),
                        child: CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            "This post is a question, I am looking for answer...",
                            maxLines: 2,
                            style: TextStyle(
                              color: Color(0XFF9D9D9D),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            //  height: (15 / 12),
                              fontFamily: "Roboto",
                            ),
                          ),
                          value: questionType,
                          activeColor:Color(0XFFFE99AC) ,
                          onChanged: (newValue) {
                            setState(() {
                              questionType = newValue!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                        ),
                      ),

                    ],
                  ),
                ),
              ),

    /*  Expanded(
                  child: Container(
                    color: Colors.white,
                   child: ListView(
                         shrinkWrap: true,
                         children: [

                           Container(
                             margin: EdgeInsets.only(top:10,bottom: 10,left: 20,right: 20),
                             child: Text(
                               '${_postController.text}',
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
                             margin: EdgeInsets.only(top:10,bottom: 10,left: 20,right: 20),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [


                                 Expanded(
                                   child: Container(
                                     height: MediaQuery.of(context).size.height/15,
                                     decoration: BoxDecoration(
                                         color: Color(0XFFFE99AC),
                                         boxShadow: [
                                           BoxShadow(
                                             color: Colors.black.withOpacity(.3),
                                             blurRadius:2.0, // soften the shadow
                                             offset: Offset(
                                               0.0, // Move to right 10  horizontally
                                               1.0, // Move to bottom 10 Vertically
                                             ),
                                           ),
                                         ],
                                         borderRadius: BorderRadius.all(Radius.circular(8))
                                     ),
                                     child:Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                       children: [

                                         Container(
                                           child:  Text("${widget.mainCategoryName}",
                                             textAlign: TextAlign.center,
                                             style: TextStyle( color: Colors.white,fontSize: 15,
                                               fontFamily: "Roboto",),),
                                         ),

                                         Container(
                                           child:Icon(Icons.arrow_drop_down,color: Colors.white,),
                                         ),

                                       ],
                                     )
                                   ),
                                 ),

                                 SizedBox(width: 10,),

                                 Expanded(
                                   child: Container(
                                       height: MediaQuery.of(context).size.height/15,
                                       decoration: BoxDecoration(
                                           color: Colors.white,
                                           boxShadow: [
                                             BoxShadow(
                                               color: Colors.black.withOpacity(.3),
                                               blurRadius:2.0, // soften the shadow
                                               offset: Offset(
                                                 0.0, // Move to right 10  horizontally
                                                 1.0, // Move to bottom 10 Vertically
                                               ),
                                             ),
                                           ],
                                           borderRadius: BorderRadius.all(Radius.circular(8))
                                       ),
                                       child:Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                         children: [

                                           Container(
                                             child:  Text("${widget.subCategoryData.name}",
                                               textAlign: TextAlign.center,
                                               style: TextStyle( color: Colors.grey,fontSize: 15,
                                                 fontFamily: "Roboto",),),
                                           ),

                                           Container(
                                             child:Icon(Icons.arrow_drop_down,color: Colors.grey,),
                                           ),

                                         ],
                                       )
                                   ),
                                 ),


                               ],
                             ),
                           )


                         ],
                    ),
                  )
              )*/


          ],
        ),
      ),
    );
  }

  _imgFromGallery() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      setState(() {
        imageFile = File(image.path);
        showImage=true;
      });
      //uploadImage();
    }
  }
}
