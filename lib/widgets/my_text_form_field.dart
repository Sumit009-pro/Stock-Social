import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  //final Widget icon;
  final String labelText;
  //final String prefixText;
  final FormFieldSetter<String> onSaved;
  //final List<TextInputFormatter> inputFormatters;
  final FormFieldValidator<String> validator;
  //final TextInputType keyboardType;
  //final String initialValue;
  final TextCapitalization textCapitalization;
  //final TextEditingController controller;
  //final bool enabled;

  MyTextFormField(
      {
      // required this.icon,
      // required this.enabled,
      // required this.controller,
      required this.labelText,
      // required this.prefixText,
      // required this.initialValue,
      required this.onSaved,
      //required this.inputFormatters,
      required this.validator,
      //required this.keyboardType,
      required this.textCapitalization});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: new TextFormField(
        //enabled: enabled,
        //controller: controller,
        //keyboardType: keyboardType, //TextInputType.phone,
        //initialValue: initialValue, //widget.phoneNumber,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          //icon: icon, //Image.asset('assets/drawable/icon_phone.png'),
          //prefixText: prefixText, //'$phoneNumberPrefix ',
          labelText: labelText, //'Phone Number *',
          labelStyle: TextStyle(
            color: Color(0XFF9D9D9D),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: (15 / 12),
            fontFamily: "Roboto",
          ),
          // enabledBorder: UnderlineInputBorder(
          //     borderSide: BorderSide(
          //   color: Color(0xffeaeaec),
          //   width: 2.0,
          // ))
        ),
        // enabledBorder: InputBorder.none,
        // // UnderlineInputBorder(
        // //     borderSide: BorderSide(
        // //   color: Color(0xffeaeaec),
        // //   width: 2.0,
        // // ))
        // ),
        onSaved: onSaved,
        validator: validator, //_validateNumber,
        //inputFormatters: inputFormatters,
        // style: TextStyle(
        //     letterSpacing: 0.88,
        //     fontSize: 14.0,
        //     fontWeight: FontWeight.w500,
        //     color: const Color(0xff282c3f)),
      ),
    );
  }
}
