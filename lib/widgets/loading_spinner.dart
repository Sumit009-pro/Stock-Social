import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void showLoadingSpinner(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => new Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height/6,
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              child:SpinKitWanderingCubes(
                color: Color(0XFFFE99AC)
              )
            )

          /*  SizedBox( height: 20.0, width: 20.0, child: CircularProgressIndicator()),
            SizedBox(width: 10.0),
            Text(text),*/

          ],
        ),
      ),
    ),
  );
}

void hideLoadingSpinner(BuildContext context) {
  Navigator.of(context).pop();
}
