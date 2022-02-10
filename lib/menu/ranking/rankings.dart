import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:stock_social/menu/ranking/most_active_ranking.dart';
import 'package:stock_social/menu/ranking/trending_ranking.dart';
import 'package:stock_social/menu/ranking/watchers_ranking.dart';

class Rankings extends StatelessWidget {
  const Rankings({Key? key}) : super(key: key);

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
                  icon: const Icon(Icons.arrow_back_ios),
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
              'Rankings',
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
      body: DefaultTabController(
        length: 3,
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[

              SizedBox(
                height: 16,
              ),

              Container(
                margin: EdgeInsets.only(left:10,right: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color:Color(0XFFffe6ea),
                ),
                height: MediaQuery.of(context).size.height/15,
                child: TabBar(
                  unselectedLabelColor:Color(0XFF9D9D9D),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0XFFFE99AC)
                  ),
                  unselectedLabelStyle: TextStyle(
                    color: Color(0XFF9D9D9D),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: (17 / 14),
                    fontFamily: "Roboto",
                  ),
                  labelStyle: TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: (17 / 14),
                    fontFamily: "Roboto",
                  ),
                  tabs: [
                    Tab(   text: "Most Active",  ),
                    Tab(  text: "Watchers",  ),
                    Tab(  text: "Trendings",  ),
                  ],
                ),
              ),

              SizedBox(
                height: 6,
              ),
              Divider(
                thickness: 1,
              ),

              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    MostActiveRanking(),
                    WatchersRanking(),
                    TrendingRanking()
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
