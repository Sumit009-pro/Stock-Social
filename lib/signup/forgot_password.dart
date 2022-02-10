import 'package:flutter/material.dart';
import 'package:stock_social/signup/enter_code.dart';
import 'package:stock_social/signup/reset_password.dart';
import 'package:stock_social/widgets/loading_spinner.dart';
import 'package:stock_social/widgets/my_material_button.dart';

import '../models/api.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  onSubmit() async {
    if (_formKey.currentState!.validate()) {
      showLoadingSpinner(context, "Please wait...");
      final response =
          await API.forgotPassword({"email": _emailController.text});
      hideLoadingSpinner(context);

      if (response["STATUSCODE"] == 200) {
        // obtain shared preferences
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EnterCode(
                    onNext: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ResetPassword(email: _emailController.text)));
                    },
                    code: response["response_data"]["forgotPassOtp"])));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar((SnackBar(content: Text(response["message"]))));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          (SnackBar(content: Text("Please correct errors and submit again"))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            SizedBox(
              height: 75,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24, top: 24),
                        child: Text(
                          'Find your StockSocial account',
                          style: TextStyle(
                            color:Color(0XFFFFb0b0b0),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            height: (22 / 18),
                            fontFamily: "Roboto",
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 22),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter your email',
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
                        height: 37,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MyMaterialButton(
                              width: 170, tittle: ' Search', onTap: onSubmit),
                        ],
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
