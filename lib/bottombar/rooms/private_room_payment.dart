import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:readmore/readmore.dart';
import 'package:stock_social/bottombar/rooms/add_new_creadit_or_debit_card.dart';
import 'package:stock_social/models/user_model.dart';
import 'package:stock_social/widgets/my_material_button.dart';

class PrivateRoomPayment extends StatefulWidget {
  const PrivateRoomPayment({Key? key}) : super(key: key);

  @override
  _PrivateRoomPaymentState createState() => _PrivateRoomPaymentState();
}

class _PrivateRoomPaymentState extends State<PrivateRoomPayment> {

  UserModel? userDetails;

  final _commentController=TextEditingController();

  @override
  void initState() {
    super.initState();
    userDetails = UserModel.getInstance();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'Demo Room',
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
        actions: [
          new Stack(
            children: <Widget>[
              new IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Color(0XFFE5E5E5),
                  ),
                  onPressed: () {}),
              new Positioned(
                right: 11,
                top: 11,
                child: new Container(
                  padding: EdgeInsets.all(2),
                  decoration: new BoxDecoration(
                    color: Color(0XFFFE99AC),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '5',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
          new IconButton(
              icon: Icon(
                Icons.mail,
                color: Color(0XFFE5E5E5),
                size: 22,
              ),
              onPressed: () {}),
        ],
      ),
      body:Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              height: MediaQuery.of(context).size.height/4.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/vg-bg.png'),
                      fit: BoxFit.fill
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))
              ),
            ),

            SizedBox( height: 18, ),

            Expanded(
              child: Container(
               // height: 1000,
                child: ListView(
                  shrinkWrap: true,
                 // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      padding: const EdgeInsets.only(left: 14.0, right: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Flexible(
                            child: Container(
                              child: Text(
                                '${userDetails!.firstName} ${userDetails!.lastName}',
                                style: TextStyle(
                                  color: Color(0XFF9D9D9D),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.width/10,
                              width: MediaQuery.of(context).size.width/6,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Color(0XFFffe6ea)),
                              child: Center(
                                  child: Icon(
                                Ionicons.ellipsis_horizontal_outline,
                                color: Color(0XFF9D9D9D),
                              )),
                            ),
                          ),

                        ],
                      ),
                    ),

                    SizedBox(
                      height: 6,
                    ),

                    Container(
                      padding: const EdgeInsets.only(left: 14.0, right: 14),
                      child: RichText(
                        text: TextSpan(
                            text: 'Type -  ',
                            style: TextStyle(
                              color: Color(0XFFFFb0b0b0),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              height: (17 / 12),
                              fontFamily: "Roboto",
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Private',
                                style: TextStyle(
                                  color: Color(0XFFFE99AC),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  height: (17 / 12),
                                  fontFamily: "Roboto",
                                ),
                              )
                            ]
                        ),
                      ),
                    ),

                    SizedBox( height: 5, ),

                    Container(
                      padding: const EdgeInsets.only(left: 14.0, right: 14),
                      child: RichText(
                        text: TextSpan(
                            text: 'About -  ',
                            style: TextStyle(
                              color: Color(0XFFFFb0b0b0),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              height: (17 / 12),
                              fontFamily: "Roboto",
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s. It has survived not only five.',
                                style: TextStyle(
                                  color: Color(0XFFFFb0b0b0),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  height: (17 / 12),
                                  fontFamily: "Roboto",
                                ),
                              )
                            ]
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 20,bottom: 10),
                      child: Center(
                          child: Icon(
                        Icons.lock,
                        color: Color(0XFFFE99AC),size: 30,
                       )
                      ),
                    ),


                    Center(
                      child: Text(
                        'This is Private Room',
                        style: TextStyle(
                          color: Color(0XFF808080),
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Text(
                        'To Join this room please get subscription',
                        style: TextStyle(
                          color: Color(0XFFFFb0b0b0),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Center(
                      child: MyMaterialButton(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddNewCreaditOrDebitCard()));
                      },
                      tittle: "Send  Request",
                      width: MediaQuery.of(context).size.width/1.8,
                    )
                    ),


                  ],
                ),
              ),
            ),

          ],
        ),

      ),
    );
  }
}
