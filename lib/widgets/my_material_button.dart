import 'package:flutter/material.dart';

class MyMaterialButton extends StatelessWidget {
  final String tittle;
  final VoidCallback onTap;
  final double height;
  final double width;

  const MyMaterialButton({
    Key? key,
    required this.tittle,
    required this.onTap,
    this.height = 48.0,
    this.width = 270.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color:Color(0XFFFE99AC)
          /*  gradient: LinearGradient(
              colors: [
                Color(0XFF35DCFC),
                Color(0XFF7373EF),
              ],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
            )*/
        ),
        child: Center(
          child: Text(
            tittle,
            style: TextStyle(
              color: Color(0XFFFFFFFF),
              fontSize: 14,
              fontWeight: FontWeight.w700,
              height: (17 / 14),
              fontFamily: "Roboto",
            ),
          ),
        ),
      ),
    );
  }
}
