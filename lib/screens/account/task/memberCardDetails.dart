import 'package:cinema_x/utils/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberCardPage extends StatefulWidget {
  @override
  _MemberCardPageState createState() => _MemberCardPageState();
}

class _MemberCardPageState extends State<MemberCardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<Map<String, dynamic>> _cardInfo;
  @override
  void initState() {
    super.initState();
    _cardInfo = getCardInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: MenuBar(),
      appBar: new AppBar(
        title: new Text('Thông tin thẻ thành viên'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
          ),
        ],
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder(
          future: _cardInfo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        top: 20.0,
                        bottom: 5.0,
                        left: 20,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 180,
                            child: Text(
                              "Tên chủ thẻ:",
                              style: TextStyle(
                                color: Color(0xFF8E4585),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            snapshot.data["username"],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 5.0,
                        left: 20.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 180,
                            child: Text(
                              "Mã thẻ:",
                              style: TextStyle(
                                color: Color(0xFF8E4585),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            snapshot.data["cardCode"],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 5.0,
                        left: 20.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 180,
                            child: Text(
                              "Hạng thẻ:",
                              style: TextStyle(
                                color: Color(0xFF8E4585),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            snapshot.data["cardLevelName"],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 5.0,
                        left: 20.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 180,
                            child: Text(
                              "Điểm thẻ:",
                              style: TextStyle(
                                color: Color(0xFF8E4585),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            snapshot.data["pointCard"].toString(),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 5.0,
                        left: 20.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 180,
                            child: Text(
                              "Điểm thưởng:",
                              style: TextStyle(
                                color: Color(0xFF8E4585),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            snapshot.data["pointReward"].toString(),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future<Map<String, dynamic>> getCardInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return {
      "username": prefs.getString("fullName"),
      "cardCode": prefs.getString("cardCode") ?? "",
      "cardLevelName": prefs.getString("cardLevelName"),
      "pointReward": prefs.getDouble("pointReward"),
      "pointCard": prefs.getDouble("pointCard"),
    };
  }
}
