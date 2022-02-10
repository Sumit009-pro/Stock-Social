import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_social/models/api.dart';
import 'package:stock_social/home.dart';
import 'package:stock_social/signup/enter_code.dart';
import 'package:stock_social/signup/sign_in.dart';
import 'package:stock_social/social/google_signin_api.dart';
import 'package:stock_social/widgets/loading_spinner.dart';
import 'package:stock_social/widgets/my_material_button.dart';
import 'dart:convert' as convert;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _promotionalEmail = true;

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phonenumberController = TextEditingController();
  TextEditingController _dobController = TextEditingController();


  DateTime currentDate = DateTime.now().subtract(Duration(days: 365 * 19));

  Future<void> _selectDate(BuildContext context) async {
    final year = DateTime
        .now()
        .year;

    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(year - 100),
        lastDate: DateTime(year - 18));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        _dobController.text = DateFormat("dd/MM/y").format(currentDate);
      });
  }
  Future signIn() async {
    final user= await GoogleSignInApi.login();
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
      'deviceToken': '1234',
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
  // String? validateEmail(String value) {
  //   Pattern pattern =
  //       r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
  //       r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
  //       r"{0,253}[a-zA-Z0-9])?)*$";
  //   RegExp regex = new RegExp(pattern);
  //   if (!regex.hasMatch(value) || value == null)
  //     return 'Enter a valid email address';
  //   else
  //     return null;
  // }

  onSubmit() async{
    if (_formKey.currentState!.validate()) {

      showLoadingSpinner(context, "Please wait...");
      final response = await API.register(
          {
            "firstName": _firstNameController.text,
            "lastName":_lastNameController.text,
            "email": _emailController.text,
            "password": _passwordController.text,
            "confirmPassword": _confirmPasswordController.text,
            "promotionalEmail": _promotionalEmail.toString(),
            "userName": _usernameController.text,
            "phone": _phonenumberController.text,
            "dateOfBirth": DateFormat("dd/MM/y").format(currentDate),
          }
      );
      hideLoadingSpinner(context);

            if (response["STATUSCODE"] == 410) {
              // obtain shared preferences
              final prefs = await SharedPreferences.getInstance();
              // set value
              prefs.setString('uid', response["response_data"]["userId"]);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EnterCode(onNext: () async {
                            await API.verifyUser(response["response_data"]["userId"],);
                            Navigator.push(context,MaterialPageRoute(builder: (context) => Home()));
                          },code: response["response_data"]["otp"])));
            }
            else    ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text(response["message"]))));
    }
    else   ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text("Please correct errors and submit again"))));

  }

  @override
  Widget build(BuildContext context) {
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
            'Sign Up',
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
        //autovalidate: false,
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 30,
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


                    Container(
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage("assets/images/facebook_logo.png"),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: InkWell(
                        onTap:() {
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
                  padding: const EdgeInsets.all(24.0),
                  child: ListView(
                    children: [
                      // MyTextFormField(
                      //     labelText: 'Name',
                      //     validator: (value) {
                      //       if (value == null || value.isEmpty) {
                      //         return 'Please enter a name';
                      //       }
                      //       return null;
                      //     },
                      //     onSaved: (value) {
                      //       _name = value!;
                      //     },
                      //     textCapitalization: TextCapitalization.words),

                      Padding(
                          padding: const EdgeInsets.only( bottom: 10),
                          child: Center(
                            child:  Text("Please enter your details for sign up",
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'First Name',
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
                              return 'Please enter a name';
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Last Name',
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
                              return 'Please enter a name';
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),

                      Padding(
                        padding:const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                              return 'Please enter a mail';
                            }
                            if (!RegExp(
                              r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
                            ).hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding:const EdgeInsets.only(left: 10, right: 10, top: 10),
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

                      Padding(
                        padding:const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: !_confirmPasswordVisible ? true : false,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            suffixIcon: IconButton(
                                iconSize: 18,
                                onPressed: () {
                                  setState(() {
                                    _confirmPasswordVisible =
                                        !_confirmPasswordVisible;
                                  });
                                },
                                icon: Icon(_confirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            labelText: 'Confirm password',
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
                              return 'Please re-enter password';
                            }
                            if (_passwordController.text !=
                                _confirmPasswordController.text) {
                              return "Password does not match";
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding:const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Username',
                            labelStyle: TextStyle(
                              color: Color(0XFF9D9D9D),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: (15 / 12),
                              fontFamily: "Roboto",
                            ),
                          ),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter a username';
                          //   }
                          //   return null;
                          // },
                        ),
                      ),

                      /*Padding(
                          padding:const EdgeInsets.only(left: 10, right: 10, top: 10),
                           child: TextFormField(
                             controller: _phonenumberController,
                             decoration: InputDecoration(
                               border: UnderlineInputBorder(),
                               labelText: 'Phone Number',
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
                                 return 'Please enter mobile number';
                               }
                               if (!RegExp("^(?:[+0]9)?[0-9]{10,12}")
                                   .hasMatch(value)) {
                                 return 'Please enter a valid phone number';
                                }
                               return null;
                             },
                             keyboardType: TextInputType.number,
                           ),
                      ),*/

                      Padding(
                        padding:const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: TextFormField(
                          controller: _dobController,
                          onTap: () => _selectDate(context),
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.calendar_today_rounded,
                              size: 18,
                            ),
                            border: UnderlineInputBorder(),
                            labelText: 'Date of birth',
                            labelStyle: TextStyle(
                              color: Color(0XFF9D9D9D),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: (15 / 12),
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      CheckboxListTile(
                        title: Text(
                          "I would like to receive your newsletter and other promotional information.",
                          style: TextStyle(
                            color: Color(0XFF9D9D9D),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: (15 / 12),
                            fontFamily: "Roboto",
                          ),
                        ),
                        value: _promotionalEmail,
                        activeColor:Color(0XFFFE99AC) ,
                        onChanged: (newValue) {
                          setState(() {
                            _promotionalEmail = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),

                      SizedBox( height: 26, ),

                      MyMaterialButton(
                        tittle: "Sign Up",
                        onTap: onSubmit,
                      ),

                     /* Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 16),
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
*/

                      Padding(
                          padding: const EdgeInsets.only(top:30,bottom: 16),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                  text: 'Already have an account ? ',
                                  style: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    height: (17 / 12),
                                    fontFamily: "Roboto",
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Sign In',
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
                                                        SignIn()));
                                          })
                                  ]),
                            ),
                          )
                      )


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
