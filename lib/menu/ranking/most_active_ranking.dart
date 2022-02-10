import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MostActiveRanking extends StatefulWidget {
  const MostActiveRanking({Key? key}) : super(key: key);

  @override
  _MostActiveRankingState createState() => _MostActiveRankingState();
}

class _MostActiveRankingState extends State<MostActiveRanking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
            children: [

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(

              leading: Container(
                child:Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Container(
                      child: Text(
                        '1',
                        style: TextStyle(
                          color: Color(0XFFFFb0b0b0),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          height: (22 / 18),
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),

                    SizedBox(width: 10,),

                    Container(
                      child: CircleAvatar(
                        backgroundColor: Color(0XFFF1F1F1),
                        //   child: const Text('SK'),
                      ),
                    ),

                  ],
                )
              ),
              title: Text(
                'Lorem Ipsum',
                style: TextStyle(
                  color: Color(0XFFFFb0b0b0),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  height: (22 / 18),
                  fontFamily: "Roboto",
                ),
              ),
            /*  subtitle: Text(
                'Lorem Ipsum Sent you a message, please reply...',
                style: TextStyle(
                  color: Color(0XFF9D9D9D),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: (16 / 14),
                  fontFamily: "Roboto",
                ),
              ),*/
              trailing: Icon(Icons.chevron_right,color: Color(0XFFFFb0b0b0),),
            ),
          ),

          Divider(),

              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListTile(

                  leading: Container(
                      child:Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Container(
                            child: Text(
                              '2',
                              style: TextStyle(
                                color: Color(0XFFFFb0b0b0),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: (22 / 18),
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),

                          SizedBox(width: 10,),

                          Container(
                            child: CircleAvatar(
                              backgroundColor: Color(0XFFF1F1F1),
                              //   child: const Text('SK'),
                            ),
                          ),

                        ],
                      )
                  ),
                  title: Text(
                    'Lorem Ipsum',
                    style: TextStyle(
                      color: Color(0XFFFFb0b0b0),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      height: (22 / 18),
                      fontFamily: "Roboto",
                    ),
                  ),
                  /*  subtitle: Text(
                'Lorem Ipsum Sent you a message, please reply...',
                style: TextStyle(
                  color: Color(0XFF9D9D9D),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: (16 / 14),
                  fontFamily: "Roboto",
                ),
              ),*/
                  trailing: Icon(Icons.chevron_right,color: Color(0XFFFFb0b0b0),),
                ),
              ),

              Divider()

            ]
        ),
      ),
    );
  }
}
