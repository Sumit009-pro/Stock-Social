import 'package:flutter/material.dart';
import 'package:stock_social/signup/enter_code.dart';
import 'package:stock_social/widgets/my_material_button.dart';

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    Key? key,
    required this.label,
    required this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final Widget label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<bool>(
              groupValue: groupValue,
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue);
              },
            ),
            label,
          ],
        ),
      ),
    );
  }
}

class ResetLink extends StatefulWidget {
  const ResetLink({Key? key}) : super(key: key);

  @override
  _ResetLinkState createState() => _ResetLinkState();
}

class _ResetLinkState extends State<ResetLink> {
  bool _isPhoneNumberRadioSelected = false;
  bool _isGmailRadioSelected = false;

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
      body: Column(
        children: [
          SizedBox(
            height: 55,
          ),
          Text(
            'StockSocial',
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Color(0XFFFFFFFF),
              fontSize: 36,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      height: 12,
                    ),
                    Column(
                      children: <LabeledRadio>[
                        LabeledRadio(
                          label: RichText(
                            text: TextSpan(
                                text:
                                    'Text a code to the phone number ending in  ',
                                style: TextStyle(
                                  color: Color(0XFF808080),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: (17 / 12),
                                  fontFamily: "Roboto",
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '79',
                                    style: TextStyle(
                                      color: Color(0XFF808080),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      height: (17 / 12),
                                      fontFamily: "Roboto",
                                    ),
                                  )
                                ]),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          value: true,
                          groupValue: _isPhoneNumberRadioSelected,
                          onChanged: (bool newValue) {
                            setState(() {
                              _isPhoneNumberRadioSelected = newValue;
                            });
                          },
                        ),
                        LabeledRadio(
                          label: RichText(
                            text: TextSpan(
                                text: 'Send an email to',
                                style: TextStyle(
                                  color: Color(0XFF808080),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: (17 / 12),
                                  fontFamily: "Roboto",
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' loremipsum@gmail.com',
                                    style: TextStyle(
                                      color: Color(0XFF808080),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      height: (17 / 12),
                                      fontFamily: "Roboto",
                                    ),
                                  )
                                ]),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          value: true,
                          groupValue: _isGmailRadioSelected,
                          onChanged: (bool newValue) {
                            setState(() {
                              _isGmailRadioSelected = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 37,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyMaterialButton(
                          width: 170,
                          tittle: ' Send',
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => EnterCode(
                            //               code: "",
                            //             )));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
