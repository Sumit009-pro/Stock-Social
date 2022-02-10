import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrivateRoom extends StatefulWidget {
  final Function(bool) scrollScreen;

  const PrivateRoom({Key? key,required this.scrollScreen}) : super(key: key);

  @override
  _PrivateRoomState createState() => _PrivateRoomState();
}

class _PrivateRoomState extends State<PrivateRoom> {

  ScrollController? scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController=new ScrollController()..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      controller: scrollController,
      children: [

        Padding(
          padding: EdgeInsets.only(left: 16,right: 16),
          child: Container(
            child: TextField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Color(0XFFFFFFFF), width: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Color(0XFFFFFFFF), width: 0.5),
                ),
                filled: true,
                fillColor:Color(0XFFFFf2f2f2),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[400],
                  size: 20,
                ),
                hintText: 'Search for rooms',
                hintStyle: TextStyle(
                    color: Color(0XFF9D9D9D),
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              cursorWidth: 1,
              maxLines: 1,
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Card(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height/5.5,
              child: Row(
                children: [

                  Container(
                      width: MediaQuery.of(context).size.width/3.7,
                      decoration: BoxDecoration(
                        color:Color(0XFFffe6ea),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child:Column(
                        children: [

                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0XFFFFb0b0b0),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  )
                              ),
                            ),
                          ),

                          Container(
                            height: MediaQuery.of(context).size.height/15,
                            child: Center(
                                child: Text(
                                  'Joined : 132',
                                  style: TextStyle(
                                      color: Color(0XFF9D9D9D),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                            ),
                          ),

                        ],
                      )
                  ),

                  SizedBox( width: 7, ),

                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Flexible(
                                  child: Container(
                                    child: Text(
                                      'Lorem Ipsum',
                                      maxLines: 2,overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color(0XFF808080),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        height: (17 / 14),
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 10),

                                Container(
                                  height:  MediaQuery.of(context).size.height/22,
                                  width: MediaQuery.of(context).size.width/5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      color:Color(0XFFFE99AC)
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Join +',
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
                              ],
                            ),
                          ),

                          SizedBox( height: 4, ),

                          Container(
                            child: Text(
                              'Topics : Dummy Text, example.',
                              maxLines: 2,overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0XFF9D9D9D),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: (14 / 12),
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),

                          SizedBox( height: 4, ),

                          Container(
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                              maxLines: 3,overflow: TextOverflow.ellipsis,style: TextStyle(
                              color: Color(0XFF9D9D9D),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: (14 / 12),
                              fontFamily: "Roboto",
                            ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),


        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16,bottom: 16),
          child: Card(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height/5.5,
              child: Row(
                children: [

                  Container(
                      width: MediaQuery.of(context).size.width/3.7,
                      decoration: BoxDecoration(
                        color:Color(0XFFffe6ea),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child:Column(
                        children: [

                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0XFFFFb0b0b0),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  )
                              ),
                            ),
                          ),

                          Container(
                            height: MediaQuery.of(context).size.height/15,
                            child: Center(
                                child: Text(
                                  'Joined : 132',
                                  style: TextStyle(
                                      color: Color(0XFF9D9D9D),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                            ),
                          ),

                        ],
                      )
                  ),

                  SizedBox( width: 7, ),

                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Flexible(
                                  child: Container(
                                    child: Text(
                                      'Lorem Ipsum',
                                      maxLines: 2,overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color(0XFF808080),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        height: (17 / 14),
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 10),

                                Container(
                                  height:  MediaQuery.of(context).size.height/22,
                                  width: MediaQuery.of(context).size.width/5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      color:Color(0XFFffe6ea)
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Joined',
                                      style: TextStyle(
                                        color: Color(0XFF9D9D9D),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        height: (17 / 14),
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox( height: 4, ),

                          Container(
                            child: Text(
                              'Topics : Dummy Text, example.',
                              maxLines: 2,overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0XFF9D9D9D),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: (14 / 12),
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),

                          SizedBox( height: 4, ),

                          Container(
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                              maxLines: 3,overflow: TextOverflow.ellipsis,style: TextStyle(
                              color: Color(0XFF9D9D9D),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: (14 / 12),
                              fontFamily: "Roboto",
                            ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16,bottom: 16),
          child: Card(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height/5.5,
              child: Row(
                children: [

                  Container(
                      width: MediaQuery.of(context).size.width/3.7,
                      decoration: BoxDecoration(
                        color:Color(0XFFffe6ea),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child:Column(
                        children: [

                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0XFFFFb0b0b0),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  )
                              ),
                            ),
                          ),

                          Container(
                            height: MediaQuery.of(context).size.height/15,
                            child: Center(
                                child: Text(
                                  'Joined : 132',
                                  style: TextStyle(
                                      color: Color(0XFF9D9D9D),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                            ),
                          ),

                        ],
                      )
                  ),

                  SizedBox( width: 7, ),

                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Flexible(
                                  child: Container(
                                    child: Text(
                                      'Lorem Ipsum',
                                      maxLines: 2,overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color(0XFF808080),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        height: (17 / 14),
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 10),

                                Container(
                                  height:  MediaQuery.of(context).size.height/22,
                                  width: MediaQuery.of(context).size.width/5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      color:Color(0XFFFE99AC)
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Join +',
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
                              ],
                            ),
                          ),

                          SizedBox( height: 4, ),

                          Container(
                            child: Text(
                              'Topics : Dummy Text, example.',
                              maxLines: 2,overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0XFF9D9D9D),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: (14 / 12),
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),

                          SizedBox( height: 4, ),

                          Container(
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                              maxLines: 3,overflow: TextOverflow.ellipsis,style: TextStyle(
                              color: Color(0XFF9D9D9D),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: (14 / 12),
                              fontFamily: "Roboto",
                            ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }

  void _scrollListener(){
    if (scrollController!.position.pixels == scrollController!.position.minScrollExtent) {
      widget.scrollScreen(false);
    }
    else{
      widget.scrollScreen(true);
    }
  }//func

}
