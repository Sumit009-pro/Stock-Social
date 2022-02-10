import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_social/models/user_model.dart';
import 'package:stock_social/signup/forgot_password.dart';
import 'package:stock_social/signup/sign_up.dart';
import 'package:stock_social/social/google_signin_api.dart';
import 'package:stock_social/widgets/loading_spinner.dart';
import 'package:stock_social/widgets/my_material_button.dart';


import 'dart:convert' as convert;
import '../main.dart';
import '../models/api.dart';
import '../home.dart';
import 'enter_code.dart';

class SignIn extends StatefulWidget {
  // const SignIn({Key? key}) : super(key: key);
  final plugin = FacebookLogin(debug: true);


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  String? _sdkVersion;
  bool checkedValue = false;
  // late BuildContext context;
  String token = "";
  String deviceId = "";
  String devie_token = "";

  bool isIOSDevice = false;
  bool _isLoggedIn = false;
  String selecttype = "";
  FacebookAccessToken? _token;
  FacebookUserProfile? _profile;
  String? _fbemail;
  String? _imageUrl;
  Map<String, Object> parameter = new HashMap();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //
  //
  //   super.initState();
  //
  //
  //   _getSdkVersion();
  //
  //
  // }


  Future<void> FacebookloginClick() async {
    await widget.plugin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    await _updateLoginInfo();
  }
  Future<void> _getSdkVersion() async {
    final sdkVesion = await widget.plugin.sdkVersion;
    setState(() {
      _sdkVersion = sdkVesion;
    });
  }
  Future<void> _updateLoginInfo() async {
    final plugin = widget.plugin;
    final token = await plugin.accessToken;
    FacebookUserProfile? profile;
    String? email;
    String? imageUrl;

    if (token != null) {
      profile = await plugin.getUserProfile();
      if (token.permissions.contains(FacebookPermission.email.name)) {
        email = await plugin.getUserEmail();
      }
      imageUrl = await plugin.getProfileImageUrl(width: 500);
    }
    print(profile!.firstName.toString());
    print(profile.lastName.toString());
    print(profile.userId.toString());
    print(email);
    print(imageUrl);
    _token = token;
    _profile = profile;
    _fbemail = email;
    _imageUrl = imageUrl;

    String first = profile.firstName.toString();
    String last = profile.lastName.toString();
    if (last == "") {
      last = first;
    }

    parameter['email'] = email.toString();
    /* parameter['password'] = "";
    parameter['device_id'] =  'sfsfaf';
    parameter['device_token'] = devie_token;
    if (Platform.isIOS) {
      parameter['device_type'] = "ios";
    }else {
      parameter['device_type'] = "android";
    }
    // parameter['login_type'] = "facebook";*/
    parameter['first_name'] = first;
    parameter['last_name'] = last;
    // parameter['profile_picture'] = imageUrl.toString();
    parameter['social_id'] = profile.userId.toString();
    print(parameter.toString());
    checkedValue = false;

    showLoadingSpinner(context, "Please wait...");
    final response= await API.socialLogin({ 'firstName':first,
      'lastName':last,
      'password': '',
      'confirmPassword': '',
      'userName': '',
      'countryCode': '',
      'phone': '',
      'dateOfBirth': '',
      'email': email.toString(),
      'promotionalEmail': 'true',
      'loginType': 'FACEBOOK',
      'socialId':profile.userId.toString(),
      'deviceToken': sharedPreferences!.getString("device_id"),
      'appType': 'ANDROID'});

    hideLoadingSpinner(context);

    if (response["STATUSCODE"] == 410) {
      // obtain shared preferences
      final prefs = await SharedPreferences.getInstance();
      // set value
      prefs.setString('uid', response["response_data"]["userId"]);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EnterCode(
                  onNext: () async {
                    await API.verifyUser(
                      response["response_data"]["userId"],
                    );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  code: response["response_data"]["otp"])));
    }
    else if (response["STATUSCODE"] == 200) {
      // obtain shared preferences
      final prefs = await SharedPreferences.getInstance();

      prefs.setString('userData', convert.jsonEncode(response["response_data"]));

      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
    else {
      ScaffoldMessenger.of(context)
          .showSnackBar((SnackBar(content: Text(response["message"]))));
    }
  }

  Future signIn() async {
    final user= await GoogleSignInApi.login();
    print('${user}');
    List<String> arr=user!.displayName!.split(" ");
    print(arr[2]);
    showLoadingSpinner(context, "Please wait...");
    final response= await API.socialLogin({ 'firstName': arr.length>0?arr[0]:'',
      'lastName': arr.length<2?arr[1]:arr.length>2?arr[2]:'',
      'password': '',
      'confirmPassword': '',
      'userName': '',
      'countryCode': '',
      'phone': '',
      'dateOfBirth': '',
      'email': user!.email,
      'promotionalEmail': 'true',
      'loginType': 'GOOGLE',
      'socialId':user!.id,
      'deviceToken': sharedPreferences!.getString("device_id"),
      'appType': 'ANDROID'});

    hideLoadingSpinner(context);

    if (response["STATUSCODE"] == 410) {
      // obtain shared preferences
      final prefs = await SharedPreferences.getInstance();
      // set value
      prefs.setString('uid', response["response_data"]["userId"]);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EnterCode(
                  onNext: () async {
                    await API.verifyUser(
                      response["response_data"]["userId"],
                    );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  code: response["response_data"]["otp"])));
    }
    else if (response["STATUSCODE"] == 200) {
      // obtain shared preferences
      final prefs = await SharedPreferences.getInstance();

      prefs.setString('userData', convert.jsonEncode(response["response_data"]));

      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
    else {
      ScaffoldMessenger.of(context)
          .showSnackBar((SnackBar(content: Text(response["message"]))));
    }


  }


