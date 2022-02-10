import 'package:flutter/material.dart';

class MyProgressIndicator extends StatefulWidget {
  final value; //low=1, medium=2, high=3
  final Color? progressColor;
  final Color? backgroundColor;
  final int? activity; //Engagement=1, Total Post=2, Question=3
  final double? height;
  final double? width;
  const MyProgressIndicator({Key? key,this.value,this.activity,this.backgroundColor,this.progressColor,
  this.height,this.width}) : super(key: key);

  @override
  _MyProgressIndicatorState createState() => _MyProgressIndicatorState();
}

class _MyProgressIndicatorState extends State<MyProgressIndicator> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.activity==1
       ?Container(
        width: widget.width,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            Visibility(
              visible:true,
              child: Container(
                  height: widget.height,
                  color: widget.progressColor,
                  width: widget.value! ==1
                      ? widget.width!*0.30
                      : widget.value! ==2
                      ? widget.width!*0.60
                      : widget.width
              ),
            ),

            Visibility(
              visible: widget.value! ==3 ? false : true,
              child: Expanded(
                child: Container(
                  height: widget.height,
                  color: widget.backgroundColor,
                ),
              ),
            ),

          ],
        ),
      )
       :widget.activity==2
              ?Container(
                     width: widget.width,
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [

                         Visibility(
                           visible: widget.value! ==0 ? false : true,
                           child: Container(
                             height: widget.height,
                             color: widget.progressColor,
                             width: widget.value! <=200
                                 ? widget.width!*0.30
                                 : widget.value! >200 && widget.value! <=500
                                       ? widget.width!*0.60
                                       : widget.width!*0.90
                           ),
                         ),

                         Expanded(
                           child: Container(
                             height: widget.height,
                             color: widget.backgroundColor,
                           ),
                         ),

                       ],
                     ),
              )
             :Container(
                  width: widget.width,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Visibility(
                        visible: widget.value! ==0 ? false : true,
                        child: Container(
                            height: widget.height,
                            color: widget.progressColor,
                            width: widget.value! <=150
                                ? widget.width!*0.30
                                : widget.value! >150 && widget.value! <=350
                                ? widget.width!*0.60
                                : widget.width!*0.90
                        ),
                      ),

                      Expanded(
                        child: Container(
                          height: widget.height,
                          color: widget.backgroundColor,
                        ),
                      ),

                    ],
                  ),
                ),
    );
  }
}
