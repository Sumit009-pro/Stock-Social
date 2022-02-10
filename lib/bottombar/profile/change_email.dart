import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stock_social/models/user_model.dart';
import 'package:stock_social/signup/enter_code.dart';
import 'package:stock_social/widgets/loading_spinner.dart';
import 'package:stock_social/widgets/my_material_button.dart';
import 'package:stock_social/widgets/profile_image.dart';

import '../../models/api.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({Key? key}) : super(key: key);

  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  @override
  UserModel? userDetails;

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userDetails = UserModel.getInstance();
    print(userDetails);
  }

  onSubmit() async {
    if (_formKey.currentState!.validate()) {
      showLoadingSpinner(context, "Please wait...");
      final response =
          await API.customerVerifyUser(email: _emailController.text);
      hideLoadingSpinner(context);

      if (response["STATUSCODE"] == 200) {
        // obtain shared preferences
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EnterCode(
                    onNext: () async {
                      showLoadingSpinner(context, "Please wait...");
                      final response =
                          await API.updateUserEmail(_emailController.text);
                      hideLoadingSpinner(context);

                      // obtain shared preferences
                      if (response["STATUSCODE"] == 200) {
                        // obtain shared preferences
                        Navigator.pop(context);
                        Navigator.pop(context);
                        // Navigator.popUntil(context, (route) => route.settings.name == "/account-details");
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                          (SnackBar(content: Text(response["message"]))));
                    },
                    code: response["response_data"]["otp"])));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar((SnackBar(content: Text(response["message"]))));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          (SnackBar(content: Text("Please correct errors and submit again"))));
    }
  }

  // onSubmit() async {
  //   if (_formKey.currentState!.validate()) {
  //     showLoadingSpinner(context, "Please wait...");
  //     final response = await API.updateUserEmail(_emailController.text);
  //     hideLoadingSpinner(context);

  //     // obtain shared preferences
  //     if (response["STATUSCODE"] == 200) {
  //       // obtain shared preferences
  //       Navigator.pop(context);
  //     }

  //     ScaffoldMessenger.of(context)
  //         .showSnackBar((SnackBar(content: Text(response["message"]))));
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar((SnackBar(content: Text("Please fix errors"))));
  //   }
  // }

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
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        'How do you want to change your email?',
                        style: TextStyle(
                          color: Color(0XFF808080),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          height: (22 / 18),
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ListTile(
                      leading: SizedBox(
                        height: 100,
                        width: 60,
                        child:
                            ProfileImage(imageUrl: userDetails?.profileImage),
                      ),
                      title: Text("${userDetails?.firstName} ${userDetails?.lastName}",
                        //'Profile Name',
                        style: TextStyle(
                          color: Color(0XFF808080),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: (17 / 14),
                          fontFamily: "Roboto",
                        ),
                      ),
                      subtitle: Text(
                        userDetails?.email ?? "",
                        style: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: (17 / 14),
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 12),
                      child: Text(
                        'Please update your new email, ensure that its different from the old one',
                        style: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: (22 / 14),
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Color(0XFF9D9D9D),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: (15 / 12),
                            fontFamily: "Roboto",
                          ),
                        ),
                        validator: (value) {
                          // ignore: unnecessary_null_comparison
                          if (value!.isEmpty || value == null) {
                            return "Email is required";
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 42,
                    ),
                    MyMaterialButton(tittle: ' Save', onTap: onSubmit),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