  @override
  Widget build(BuildContext context) {
    onSubmit() async {
      if (_formKey.currentState!.validate()) {
        showLoadingSpinner(context, "Please wait...");
        final response = await API.login(_emailController.text, _passwordController.text);
        hideLoadingSpinner(context);

        if (response["STATUSCODE"] == 410) {
          // obtain shared preferences
          final prefs = await SharedPreferences.getInstance();
          // set value
          prefs.setString('uid', response["response_data"]["userId"]);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EnterCode(
                      onNext: () async {
                        await API.verifyUser(
                          response["response_data"]["userId"],
                        );
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      code: response["response_data"]["otp"])));
        }
         else if (response["STATUSCODE"] == 200) {
          // obtain shared preferences
          final prefs = await SharedPreferences.getInstance();

          prefs.setString('userData', convert.jsonEncode(response["response_data"]));

          Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
        }
         else {
          ScaffoldMessenger.of(context)
              .showSnackBar((SnackBar(content: Text(response["message"]))));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            content: Text("Please correct errors and submit again"))));
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0), // here the desired height
        child: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {  Navigator.of(context,rootNavigator: true).pop();   },
          ),
          centerTitle: true,
          title: Text(
            'Sign In',
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
        ),
      ),
      body: Form(
        //autovalidate: true,
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 55,
            ),
            Text(
              'StockSocial',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Color(0XFFFFFFFF),
                fontSize: 34,
                fontWeight: FontWeight.w900,
                height: (43 / 36),
                fontFamily: "Roboto",
              ),
            ),

            Padding(
                padding: const EdgeInsets.only(top:5, bottom: 20),
                child: Center(
                  child:  Text("Also you can sign in with",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: (15 / 12),
                      fontFamily: "Roboto",
                    ),
                  ),
                )
            ),

            Padding(
              padding: const EdgeInsets.only( bottom: 20),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    InkWell(
                      onTap:()=>FacebookloginClick(),
                      child: Container(
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage("assets/images/facebook_logo.png"),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: InkWell(
                        onTap: () {
                           signIn();
                        },
                        child: Container(
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage("assets/images/google_logo.png"),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage("assets/images/apple_logo.png"),
                      ),
                    )


                  ],
                ),
              ),
            ),

            Expanded(
              child: Container(
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
                  padding: const EdgeInsets.all(24.0),
                  child: ListView(
                    children: [

                      Padding(
                          padding: const EdgeInsets.only( bottom: 10),
                          child: Center(
                            child:  Text("Please sign in details for continue",
                              style: TextStyle(
                                color:Color(0XFFFFb0b0b0),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: (15 / 12),
                                fontFamily: "Roboto",
                              ),
                            ),
                          )
                      ),

                      Padding(
                        padding:const EdgeInsets.only(left: 16, right: 16,),
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
                            if (value!.isEmpty) {
                              return 'Please enter a Email / Username';
                            }
                            // if (!RegExp(
                            //   r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
                            // ).hasMatch(value)) {
                            //   return 'Please enter a valid email';
                            // }
                            // return null;
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 16),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: !_passwordVisible ? true : false,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            suffixIcon: IconButton(
                                iconSize: 18,
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: Icon(_passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Color(0XFF9D9D9D),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: (15 / 12),
                              fontFamily: "Roboto",
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 37,
                      ),
                      MyMaterialButton(
                        tittle: 'Sign In',
                        onTap: onSubmit,
                      ),
                      SizedBox(     height: 15,    ),

                      Center(
                        child: FlatButton(
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Color(0XFF9D9D9D),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: (17 / 12),
                              fontFamily: "Roboto",
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                        ),
                      ),
                     // SizedBox( height: 10,  ),

                      /*Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Center(
                            child:  Text("or",
                              style: TextStyle(
                                color: Color(0XFF9D9D9D),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: (15 / 12),
                                fontFamily: "Roboto",
                              ),
                            ),
                          )
                      ),

                      Padding(
                          padding: const EdgeInsets.only( bottom: 24),
                          child: Center(
                            child:  Text("Sign in with",
                              style: TextStyle(
                                color: Color(0XFF9D9D9D),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                height: (15 / 12),
                                fontFamily: "Roboto",
                              ),
                            ),
                          )
                      ),


                      Padding(
                        padding: const EdgeInsets.only( bottom: 24),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [


                              Container(
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage("assets/images/facebook_logo.png"),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 10,right: 10),
                                child: Container(
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.white,
                                    backgroundImage: AssetImage("assets/images/google_logo.png"),
                                  ),
                                ),
                              ),

                              Container(
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage("assets/images/apple_logo.png"),
                                ),
                              )


                            ],
                          ),
                        ),
                      ),*/

                      Container(
                        margin: EdgeInsets.only(top:30,bottom: 10),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                                text: 'Don’t have an account ? ',
                                style: TextStyle(
                                  color: Color(0XFF9D9D9D),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  height: (17 / 12),
                                  fontFamily: "Roboto",
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Sign Up',
                                      style: TextStyle(
                                        color: Color(0XFF9D9D9D),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        height: (17 / 12),
                                        fontFamily: "Roboto",
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignUp()));
                                        })
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
