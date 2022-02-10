/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_social/api.dart';
import 'package:stock_social/home.dart';
import 'package:stock_social/signup/enter_code.dart';
import 'package:stock_social/widgets/loading_spinner.dart';

class Preferences extends StatefulWidget {
  final Map<String, dynamic> signUpData;
  const Preferences({Key? key, required this.signUpData}) : super(key: key);

  @override
  _PreferencesState createState() => _PreferencesState();
}


class _PreferencesState extends State<Preferences> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _phonenumberController = TextEditingController();
  final _dobController = TextEditingController();

  // String? validateMobile(String value) {
  //   String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  //   RegExp regExp = new RegExp(patttern);
  //   if (value.length == 0) {
  //     return 'Please enter mobile number';
  //   } else if (!regExp.hasMatch(value)) {
  //     return 'Please enter valid mobile number';
  //   }
  //   return null;
  // }


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

  onSubmit({bool skipped = false}) async {
    if (skipped || _formKey.currentState!.validate()) {
      if (!skipped) {
        widget.signUpData.addEntries(<String, dynamic>{
          "userName": _usernameController.text,
          "phone": _phonenumberController.text,
          "dateOfBirth": DateFormat("dd/MM/y").format(currentDate),
        }.entries);
      }

      showLoadingSpinner(context, "Please wait...");
      final response = await API.register(widget.signUpData);
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
                        },
                        code: response["response_data"]["otp"])));
      }
      else    ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text(response["message"]))));
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          content: Text("Please correct errors and submit again",
            style: TextStyle(color: Colors.white),
          ))));
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
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            'Preferences',
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
        key: _formKey,
        child: ListView(
          children: [
            Container(
              margin:
              EdgeInsets.only(left: 16, right: 16, top: 100, bottom: 100),
              //width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              child: Column(
                children: [

                  Padding(
                    padding:
                    const EdgeInsets.only(left: 24, right: 24, top: 16),
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

                  Padding(
                    padding:
                    const EdgeInsets.only(left: 24, right: 24, top: 16),
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

                  SizedBox(   height: 37,    ),

                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: onSubmit,
                          child: Container(
                            height: 48,
                            width: 170,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30)),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0XFF35DCFC),
                                    Color(0XFF7373EF),
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight,
                                )),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Continue',
                                    style: TextStyle(
                                      color: Color(0XFFFFFFFF),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      height: (17 / 14),
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_right_alt_outlined,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 42,
                  ),
                  Center(
                    child: FlatButton(
                      child: Text(
                        'Skip for now',
                        style: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: (17 / 12),
                          fontFamily: "Roboto",
                        ),
                      ),
                      onPressed: () => onSubmit(skipped: true),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
*/
