import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_social/models/user_model.dart';
import 'package:stock_social/widgets/loading_spinner.dart';
import '../../models/api.dart';


class ChangeCoverPic extends StatefulWidget {
  const ChangeCoverPic({Key? key}) : super(key: key);

  @override
  _ChangeCoverPicState createState() => _ChangeCoverPicState();
}

class _ChangeCoverPicState extends State<ChangeCoverPic> {
  File? imageFile;
  UserModel? userDetails;

  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userDetails = UserModel.getInstance();
    print(userDetails);
  }


  uploadImage() async {
    showLoadingSpinner(context, "Please wait...");
    final response = await API.profileImageUpload(imageFile);
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
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50);

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

  onSubmit() async {
    if (_formKey.currentState!.validate()) {
      showLoadingSpinner(context, "Please wait...");
      final response = await API.changeAbout(_usernameController.text);
      hideLoadingSpinner(context);

      // obtain shared preferences
      if (response["STATUSCODE"] == 200) {
        // obtain shared preferences
        Navigator.pop(context);
      }
      ScaffoldMessenger.of(context)
          .showSnackBar((SnackBar(content: Text(response["message"]))));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar((SnackBar(content: Text("Please fix errors"))));
    }
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
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  tooltip:
                  MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
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
      body: Form(
        key: _formKey,
        child: Column(children: [
          SizedBox(
            height: 32,
          ),
          InkWell(
            onTap: () {
              // Navigator.of(context).push(CupertinoPageRoute(builder: (builder)=>ProfileDemo( )));
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
                      : Container()
                  // ProfileImage(imageUrl: userDetails.profileImage)
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
