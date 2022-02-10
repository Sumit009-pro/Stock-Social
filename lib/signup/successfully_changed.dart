import 'package:flutter/material.dart';
import 'package:stock_social/home.dart';
import 'package:stock_social/widgets/my_material_button.dart';

class SuccessfullyChanged extends StatefulWidget {
  const SuccessfullyChanged({Key? key}) : super(key: key);

  @override
  _SuccessfullyChangedState createState() => _SuccessfullyChangedState();
}

class _SuccessfullyChangedState extends State<SuccessfullyChanged> {
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
                        'You’ve successfully changed your password.',
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
                      height: 37,
                    ),
                    Center(
                      child: MyMaterialButton(
                        width: 307,
                        tittle: ' Continue to StockSocial',
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                      ),
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
