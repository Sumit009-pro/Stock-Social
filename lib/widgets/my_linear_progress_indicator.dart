/*
import 'package:flutter/material.dart';

class MyLinearProgressIndicator extends StatelessWidget {
  final String title;
  final double value;
  final Color valueColor;
  final Color backgroundColor;

  const MyLinearProgressIndicator(
      {Key? key,
      required this.title,
      required this.value,
      required this.valueColor,
      required this.backgroundColor })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color(0XFFB0B0B0),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: (17 / 12),
            fontFamily: "Roboto",
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Container(
          width: 90,
          child: LinearProgressIndicator(
            backgroundColor: this.backgroundColor,
            valueColor: new AlwaysStoppedAnimation<Color>(this.valueColor),
            value: this.value,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          '${(this.value * 100).round()}%',
          style: TextStyle(
            color: Color(0XFFB0B0B0),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: (17 / 12),
            fontFamily: "Roboto",
          ),
        ),
      ],
    );
  }
}
*/
