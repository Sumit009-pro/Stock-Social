import 'package:flutter/material.dart';

class JoinedRoom extends StatefulWidget {
  final Function(bool) scrollScreen;
  const JoinedRoom({Key? key,required this.scrollScreen}) : super(key: key);

  @override
  _JoinedRoomState createState() => _JoinedRoomState();
}

class _JoinedRoomState extends State<JoinedRoom> {

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
          padding: EdgeInsets.only(left: 10,right: 10),
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
          margin: EdgeInsets.only(left: 10, right: 10, top: 16),
          child: Card(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height/9,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                    child:  CircleAvatar(
                        radius: 31,
                        backgroundColor: Color(0XFFFFb0b0b0),
                        child:CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          //backgroundImage:AssetImage("assets/images/user_profile.png",),
                        )
                    ),
                  ),

                  SizedBox( width: 7, ),

                  Container(
                    width: MediaQuery.of(context).size.width/3.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Container(
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

                        ],
                      ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 8,right: 10),
                    child:  Text(
                      '132 \n Members',textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                  ),


                  Container(
                    width: MediaQuery.of(context).size.width/6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          child: Text(
                            'Public',
                            maxLines: 1,
                            style: TextStyle(
                              color: Color(0XFFFE99AC),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: (17 / 14),
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),

                        SizedBox(height: 4,),

                        Container(
                          child: Text(
                            'Expires in 5 days',softWrap: true,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: (17 / 14),
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),

                  Container(
                    child: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                  )

                ],
              ),
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 16),
          child: Card(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height/9,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                    child:  CircleAvatar(
                        radius: 31,
                        backgroundColor: Color(0XFFFFb0b0b0),
                        child:CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          //backgroundImage:AssetImage("assets/images/user_profile.png",),
                        )
                    ),
                  ),

                  SizedBox( width: 7, ),

                  Container(
                    width: MediaQuery.of(context).size.width/3.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
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

                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 8,right: 10),
                    child:  Text(
                      '132 \n Members',textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                  ),


                  Container(
                    width: MediaQuery.of(context).size.width/6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          child: Text(
                            'Private',
                            maxLines: 1,
                            style: TextStyle(
                              color: Color(0XFF9D9D9D),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: (17 / 14),
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),

                        SizedBox(height: 4,),

                        Container(
                          child: Text(
                            'Expires in 28 days',softWrap: true,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: (17 / 14),
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),

                  Container(
                    child: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                  )

                ],
              ),
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 16),
          child: Card(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height/9,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                    child:  CircleAvatar(
                        radius: 31,
                        backgroundColor: Color(0XFFFFb0b0b0),
                        child:CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          //backgroundImage:AssetImage("assets/images/user_profile.png",),
                        )
                    ),
                  ),

                  SizedBox( width: 7, ),

                  Container(
                    width: MediaQuery.of(context).size.width/3.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
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

                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 8,right: 10),
                    child:  Text(
                      '132 \n Members',textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                  ),


                  Container(
                    width: MediaQuery.of(context).size.width/6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          child: Text(
                            'Public',
                            maxLines: 1,
                            style: TextStyle(
                              color: Color(0XFFFE99AC),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: (17 / 14),
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),

                  Container(
                    child: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                  )

                ],
              ),
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 16,bottom: 16),
          child: Card(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height/9,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                    child:  CircleAvatar(
                        radius: 31,
                        backgroundColor: Color(0XFFFFb0b0b0),
                        child:CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          //backgroundImage:AssetImage("assets/images/user_profile.png",),
                        )
                    ),
                  ),

                  SizedBox( width: 7, ),

                  Container(
                    width: MediaQuery.of(context).size.width/3.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
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

                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 8,right: 10),
                    child:  Text(
                      '132 \n Members',textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                  ),


                  Container(
                    width: MediaQuery.of(context).size.width/6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          child: Text(
                            'Private',
                            maxLines: 1,
                            style: TextStyle(
                              color: Color(0XFF9D9D9D),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: (17 / 14),
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),

                        SizedBox(height: 4,),

                        Container(
                          child: Text(
                            'Expires in 10 days',softWrap: true,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: (17 / 14),
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),

                  Container(
                    child: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
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
