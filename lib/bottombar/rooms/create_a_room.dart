import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:stock_social/bottombar/rooms/demo_room.dart';
import 'package:stock_social/bottombar/rooms/private_room_payment.dart';
import 'package:stock_social/widgets/my_material_button.dart';

class CreateARoom extends StatefulWidget {
  const CreateARoom({Key? key}) : super(key: key);

  @override
  _CreateARoomState createState() => _CreateARoomState();
}

class _CreateARoomState extends State<CreateARoom> {
  final int _numPages = 7;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  String _title = "";
  String _subtitle = "";

  final List<Map<String, String>> _pageTitles = [
    {
      "title": "Get Early Access!",
      "subtitle": "Create Your Room Now",
    },
    {
      "title": "Room Information",
      "subtitle": "Maximum 5 Topics",
    },
    {
      "title": "Name Your Room",
      "subtitle": "URL will genarate automatically",
    },
    {
      "title": "Room Description",
      "subtitle": "Maximum 100 charecters",
    },
    {
      "title": "Room Roles",
      "subtitle": "Maximum 100 charecters",
    },
    {
      "title": "Additonal Info",
      "subtitle": "Add some additional information",
    },
    {
      "title": "Review Your Room Information",
      "subtitle": "Add some additional information",
    },
  ];

