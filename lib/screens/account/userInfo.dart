import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/config/AppSettings.dart';
import 'package:cinema_x/models/user.dart';
import 'package:cinema_x/screens/account/task/accountDetails.dart';
import 'package:cinema_x/screens/account/task/changePassword.dart';
import 'package:cinema_x/utils/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'task/memberCardDetails.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<User> _user;

  @override
  void initState() {
    _user = getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        endDrawer: MenuBar(),
        key: _scaffoldKey,
        body: FutureBuilder(
          future: _user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var user = snapshot.data as User;
              return Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Container(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.topRight,
                          children: <Widget>[
                            Center(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 75),
                                    height: 100,
                                    width: 100,
                                    alignment: Alignment.bottomRight,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                      image: DecorationImage(
                                        image: new AssetImage(
                                            "assets/images/default-avatar.png"),
                                      ),
                                    ),
                                    child: InkWell(
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.black87,
                                      ),
                                      onTap: () {},
                                      onHover: (isHover) {},
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  AutoSizeText(
                                    user.fullName,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    minFontSize: 20,
                                  ),
                                  AutoSizeText.rich(
                                    new TextSpan(children: <TextSpan>[
                                      new TextSpan(
                                        text: CommonString.memberCard + ": ",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      new TextSpan(
                                        text: user.cardCode,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 25),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 60,
                              decoration: BoxDecoration(
                                // border:
                                // Border.all(color: Colors.black, width: 1),
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/hexagon.png"),
                                    fit: BoxFit.fill),
                              ),
                              margin: EdgeInsets.only(top: 75, right: 20),
                              child: Text(
                                user.cardLevelName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: <Widget>[
                                  AutoSizeText(
                                    CommonString.cardPoint,
                                    style: TextStyle(color: Colors.grey),
                                    maxLines: 1,
                                  ),
                                  AutoSizeText(
                                    user.pointCard.round().toString() + " đ",
                                    maxLines: 1,
                                    minFontSize: 25,
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
                                    style: TextStyle(color: Colors.grey),
                                    maxLines: 1,
                                  ),
                                  AutoSizeText(
                                    user.pointReward.round().toString() + " đ",
                                    maxLines: 1,
                                    minFontSize: 25,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(5),
                          leading: Icon(
                            Icons.account_box,
                            color: Color.fromRGBO(221, 45, 57, 1),
                            size: 40,
                          ),
                          title: AutoSizeText(
                            ReCase(CommonString.accountInfo).sentenceCase,
                            minFontSize: 20,
                            maxLines: 1,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AccountDetailsPage(),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(5),
                          leading: Icon(
                            Icons.lock,
                            color: Color.fromRGBO(221, 45, 57, 1),
                            size: 40,
                          ),
                          title: AutoSizeText(
                            CommonString.changePassword,
                            minFontSize: 20,
                            maxLines: 1,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChangePasswordPage()));
                          },
                        ),
                        SizedBox(
                          height: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(5),
                          // leading: Icon(
                          //   Icons.lock,
                          //   color: Colors.red,
                          // ),
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/member_card_icon.png"),
                              ),
                            ),
                          ),
                          title: AutoSizeText(
                            CommonString.memberCard,
                            minFontSize: 20,
                            maxLines: 1,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MemberCardPage()));
                            });
                          },
                        ),
                        SizedBox(
                          height: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(5),
                          leading: Icon(
                            Icons.credit_card,
                            color: Color.fromRGBO(221, 45, 57, 1),
                            size: 40,
                          ),
                          title: AutoSizeText(
                            "Điểm thẻ",
                            minFontSize: 20,
                            maxLines: 1,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {},
                        ),
                        SizedBox(
                          height: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // ListTile(
                        //   contentPadding: EdgeInsets.all(5),
                        //   leading: Icon(
                        //     Icons.card_giftcard,
                        //     color: Colors.red,
                        //   ),
                        //   title: AutoSizeText("Quà tặng | Voucher | Coupon"),
                        //   trailing: Icon(Icons.arrow_forward_ios),
                        //   onTap: () {},
                        // ),
                        // SizedBox(
                        //   height: 3,
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       border: Border(
                        //         top: BorderSide(
                        //           width: 1,
                        //           color: Colors.grey,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 15, right: 5),
                          title: AutoSizeText(
                            CommonString.purchaseHistory,
                            minFontSize: 20,
                            maxLines: 1,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {},
                        ),
                        SizedBox(
                          height: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 15, right: 5),
                          title: AutoSizeText(
                            CommonString.watchedMovies,
                            minFontSize: 20,
                            maxLines: 1,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  new Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: AppBar(
                      title: Text(CommonString.member),
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                      ),
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () =>
                              _scaffoldKey.currentState.openEndDrawer(),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ));
  }

  Future<User> getUserInfo() async {
    var user = new User();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user.fullName = prefs.getString("fullName");
      user.cardCode = prefs.getString("cardCode");
      user.cardLevelName = prefs.getString("cardLevelName");
      user.pointCard = prefs.getDouble("pointCard");
      user.pointReward = prefs.getDouble("pointReward");
    });
    return user;
  }
}
