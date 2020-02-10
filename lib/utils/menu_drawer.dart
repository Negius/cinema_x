import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/models/user.dart';
import 'package:cinema_x/screens/films/FilmSchedules.dart';
import 'package:cinema_x/screens/home/Home.dart';
import 'package:cinema_x/screens/account/login_page.dart';
import 'package:cinema_x/screens/account/userInfo.dart';
import 'package:cinema_x/screens/films/FilmShowing.dart';
import 'package:cinema_x/screens/News/AllNews.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barcode_flutter/barcode_flutter.dart';

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
    getLoginInfo();
  }

  void getLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isMember = prefs.getBool("isLoggedIn") ?? false;
      if (isMember) {
        fullName = prefs.getString("fullName");
        barCode = prefs.getString("cardCode");
        pointReward = prefs.getDouble("pointReward").toInt() ?? 0;
        pointCard = prefs.getDouble("pointCard").toInt() ?? 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Theme(
      data:
          Theme.of(context).copyWith(canvasColor: Color.fromRGBO(0, 0, 0, 0.2)),
      child: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 230,
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
                              onPressed: () {},
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
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      AutoSizeText.rich(
                        new TextSpan(
                            style: _textTheme.headline6.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            children: <TextSpan>[
                              new TextSpan(text: "Xin chào, "),
                              new TextSpan(
                                text: isMember ? fullName : guest.username,
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
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
                  style: _textTheme.headline6.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 10, left: 10, right: 40, bottom: 20),
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: new BarCodeImage(
                    params: Code39BarCodeParams(barCode.toString(),
                        withText: true, barHeight: 60),
                    // data: barCode.toString(), // Code string. (required)
                    // codeType: BarCodeType.Code39, // Code type (required)
                    // lineWidth:
                    //     2.0, // width for a single black/white bar (default: 2.0)
                    // barHeight:
                    //     90.0, // height for the entire widget (default: 100.0)
                    // hasText:
                    //     true, // Render with text label or not (default: false)
                    // backgroundColor: Colors.white,
                    // onError: (error) {
                    //   // Error handler
                    //   print('error = $error');
                    // },
                  ),
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
                          Text(
                            "Điểm thẻ",
                            style:
                                _textTheme.caption.copyWith(color: Colors.grey),
                          ),
                          Text(
                            pointCard.toString() ?? "0",
                            style: _textTheme.bodyText2
                                .copyWith(color: Colors.white, fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Điểm thưởng",
                            style:
                                _textTheme.caption.copyWith(color: Colors.grey),
                          ),
                          Text(
                            pointReward.toString() ?? "0",
                            style: _textTheme.bodyText2
                                .copyWith(color: Colors.white, fontSize: 30),
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
                        style: _textTheme.headline6.copyWith(
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
                        style: _textTheme.headline6.copyWith(
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
                        style: _textTheme.headline6.copyWith(
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
                  "Đăng nhập",
                  style: _textTheme.headline6.copyWith(
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
                "Đặt vé theo phim",
                style: _textTheme.headline6.copyWith(
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
                    "Trang chủ",
                    style: _textTheme.headline6.copyWith(
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
                    "Thành viên",
                    style: _textTheme.headline6.copyWith(
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
                    "Tin tức & ưu đãi",
                    style: _textTheme.headline6.copyWith(
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
}
