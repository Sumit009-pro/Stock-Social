import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stock_social/home.dart';
import 'package:stock_social/menu/privacy/privacy.dart';
import 'package:stock_social/menu/terms/terms.dart';
import 'package:stock_social/models/api.dart';
import 'package:stock_social/models/user_model.dart';
import 'package:stock_social/menu/ranking/rankings.dart';
import 'package:stock_social/menu/settings/settings.dart';
import 'package:stock_social/social/google_signin_api.dart';
import 'package:stock_social/widgets/loading_spinner.dart';
import 'package:provider/provider.dart';
import 'package:stock_social/widgets/profile_image.dart';

import 'about/about.dart';
import 'help/help.dart';

class Menu extends StatefulWidget {
  final plugin = FacebookLogin(debug: true);

  // const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  UserModel? userDetails;
  var follow='',following='',post='';
  bool process=true;

  @override
  void initState() {
    super.initState();
    userDetails = UserModel.getInstance();
    fetchCount(userDetails?.userId);
  }
  void fetchCount(String? id)async{

    final response = await API.fetchCount({'userId':id});
    if (response["STATUSCODE"] == 200) {
      var rest =  response["response_data"] ;
      setState(() {
        follow=rest['followers'].toString();
        following=rest['following'].toString();
        process=false;
      });
    }
    else {
      setState(() {    process=false;   });
      ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text(response["message"]))));
    }
  }//func
  onSubmit() async {
    showLoadingSpinner(context, "Signing out...");
    try{
    await GoogleSignInApi.logout();}
    catch(e){

    }
    try{
      await widget.plugin.logOut();}
    catch(e){

    }
    //
    final response = await API.logout();
    hideLoadingSpinner(context);

    if (response["STATUSCODE"] == 200) {
      // obtain shared preferences
      Navigator.pushNamedAndRemoveUntil(context, '/signIn', (route) => false);
    }
    ScaffoldMessenger.of(context)
        .showSnackBar((SnackBar(content: Text(response["message"]))));
  }

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
                     // Navigator.pop(context);
                      Navigator.push(context,CupertinoPageRoute(builder: (context) => Home()));
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                },
              ),
              centerTitle: true,
              title: Text(
                'StockSocial',
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
        body: Consumer<UserModel>(builder: (context, userDetails, child) {
          return Column(children: [
            SizedBox(
              height: 16,
            ),
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(10),
            //   child: Image.asset(
            //     userDetails.profileImage!,
            //     //"${_imageFile}",
            //     width: 82,
            //     height: 82,
            //     alignment: Alignment.center,
            //     fit: BoxFit.fitWidth,
            //   ),
            // ),
            Container(
              color: Colors.transparent,
             /* width: 82,
              height: 82,*/
              child: CircleAvatar(
                radius: 43,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 40,
                    backgroundColor: Color(0XFFE5E5E5),
                    child: ProfileImage(imageUrl: userDetails.profileImage)),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Text("${userDetails.firstName} ${userDetails.lastName}",
              style: TextStyle(
                color: Color(0XFFFFFFFF),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: (17 / 14),
                fontFamily: "Roboto",
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              userDetails.email ?? "",
              style: TextStyle(
                color: Color(0XFFFFFFFF),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: (12 / 12),
                fontFamily: "Roboto",
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                      text: following,
                      style: TextStyle(
                        color: Color(0XFFFFFFFF),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: (17 / 12),
                        fontFamily: "Roboto",
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Following',
                          style: TextStyle(
                            color: Color(0XFFFFFFFF),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: (17 / 12),
                            fontFamily: "Roboto",
                          ),
                        )
                      ]),
                ),
                SizedBox(
                  width: 12,
                ),
                RichText(
                  text: TextSpan(
                      text: '${follow}',
                      style: TextStyle(
                        color: Color(0XFFFFFFFF),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: (17 / 12),
                        fontFamily: "Roboto",
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Followers',
                          style: TextStyle(
                            color: Color(0XFFFFFFFF),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: (17 / 12),
                            fontFamily: "Roboto",
                          ),
                        )
                      ]),
                ),
              ],
            ),
            SizedBox(
              height: 24,
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
                // child: ListView.separated(
                //     itemBuilder: (_, index) {
                //       return ListTile(
                //         dense: true,
                //         leading: SvgPicture.asset('assets/icons/ranking.svg'),
                //         title: Text(
                //           [
                //             'Rankings',
                //             'Memberships',
                //             'Settings',
                //             'About',
                //             'Help',
                //             'Terms & Conditions',
                //             'Privacy Policy',
                //             'Sign Out',
                //           ][index],
                //           style: TextStyle(
                //             color: Color(0XFF808080),
                //             fontSize: 14,
                //             fontWeight: FontWeight.w500,
                //             height: (17 / 14),
                //             fontFamily: "Roboto",
                //           ),
                //         ),
                //         trailing: Icon(Icons.chevron_right),
                //       );
                //     },
                //     separatorBuilder: (_, index) => Divider(),
                //     itemCount: 8))

                child: ListView(
                  children: [
                    /*ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => Rankings()));
                      },
                      dense: true,
                      leading: SvgPicture.asset(
                        'assets/icons/ranking.svg',
                        color:Color(0XFFFE99AC),
                      ),
                      title: Text(
                        'Rankings',
                        style: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: (17 / 14),
                          fontFamily: "Roboto",
                        ),
                      ),
                      trailing: Icon(Icons.chevron_right,color: Color(0XFF9D9D9D),),
                    ),
                    Divider(),*/
                  /*  ListTile(
                      dense: true,
                      leading: SvgPicture.asset(
                        'assets/icons/membership.svg',
                        color:Color(0XFFFE99AC),
                      ),
                      title: Text(
                        'Memberships',
                        style: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: (17 / 14),
                          fontFamily: "Roboto",
                        ),
                      ),
                      trailing: Icon(Icons.chevron_right,color: Color(0XFF9D9D9D),),
                    ),
                    Divider(),*/

                    ListTile(
                      onTap: () {
                        Navigator.push(context,CupertinoPageRoute(
                                builder: (context) => Settings()));
                      },
                      dense: true,
                      leading: SvgPicture.asset(
                        'assets/icons/settings.svg',
                        color:Color(0XFFFE99AC),
                      ),
                      title: Text(
                        'Settings',
                        style: TextStyle(
                          color:Color(0XFF9D9D9D),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: (17 / 14),
                          fontFamily: "Roboto",
                        ),
                      ),
                      trailing: Icon(Icons.chevron_right,color: Color(0XFF9D9D9D),),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,CupertinoPageRoute(
                            builder: (context) => About()));
                      },
                      dense: true,
                      leading: SvgPicture.asset(
                        'assets/icons/about.svg',
                        color: Color(0XFFFE99AC),
                      ),
                      title: Text(
                        'About',
                        style: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: (17 / 14),
                          fontFamily: "Roboto",
                        ),
                      ),
                      trailing: Icon(Icons.chevron_right,color: Color(0XFF9D9D9D),),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,CupertinoPageRoute(
                            builder: (context) => Help()));
                      },
                      dense: true,
                      leading: SvgPicture.asset(
                        'assets/icons/help.svg',
                        color: Color(0XFFFE99AC),
                      ),
                      title: Text(
                        'Help',
                        style: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: (17 / 14),
                          fontFamily: "Roboto",
                        ),
                      ),
                      trailing: Icon(Icons.chevron_right,color: Color(0XFF9D9D9D),),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,CupertinoPageRoute(
                            builder: (context) => Terms()));
                      },
                      dense: true,
                      leading: SvgPicture.asset(
                        'assets/icons/termsandconditions.svg',
                        color:Color(0XFFFE99AC),
                      ),
                      title: Text(
                        'Terms & Conditions',
                        style: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: (17 / 14),
                          fontFamily: "Roboto",
                        ),
                      ),
                      trailing: Icon(Icons.chevron_right,color: Color(0XFF9D9D9D),),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,CupertinoPageRoute(
                            builder: (context) => Privacy()));
                      },
                      dense: true,
                      leading: SvgPicture.asset(
                        'assets/icons/privacypolicy.svg',
                        color: Color(0XFFFE99AC),
                      ),
                      title: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: (17 / 14),
                          fontFamily: "Roboto",
                        ),
                      ),
                      trailing: Icon(Icons.chevron_right,color: Color(0XFF9D9D9D),),
                    ),
                    Divider(),
                    ListTile(
                      onTap: onSubmit,
                      dense: true,
                      leading: SvgPicture.asset(
                        'assets/icons/signout.svg',
                        color:Color(0XFFFE99AC),
                      ),
                      title: Text(
                        'Sign Out',
                        style: TextStyle(
                          color: Color(0XFF9D9D9D),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: (17 / 14),
                          fontFamily: "Roboto",
                        ),
                      ),
                      trailing: Icon(Icons.chevron_right,color: Color(0XFF9D9D9D),),
                    ),
                  ],
                ),
              ),
            )
          ]);
        }
       )
    );
  }
}