  @override
  void initState() {
    super.initState();
    _title = _pageTitles[_currentPage]["title"]!;
    _subtitle = _pageTitles[_currentPage]["subtitle"]!;
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i <= _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 3.0,
      width: MediaQuery.of(context).size.width/13,
      decoration: BoxDecoration(
        color: isActive ? Color(0XFFFE99AC) : Color(0XFFC4C4C4),
      ),
    );
  }

  bool _isPrivate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0), // here the desired height

          child: AppBar(
            backgroundColor: Colors.transparent,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            centerTitle: true,
            title: Text(
              'Create Room',
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
          )),
      body: Column(
        children: [
          SizedBox(
            height: 32,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius:4.0, // soften the shadow
                      offset: Offset(
                        0.0, // Move to right 10  horizontally
                        -1.0, // Move to bottom 10 Vertically
                      ),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: ListView(
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  Center(
                    child: Text(
                      _title,
                      style: TextStyle(
                        color: Color(0XFF9D9D9D),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: (30 / 24),
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        _subtitle,
                        style: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: (16 / 14),
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Divider(
                    color: Color(0XFF9D9D9D),
                  ),
                  SizedBox(
                    height: 18,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                  ),

                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    height: 600.0,
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                          _title = _pageTitles[_currentPage]["title"]!;
                          _subtitle = _pageTitles[_currentPage]["subtitle"]!;
                        });
                      },
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, top: 24, right: 24),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Tittle of Your Room',
                              labelStyle: TextStyle(
                                color: Color(0XFF9D9D9D),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: (15 / 12),
                                fontFamily: "Roboto",
                              ),
                            ),
                            textCapitalization: TextCapitalization.words,
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, top: 24, right: 24),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'What is your room name?',
                                  labelStyle: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: (15 / 12),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                textCapitalization: TextCapitalization.words,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, top: 30, right: 24),
                              child:Container(
                                child: Text('Select Room Topics',
                                  style: TextStyle(color: Color(0XFF9D9D9D), ),),
                              )
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, top: 24, right: 24),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: '1.',
                                  labelStyle: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: (15 / 12),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                textCapitalization: TextCapitalization.words,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, top: 24, right: 24),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: '2.',
                                  labelStyle: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: (15 / 12),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                textCapitalization: TextCapitalization.words,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, top: 24, right: 24),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: '3.',
                                  labelStyle: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: (15 / 12),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                textCapitalization: TextCapitalization.words,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, top: 24, right: 24),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: '4.',
                                  labelStyle: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: (15 / 12),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                textCapitalization: TextCapitalization.words,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, top: 24, right: 24),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: '5.',
                                  labelStyle: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: (15 / 12),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                textCapitalization: TextCapitalization.words,
                              ),
                            ),

                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, top: 24, right: 24),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'What is your Room Name?',
                              labelStyle: TextStyle(
                                color: Color(0XFF9D9D9D),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: (15 / 12),
                                fontFamily: "Roboto",
                              ),
                            ),
                            textCapitalization: TextCapitalization.words,
                          ),
                        ),

                        Column(
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, top: 24, right: 24),
                              child: TextFormField(
                                maxLines: 7,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'What is your room about?',
                                  labelStyle: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: (15 / 12),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                textCapitalization: TextCapitalization.words,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, top: 24, right: 24),
                              child: TextFormField(
                                maxLines: 7,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'What is your room rules?',
                                  labelStyle: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: (15 / 12),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                textCapitalization: TextCapitalization.words,
                              ),
                            ),

                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, top: 24, right: 24),
                          child: TextFormField(
                            maxLines: 7,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'What is your Room about?',
                              labelStyle: TextStyle(
                                color: Color(0XFF9D9D9D),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: (15 / 12),
                                fontFamily: "Roboto",
                              ),
                            ),
                            textCapitalization: TextCapitalization.words,
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, right: 24, top: 24, bottom: 8),
                              child: Text(
                                'Room Type',
                                style: TextStyle(
                                  color: Color(0XFF808080),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: (15 / 12),
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 24, right: 24),
                              child: Divider(
                                color: Color(0XFF9D9D9D),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0,right: 24,top: 10,bottom: 10),
                              child:Container(
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [

                                     Expanded(
                                       child:Container(
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [

                                             Container(
                                               child: Text('Private',
                                                 style: TextStyle(
                                                   color: Color(0XFF808080),
                                                   fontSize: 14,
                                                   fontWeight: FontWeight.w500,
                                                   height: (16 / 14),
                                                   fontFamily: "Roboto",
                                                 ),
                                               ),
                                             ),

                                             Container(
                                               child:Text(
                                                 'Enable this will allow you to use private features.',
                                                 style: TextStyle(
                                                   color: Color(0XFF9D9D9D),
                                                   fontSize: 12,
                                                   fontWeight: FontWeight.w400,
                                                   height: (16 / 12),
                                                   fontFamily: "Roboto",
                                                 ),
                                               ),
                                             )

                                           ],
                                         ),
                                       )
                                     ),

                                     FlutterSwitch(
                                       width: 40.0,
                                       height: 20.0,
                                       activeColor: Color(0XFFFE99AC),
                                       inactiveColor: Color(0XFFffe6ea),
                                       toggleSize: 18.0,
                                       value: _isPrivate,
                                       onToggle: (val) {
                                         setState(() {
                                           _isPrivate = val;
                                         });
                                       },
                                     ),

                                   ],
                                 ),
                              )
                              /*SwitchListTile(
                                activeColor: Color(0XFF1EDCC5),
                                title: const Text(
                                  'Private',
                                  style: TextStyle(
                                    color: Color(0XFF808080),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    height: (16 / 14),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                subtitle: const Text(
                                  'Enable this will allow you to use private features.',
                                  style: TextStyle(
                                    color: Color(0XFF9D9D9D),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: (16 / 12),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                value: _isPrivate,
                                onChanged: (bool value) {
                                  setState(() {
                                    _isPrivate = value;
                                  });
                                },
                              ),*/
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 24, right: 24),
                              child: Divider(
                                color: Color(0XFF9D9D9D),
                              ),
                            ),
                            ListTile(
                              title: const Text(
                                'Upload A Room Image',
                                style: TextStyle(
                                  color: Color(0XFF808080),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: (16 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                              subtitle: const Text(
                                'Preferred image will be 220 X 220 square',
                                style: TextStyle(
                                  color: Color(0XFF9D9D9D),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: (16 / 12),
                                  fontFamily: "Roboto",
                                ),
                              ),
                              trailing: InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0XFF9D9D9D)),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      )),
                                  child: OutlinedButton(
                                    onPressed: null,
                                    child: Center(
                                      child: Text(
                                        '+',
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
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0XFF9D9D9D)),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      )),
                                  child: OutlinedButton(
                                    onPressed: null,
                                    child: Center(
                                      child: Text(
                                        '+',
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
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                'Lorem Ipsum',
                                style: TextStyle(
                                  color: Color(0XFF808080),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: (17 / 14),
                                  fontFamily: "Roboto",
                                ),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Room Topics',
                                    style: TextStyle(
                                      color: Color(0XFF808080),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: (17 / 14),
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                  Text(
                                    'Lorem Ipsum',
                                    style: TextStyle(
                                      color: Color(0XFF9D9D9D),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      height: (17 / 14),
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 11,
                              ),
                              Divider(
                                color: Color(0XFF9D9D9D),
                              ),
                              SizedBox(
                                height: 11,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Room Description',
                                    style: TextStyle(
                                      color: Color(0XFF808080),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: (17 / 14),
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                  Text(
                                    'Lorem Ipsum',
                                    style: TextStyle(
                                      color: Color(0XFF9D9D9D),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      height: (17 / 14),
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 11,
                              ),
                              Divider(
                                color: Color(0XFF9D9D9D),
                              ),
                              SizedBox(
                                height: 11,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Room Name',
                                    style: TextStyle(
                                      color: Color(0XFF808080),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: (17 / 14),
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                  Text(
                                    'Lorem Ipsum',
                                    style: TextStyle(
                                      color: Color(0XFF9D9D9D),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      height: (17 / 14),
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 11,
                              ),
                              Divider(
                                color: Color(0XFF9D9D9D),
                              ),
                              SizedBox(
                                height: 11,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Room Type',
                                    style: TextStyle(
                                      color: Color(0XFF808080),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: (17 / 14),
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                  Text(
                                    'Lorem Ipsum',
                                    style: TextStyle(
                                      color: Color(0XFF9D9D9D),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      height: (17 / 14),
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 11,
                              ),
                              Divider(
                                color: Color(0XFF9D9D9D),
                              ),
                              SizedBox(
                                height: 11,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Room Rules',
                                    style: TextStyle(
                                      color: Color(0XFF808080),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: (17 / 14),
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                  Text(
                                    'Lorem Ipsum',
                                    style: TextStyle(
                                      color: Color(0XFF9D9D9D),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      height: (17 / 14),
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 11,
                              ),
                              Divider(
                                color: Color(0XFF9D9D9D),
                              ),
                              SizedBox(
                                height: 11,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Room URL',
                                    style: TextStyle(
                                      color: Color(0XFF808080),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: (17 / 14),
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                  Text(
                                    'Lorem Ipsum',
                                    style: TextStyle(
                                      color: Color(0XFF9D9D9D),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      height: (17 / 14),
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 11,
                              ),
                              Divider(
                                color: Color(0XFF9D9D9D),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 24, right: 24, bottom: 32),
        color: Colors.white,
        child: MyMaterialButton(
          onTap: () {
            _currentPage == _numPages - 1
                ? Navigator.push(context,CupertinoPageRoute( builder: (context) => PrivateRoomPayment()))
              //  ? Navigator.push(context,CupertinoPageRoute( builder: (context) => DemoRoom()))
                : _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
          },
          tittle: _currentPage == _numPages - 1 ? 'Create Room' : 'NEXT',
        ),
      ),
    );
  }
}
