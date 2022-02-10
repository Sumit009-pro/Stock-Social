import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class MySwitchListTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  const MySwitchListTile(
      {Key? key,
      required this.title,
      required this.value,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Padding(
            padding: const EdgeInsets.only(left: 24,right: 24,top:15,bottom: 15 ),
            child:Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Container(
                    child:Text(
                      '$title',
                      style: TextStyle(
                        color: Color(0XFFFFb0b0b0),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: (16 / 14),
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),

                  FlutterSwitch(
                    width: 40.0,
                    height: 20.0,
                    // valueFontSize: 12.0,
                    activeColor: Color(0XFFFE99AC),
                    toggleSize: 18.0,
                    inactiveColor:  Color(0XFFffe6ea),
                    value: value,
                    onToggle:onChanged
                  ),
                ],
              ),
            )
        ),

        Divider( color: Color(0XFF9D9D9D), ),

        /* Padding(
          padding: const EdgeInsets.only(
            left: 8,
          ),
          child: SwitchListTile(
            activeColor: Color(0XFF1EDCC5),
            title: Text(
              title,
              style: TextStyle(
                color: Color(0XFF808080),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: (16 / 14),
                fontFamily: "Roboto",
              ),
            ),
            value: value,
            onChanged: onChanged,
          ),
        ),*/

      ],
    );
  }
}
