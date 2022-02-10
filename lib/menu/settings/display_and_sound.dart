import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class DisplayAndSound extends StatefulWidget {
  const DisplayAndSound({Key? key}) : super(key: key);

  @override
  _DisplayAndSoundState createState() => _DisplayAndSoundState();
}

class _DisplayAndSoundState extends State<DisplayAndSound> {
  double _currentSliderValue = 10;
  bool _darkMode = false;
  bool _soundEffects = false;
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
                  icon: const Icon(Icons.chevron_left),
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
              'Settings',
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
                        color:Color(0XFFFE99AC),
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
      body: Column(children: [
        SizedBox(
          height: 32,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 16),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
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
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 24),
                  child: Text(
                    'Display',
                    style: TextStyle(
                      color: Color(0XFF808080),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: (22 / 18),
                      fontFamily: "Roboto",
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Divider(
                  color: Color(0XFF9D9D9D),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 16, top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Text size',
                        style: TextStyle(
                          color: Color(0XFFFFb0b0b0),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: (16 / 14),
                          fontFamily: "Roboto",
                        ),
                      ),
                      Container(
                        width: 260,
                        child: Slider(
                          activeColor: Color(0XFFFE99AC),
                          value: _currentSliderValue,
                          min: 0,
                          max: 100,
                          divisions: 5,
                          label: _currentSliderValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Color(0XFF9D9D9D),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24,right: 24,top:20,bottom: 20 ),
                  child:Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Container(
                          child:Text(
                            'Dark mode',
                            style: TextStyle(
                              color:Color(0XFFFFb0b0b0),
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
                          inactiveColor: Color(0XFFffe6ea),
                          toggleSize: 18.0,
                          value: _darkMode,
                          onToggle: (val) {
                            setState(() {
                              _darkMode = val;
                            });
                          },
                        ),
                      ],
                    ),
                  )

                  /*SwitchListTile(
                    activeColor: Color(0XFF1EDCC5),
                    title: const Text(
                      'Dark mode',
                      style: TextStyle(
                        color: Color(0XFF808080),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: (16 / 14),
                        fontFamily: "Roboto",
                      ),
                    ),
                    value: _darkMode,
                    onChanged: (bool value) {
                      setState(() {
                        _darkMode = value;
                      });
                    },
                  ),*/
                ),
                Divider(
                  color: Color(0XFF9D9D9D),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 24, bottom: 16),
                  child: Text(
                    'Sound',
                    style: TextStyle(
                      color: Color(0XFF808080),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: (22 / 18),
                      fontFamily: "Roboto",
                    ),
                  ),
                ),
                Divider(
                  color: Color(0XFF9D9D9D),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 24,right: 24,top:20,bottom: 20 ),
                    child:Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          Container(
                            child:Text(
                              'Sound Effects',
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
                            inactiveColor: Color(0XFFffe6ea),
                            value: _soundEffects,
                            onToggle: (val) {
                              setState(() {
                                _soundEffects = val;
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  /*SwitchListTile(
                    activeColor: Color(0XFF1EDCC5),
                    title: const Text(
                      'Sound Effects',
                      style: TextStyle(
                        color: Color(0XFF808080),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: (16 / 14),
                        fontFamily: "Roboto",
                      ),
                    ),
                    value: _soundEffects,
                    onChanged: (bool value) {
                      setState(() {
                        _soundEffects = value;
                      });
                    },
                  ),*/
                ),
                Divider(
                  color: Color(0XFF9D9D9D),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
