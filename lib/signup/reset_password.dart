import 'package:flutter/material.dart';
import 'package:stock_social/models/api.dart';
import 'package:stock_social/signup/sign_in.dart';
import 'package:stock_social/widgets/loading_spinner.dart';
import 'package:stock_social/widgets/my_material_button.dart';

class ResetPassword extends StatefulWidget {
  final String email;
  const ResetPassword({Key? key, required this.email}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _checkboxValue = false;

  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  onSubmit() async {
    if (_formKey.currentState!.validate()) {
      showLoadingSpinner(context, "Updating password...");

      final response = await API.resetPassword({
        "email": widget.email,
        "password": _passwordController.text,
        "confirmPassword": _confirmPasswordController.text,
        "deviceToken": "124",
        "appType": "IOS"
      });

      hideLoadingSpinner(context);

      if (response["STATUSCODE"] == 200) {
        // obtain shared preferences
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignIn()));
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
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24, top: 24),
                        child: Text(
                          'How do you want to reset your password?',
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
                        height: 18,
                      ),
                      // ListTile(
                      //   leading: CircleAvatar(
                      //     backgroundColor: Color(0XFFE5E5E5),
                      //     child: const Text('SK'),
                      //   ),
                      //   title: Text(
                      //     'Profile Name',
                      //     style: TextStyle(
                      //       color: Color(0XFF808080),
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w500,
                      //       height: (17 / 14),
                      //       fontFamily: "Roboto",
                      //     ),
                      //   ),
                      //   subtitle: Text(
                      //     'profilename@info.com',
                      //     style: TextStyle(
                      //       color: Color(0XFF9D9D9D),
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w400,
                      //       height: (17 / 14),
                      //       fontFamily: "Roboto",
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18),
                        child: Text(
                          'Strong passwords include numbers, letters, and punctuation marks.',
                          style: TextStyle(
                            color: Color(0XFF9D9D9D),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: (17 / 14),
                            fontFamily: "Roboto",
                          ),
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
                            labelText: 'Enter new password',
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
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 16),
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
                            labelText: 'Confirm new password',
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
                        height: 24,
                      ),
                      // CheckboxListTile(
                      //   title: Text(
                      //     "Remember me",
                      //     style: TextStyle(
                      //       color: Color(0XFF808080),
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w400,
                      //       height: (15 / 12),
                      //       fontFamily: "Roboto",
                      //     ),
                      //   ),
                      //   value: _checkboxValue,
                      //   onChanged: (newValue) {
                      //     setState(() {
                      //       _checkboxValue = newValue!;
                      //     });
                      //   },
                      //   controlAffinity: ListTileControlAffinity
                      //       .leading, //  <-- leading Checkbox
                      // ),
                      SizedBox(
                        height: 24,
                      ),
                      MyMaterialButton(
                        tittle: ' Reset password',
                        onTap: onSubmit,
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
