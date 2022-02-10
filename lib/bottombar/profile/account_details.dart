import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_social/bottombar/profile/change_cover_pic.dart';
import 'package:stock_social/models/user_model.dart';
import 'package:stock_social/bottombar/profile/profile_demo.dart';
import 'package:stock_social/bottombar/profile/change_email.dart';
import 'package:stock_social/bottombar/profile/change_password.dart';
import 'package:stock_social/bottombar/profile/change_username.dart';
import 'package:provider/provider.dart';
import 'package:stock_social/widgets/loading_spinner.dart';
import 'package:stock_social/widgets/profile_image.dart';
import 'dart:io';
import '../../models/api.dart';
import 'change_bio.dart';
import 'change_short_bio.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  File? imageFile;
  File? imageFile1;
  // bool isCover=false;

  uploadImage() async {
    showLoadingSpinner(context, "Please wait...");
    final response = await API.profileImageUpload(imageFile);
    hideLoadingSpinner(context);

    ScaffoldMessenger.of(context)
        .showSnackBar((SnackBar(content: Text(response["message"]))));
  }

  uploadCoverImage() async {
    showLoadingSpinner(context, "Please wait...");
    final response = await API.coverImageUpload(imageFile1);
    hideLoadingSpinner(context);

    ScaffoldMessenger.of(context)
        .showSnackBar((SnackBar(content: Text(response["message"]))));
  }

  Future<Null> _cropImage(filePath) async {
    File? croppedImage = await ImageCropper.cropImage(
        sourcePath: filePath,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
    if (croppedImage != null) {
      imageFile = croppedImage;
      setState(() {});
    }
  }

  Future<Null> _cropImage1(filePath) async {
    File? croppedImage = await ImageCropper.cropImage(
        sourcePath: filePath,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
    if (croppedImage != null) {
      imageFile1 = croppedImage;
      setState(() {});
    }
  }

  _imgFromCamera() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    if (image != null) {
      setState(() {
        _cropImage(image.path);
        imageFile = File(image.path);
      });
      uploadImage();
    }
  }

  _imgFromGallery() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      setState(() {
        _cropImage(image.path);
        imageFile = File(image.path);
      });
      uploadImage();
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();

                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera1() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    if (image != null) {
      setState(() {
        _cropImage1(image.path);
        imageFile1 = File(image.path);
      });
      uploadCoverImage();
    }
  }

  _imgFromGallery1() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      setState(() {
        _cropImage1(image.path);
        imageFile1 = File(image.path);
      });
      uploadCoverImage();
    }
  }

  void _showPicker1(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery1();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera1();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
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
            /* leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  tooltip:MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),*/
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'Profile',
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
          )),
      body: Consumer<UserModel>(builder: (context, userDetails, child) {
        // print('profileimage: ${userDetails.profileImage?.isNotEmpty} \n ${userDetails.profileImage}');

        return Column(children: [
          SizedBox(
            height: 32,
          ),
          Expanded(
            child: Container(
              // padding: EdgeInsets.only(top: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: 4.0, // soften the shadow
                      offset: Offset(
                        0.0, // Move to right 10  horizontally
                        -1.0, // Move to bottom 10 Vertically
                      ),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: ListView(
                children: [
                  // SizedBox(
                  //   height: 8,
                  // ),
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    color: Colors.transparent,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: [
                        InkWell(
                          onTap: () {
                            _showPicker1(context);

                          },
                          child:imageFile1 != null
                              ? Container(
                            height: MediaQuery.of(context).size.height / 4.5,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                               color: Colors.transparent,
                                borderRadius: BorderRadius.only(
                                  // bottomLeft: Radius.circular(15),
                                  // bottomRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            // borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              imageFile1!,
                              // width: 100,
                              // height: 100,
                              fit: BoxFit.cover,
                            ),
                          ): Container(
                            height: MediaQuery.of(context).size.height / 4.5,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                    NetworkImage("${userDetails!.coverImage}"),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.only(
                                    // bottomLeft: Radius.circular(15),
                                    // bottomRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                          ),
                        ),
                        Positioned(
                          left: 40,
                          right: 40,
                          bottom: 0,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (builder) => ProfileDemo()));
                            },
                            child: CircleAvatar(
                              radius: 56,
                              backgroundColor: Color(0XFFe6e6e6),
                              child: CircleAvatar(
                                  radius: 55,
                                  backgroundColor: Colors.white,
                                  //backgroundImage: NetworkImage(''),
                                  child: imageFile != null
                                      ? ClipOval(
                                          // borderRadius: BorderRadius.circular(50),
                                          child: Image.file(
                                            imageFile!,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : ProfileImage(
                                          imageUrl: userDetails.profileImage)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: Center(
                      child: Text(
                        'Edit photo',
                        style: TextStyle(
                          color: Color(0XFFFF808080),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: (17 / 14),
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Login and security',
                      style: TextStyle(
                        color: Color(0XFFFF808080),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        height: (24 / 20),
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Divider(),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ChangeUsername()));
                        setState(() {});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Username',
                            style: TextStyle(
                              color: Color(0XFFFF808080),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: (17 / 14),
                              fontFamily: "Roboto",
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                userDetails.userName ?? "",
                                style: TextStyle(
                                  color: Color(0XFFFFb0b0b0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: (17 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                              SizedBox(width: 6),
                              Icon(
                                Icons.chevron_right,
                                color: Color(0XFFFF808080),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),

                  /*Padding(
                     padding: const EdgeInsets.all(16.0),
                     child: GestureDetector(
                       onTap: () {
                         Navigator.push(
                             context,
                             CupertinoPageRoute(
                                 builder: (context) => ChangePhoneNumber()));
                         setState(() {});
                       },
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(
                             'Phone',
                             style: TextStyle(
                              color:Color(0XFFFF808080),
                               fontSize: 14,
                               fontWeight: FontWeight.w500,
                               height: (17 / 14),
                               fontFamily: "Roboto",
                             ),
                           ),
                           Row(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Text(
                                 userDetails.phone ?? "",
                                 style: TextStyle(
                                   color: Color(0XFFFFb0b0b0),
                                   fontSize: 14,
                                   fontWeight: FontWeight.w400,
                                   height: (17 / 14),
                                   fontFamily: "Roboto",
                                 ),
                               ),
                               SizedBox(width: 6),
                               Icon(
                                 Icons.chevron_right,
                                 color:Color(0XFFFF808080),
                               ),
                             ],
                           ),
                         ],
                       ),
                     ),
                   ),
                  Divider(),*/
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ChangeEmail()));
                        setState(() {});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              color: Color(0XFFFF808080),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: (17 / 14),
                              fontFamily: "Roboto",
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                userDetails.email ?? "",
                                style: TextStyle(
                                  color: Color(0XFFFFb0b0b0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: (17 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                              SizedBox(width: 6),
                              Icon(
                                Icons.chevron_right,
                                color: Color(0XFFFF808080),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ChangePassword()));
                        setState(() {});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Password',
                            style: TextStyle(
                              color: Color(0XFFFF808080),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: (17 / 14),
                              fontFamily: "Roboto",
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '************',
                                style: TextStyle(
                                  color: Color(0XFFFFb0b0b0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: (17 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                              SizedBox(width: 6),
                              Icon(
                                Icons.chevron_right,
                                color: Color(0XFFFF808080),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ChangeBio()));
                        setState(() {});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'About',
                            style: TextStyle(
                              color: Color(0XFFFF808080),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: (17 / 14),
                              fontFamily: "Roboto",
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                userDetails.about!.length > 20 ? userDetails.about!.substring(0,20)+'...':userDetails.about ?? "",

                                style: TextStyle(
                                  color: Color(0XFFFFb0b0b0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: (17 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                              SizedBox(width: 6),
                              Icon(
                                Icons.chevron_right,
                                color: Color(0XFFFF808080),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ChangeShortBio()));
                        setState(() {});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Short Bio',
                            style: TextStyle(
                              color: Color(0XFFFF808080),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: (17 / 14),
                              fontFamily: "Roboto",
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                userDetails.shortAbout!.length > 20 ? userDetails.shortAbout!.substring(0,20)+'...':userDetails.shortAbout ?? "",
                                style: TextStyle(
                                  color: Color(0XFFFFb0b0b0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: (17 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                              SizedBox(width: 6),
                              Icon(
                                Icons.chevron_right,
                                color: Color(0XFFFF808080),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),


                ],
              ),
            ),
          )
        ]);
      }),
    );
  }
}
