import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stock_social/home.dart';
import 'package:stock_social/signup/sign_in.dart';
import 'package:stock_social/signup/sign_up.dart';

import 'package:outline_gradient_button/outline_gradient_button.dart';

import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:stock_social/widgets/my_material_button.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
          ),
          GradientText(
            'StockSocial',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w900,
              height: (47 / 40),
              fontFamily: "Roboto",
            ),
            colors: [
              Color(0XFFFE99AC),
              Color(0XFFfecdd6),

            ],
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            'Discover the new place of stock market',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0XFF9D9D9D),
              fontSize: 14,
              fontWeight: FontWeight.w300,
              height: (17 / 14),
              fontFamily: "Roboto",
            ),
          ),
          SizedBox(
            height: 108,
          ),
          MyMaterialButton(
              tittle: "Get Started",
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              }),
          SizedBox(
            height: 24,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignIn()),
              );
            },
            child: Container(
              height: 48,
              width: 270,
              child: OutlineGradientButton(
                child: Center(
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: Color(0XFFFE99AC),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: (17 / 14),
                      fontFamily: "Roboto",
                    ),
                  ),
                ),
                gradient: LinearGradient(colors: [
                  Color(0XFFFE99AC),
                  Color(0XFFfecdd6),
                ]),
                strokeWidth: 2,
                radius: Radius.circular(30),
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          RichText(
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
                        fontWeight: FontWeight.w400,
                        height: (17 / 12),
                        fontFamily: "Roboto",
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        })
                ]),
          ),
          SizedBox(
            height: 24,
          ),
          Center(
            child: FlatButton(
              child: Text(
                '',
                style: TextStyle(
                  color: Color(0XFF9D9D9D),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: (17 / 12),
                  fontFamily: "Roboto",
                ),
              ),
              onPressed: () {
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
