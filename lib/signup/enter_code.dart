import 'package:flutter/material.dart';
import 'package:stock_social/widgets/my_material_button.dart';

class EnterCode extends StatefulWidget {
  final String code;
  final Function? onNext;

  const EnterCode({
    Key? key,
    required this.code,
    this.onNext,
  }) : super(key: key);

  @override
  _EnterCodeState createState() => _EnterCodeState();
}

class _EnterCodeState extends State<EnterCode> {
  final _codeController = TextEditingController();

  onSubmit() async {
    if (widget.code == _codeController.text) {
      if (widget.onNext == null) {
       Navigator.pop(context, true);
      } else {
        widget.onNext!();
      }
      
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar((SnackBar(content: Text("Invalid OTP"))));
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
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24, top: 24),
                      child: Text(
                        'Enter the code sent to your email',
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
                          const EdgeInsets.only(left: 16, right: 16, top: 20),
                      child: TextFormField(
                        controller: _codeController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter code',
                           labelStyle: TextStyle(
                             color: Color(0XFF9D9D9D),
                             fontSize: 12,
                             fontWeight: FontWeight.w400,
                             height: (15 / 12),
                             fontFamily: "Roboto",
                           ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyMaterialButton(
                          width: 170,
                          tittle: ' Continue',
                          onTap: onSubmit,
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
