import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/config/AppSettings.dart';
import 'package:cinema_x/models/user.dart';
import 'package:cinema_x/screens/films/FilmSchedules.dart';
import 'package:cinema_x/screens/home/Home.dart';
import 'package:cinema_x/screens/account/login_page.dart';
import 'package:cinema_x/screens/account/userInfo.dart';
import 'package:cinema_x/screens/films/FilmShowing.dart';
import 'package:cinema_x/screens/setting/SettingList.dart';
import 'package:cinema_x/screens/News/AllNews.dart';

import 'package:cinema_x/screens/News/NewNotification.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MenuBar extends StatefulWidget {
  MenuBar();

  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  User guest = new User(username: "Guest", password: "");
  bool isMember = false;
  String barCode;
  String fullName;
  int pointReward;
  int pointCard;

  @override
  void initState() {
    super.initState();
    getUser();
    getLoginInfo();
  }

  void getLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isMember = prefs.getBool("isLoggedIn") ?? false;
      if (isMember) {
        fullName = prefs.getString("fullName");
        barCode = prefs.getString("cardCode");
        pointReward = prefs.getDouble("pointReward") != null
            ? prefs.getDouble("pointReward").toInt()
            : 0;
        pointCard = prefs.getDouble("pointCard") != null
            ? prefs.getDouble("pointCard").toInt()
            : 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Theme(
      data:
          Theme.of(context).copyWith(canvasColor: Color.fromRGBO(0, 0, 0, 0.7)),
      child: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 240,
              child: DrawerHeader(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotiList(),
                                  ),
                                );
                              },
                            ),
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white,
                                ),
                                image: DecorationImage(
                                  image: new AssetImage(
                                      "assets/images/default-avatar.png"),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SettingList()));
                              },
                            ),
                          ],
                        ),
                      ),
                      AutoSizeText.rich(
                        new TextSpan(
                            style: _textTheme.title.copyWith(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                            children: <TextSpan>[
                              new TextSpan(text: "Xin chào, "),
                              new TextSpan(
                                text: isMember ? fullName : guest.username,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(),
              ),
            ),
            isMember ? memberSection(context) : guestSection(context)
          ],
        ),
      ),
    );
  }

  Widget memberSection(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Text(
                  "Thẻ thành viên",
                  style: _textTheme.title.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: new QrImage(
                    data: barCode.toString(),
                    version: QrVersions.auto,
                    size: 220.0,
                  ),
                  // child: new BarCodeImage(
                  //   params: Code39BarCodeParams(barCode.toString(),
                  //       withText: true, barHeight: 60),
                  //   data: barCode.toString(), // Code string. (required)
                  //   codeType: BarCodeType.Code39, // Code type (required)
                  //   lineWidth:
                  //       2.0, // width for a single black/white bar (default: 2.0)
                  //   barHeight:
                  //       90.0, // height for the entire widget (default: 100.0)
                  //   hasText:
                  //       true, // Render with text label or not (default: false)
                  //   backgroundColor: Colors.white,
                  //   onError: (error) {
                  //     // Error handler
                  //     print('error = $error');
                  //   },
                  // ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          AutoSizeText(
                          CommonString.cardPoint,
                            style:
                                _textTheme.caption.copyWith(color: Colors.grey),
                          ),
                          AutoSizeText(
                            pointCard.toString() ?? "0",
                            style: _textTheme.bodyText1
                                .copyWith(color: Colors.white, fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          AutoSizeText(
                            CommonString.rewardPoint,
                            style:
                                _textTheme.caption.copyWith(color: Colors.grey),
                          ),
                          AutoSizeText(
                            pointReward.toString() ?? "0",
                            style: _textTheme.bodyText1
                                .copyWith(color: Colors.white, fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: .4,
                        color: Colors.white,
                      ),
                      bottom: BorderSide(
                        width: .4,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Center(
                      child: Text(
                        "Đặt vé theo phim",
                        style: _textTheme.title.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilmShowing(),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: .4,
                        color: Colors.white,
                      ),
                      bottom: BorderSide(
                        width: .4,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Center(
                      child: Text(
                        "Lịch chiếu",
                        style: _textTheme.title.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilmSchedule(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                buttonGrid(context),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: .4,
                        color: Colors.white,
                      ),
                      bottom: BorderSide(
                        width: .4,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Center(
                      child: Text(
                        "Đăng xuất",
                        style: _textTheme.title.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        logOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget guestSection(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: .4,
                  color: Colors.white,
                ),
                bottom: BorderSide(
                  width: .2,
                  color: Colors.white,
                ),
              ),
            ),
            child: ListTile(
              title: Center(
                child: Text(
                  CommonString.login,
                  style: _textTheme.title.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ),
          ListTile(
            title: Center(
              child: Text(
                CommonString.booking2,
                style: _textTheme.title.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilmShowing(),
                ),
              );
            },
          ),
          buttonGrid(context),
        ],
      ),
    );
  }

  Widget buttonGrid(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  Text(
                    CommonString.homePage,
                    style: _textTheme.title.copyWith(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => isMember ? UserInfoPage() : LoginPage(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.people,
                    color: Colors.white,
                  ),
                  Text(
                    CommonString.member,
                    style: _textTheme.title.copyWith(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListAllNews(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.card_giftcard,
                    color: Colors.white,
                  ),
                  Text(
                    CommonString.news2,
                    style: _textTheme.title.copyWith(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<String> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String api = NccUrl.userInfo + prefs.getInt("customerId").toString();
    var response = await http.post(api);
    // _scheduleNotification();
    if (response.statusCode == 200) {
      Map parsed = json.decode(response.body);

      var pr = parsed["PointReward"] as double;
      var pc = parsed["PointCard"] as double;
      prefs.setDouble("pointReward", pr);//
      prefs.setDouble("pointCard", pc);//
    }
  }
}
