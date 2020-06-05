import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/config/AppSettings.dart';
import 'package:cinema_x/utils/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cinema_x/models/pointCard.dart';
import 'package:intl/intl.dart';

class PointCardPage extends StatefulWidget {
  @override
  _PointCardPageState createState() => _PointCardPageState();
}

class _PointCardPageState extends State<PointCardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String username;
  String cardCode;
  String cardLevelName;
  double pointReward;
  double pointCard;


  Future<List<PointHistory>> _pointCard;
  List pointDateList;
  List pointRewardChangeList;
  List pointCardChangeList;
  List changeReasonList;
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
 void getCardInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     username = prefs.getString("fullName");
     cardCode =  prefs.getString("cardCode") ?? "";
     cardLevelName = prefs.getString("cardLevelName");
     pointReward = prefs.getDouble("pointReward");
     pointCard = prefs.getDouble("pointCard");
  }
  @override
  void initState() {
    super.initState();
    _pointCard= fetchPointHistory();
    getCardInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      endDrawer: MenuBar(),
      appBar: new AppBar(
        title: new Text(CommonString.pointScreen),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
          ),
        ],
        backgroundColor: Colors.red[900],
      ),
      body: FutureBuilder(
          // future: _cardInfo,
          future: _pointCard,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              
                return Container(
                child: Wrap(
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
                              CommonString.cardLevel,
                              style: TextStyle(
                                color: Color(0xFF8E4585),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            cardLevelName,
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
                              CommonString.cardPoint,
                              style: TextStyle(
                                color: Color(0xFF8E4585),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            pointCard.toString(),
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
                              CommonString.rewardPoint,
                              style: TextStyle(
                                color: Color(0xFF8E4585),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            pointReward.toString(),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height:20),
                    Container(
                            //  child:Expanded(
                      height: 999.9,
                      child: ListView(
                        shrinkWrap: true,
                        children: (snapshot.data as List<PointHistory>).map((data) {
                          return GestureDetector(
                            child: Card(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                                      
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          AutoSizeText(
                                            DateFormat("hh:mm - dd/MM/yyyy ").format(
                                              DateTime.parse(data.pointDate) ?? "",
                                            ),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold, fontSize: 15),
                                            maxLines: 3,
                                          ),
                                          
                                          Text(CommonString.pointCardchange.replaceAll(
                                              "_value_", data.pointCardChange.toString())??"",
                                              style: TextStyle(fontSize: 16),
                                              ),
                                          Text(CommonString.pointRewardchange.replaceAll(
                                              "_value_", data.pointRewardChange.toString())??"",
                                              style: TextStyle(fontSize: 16),
                                              ),
                                          Row(
                                            children: <Widget>[
                                              AutoSizeText(
                                                CommonString.changeReason.replaceAll(
                                                    "_value_",
                                                    data.changeReason.toString())??"",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red[900]),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            
            } 
            else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },),
    );
  }

  
}