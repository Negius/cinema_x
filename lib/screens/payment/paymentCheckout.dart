import 'dart:convert';
import 'package:cinema_x/screens/home/Home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart';

class PaymentCheckoutPage extends StatefulWidget {
  @override
  _PaymentCheckoutPageState createState() => _PaymentCheckoutPageState();
  PaymentCheckoutPage({@required this.url});
  final String url;
}
class _PaymentCheckoutPageState extends State<PaymentCheckoutPage> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  Map<String, String> params;
  int statusCode = -1;
  int orderId = 0;
  Future<String> _apiResult;
  @override
  void initState() {
    params = decode(widget.url);
    print(params);
    print(params["vnp_ResponseCode"].runtimeType);
    print(params["vnp_TxnRef"].runtimeType);
    statusCode = int.parse(params["vnp_ResponseCode"] ?? "-1");
    orderId = int.parse(params["vnp_TxnRef"] ?? "0");
    _apiResult = callApi(statusCode, orderId);
    super.initState();
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    String comment = '';
    int _point = 0;
    return showDialog<String>(
        context: context,
        barrierDismissible:
        false, // dialog is dismissible with a tap on the barrier
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape:
              RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
              title: ListTile(
                title: Text('Đánh giá phim'),
              ),
              content: new Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new IconButton(
                        icon: _point >= 1
                            ? new Icon(
                          Icons.star,
                          color: Colors.amber,
                        )
                            : new Icon(Icons.star_border),
                        onPressed: () {
                          setState(() {
                            _point = 1;
                          });
                        },
                      ),
                      new IconButton(
                        icon: _point >= 2
                            ? new Icon(
                          Icons.star,
                          color: Colors.amber,
                        )
                            : new Icon(Icons.star_border),
                        onPressed: () {
                          setState(() {
                            _point = 2;
                          });
                        },
                      ),
                      new IconButton(
                        icon: _point >= 3
                            ? new Icon(
                          Icons.star,
                          color: Colors.amber,
                        )
                            : new Icon(Icons.star_border),
                        onPressed: () {
                          setState(() {
                            _point = 3;
                          });
                        },
                      ),
                      new IconButton(
                        icon: _point >= 4
                            ? new Icon(
                          Icons.star,
                          color: Colors.amber,
                        )
                            : new Icon(Icons.star_border),
                        onPressed: () {
                          setState(() {
                            _point = 4;
                          });
                        },
                      ),
                      new IconButton(
                        icon: _point >= 5
                            ? new Icon(
                          Icons.star,
                          color: Colors.amber,
                        )
                            : new Icon(Icons.star_border),
                        onPressed: () {
                          setState(() {
                            _point = 5;
                          });
                        },
                      ),
                    ],
                  ),
                  new Expanded(
                      child: new TextField(
                        autofocus: true,
                        decoration: new InputDecoration(hintText: 'Nhận xét'),
                        onChanged: (value) {
                          comment = value;
                        },
                      ))
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black26),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(comment);
                  },
                ),
                FlatButton(
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    onSubmitReview(context, comment, _point, payload);
                  },
                ),
              ],
            );
          });
        });
  }

  void onSubmitReview(BuildContext context, comment, point, filmId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String api = 'http://testapi.chieuphimquocgia.com.vn/api/CreateFilmComment';
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    var body = {
      "CustomerId": prefs.get("customerId"),
      "FilmId": int.parse(filmId),
      "IsApproved": true,
      "Title": '',
      "ReviewText": comment,
      "Rating": point,
      "HelpfulYesTotal": 0,
      "HelpfulNoTotal": 0,
      "CreatedOnUtc": DateTime.now().toString(),
      "IsDisabled": true
    };
    print(body);
    var response = await http.post(Uri.parse(api),
        headers: headers, body: json.encode(body));
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.of(context).pop(comment);
      await flutterLocalNotificationsPlugin.cancel(0);
//      Map parsed = json.decode(response.body);
    }
  }

  _scheduleNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    String dateWithT = prefs.get("endTime").substring(0, 8) + 'T' + prefs.get("endTime").substring(8);
    var scheduledNotificationDateTime = DateTime.parse(dateWithT);
    print(scheduledNotificationDateTime);

    await flutterLocalNotificationsPlugin.schedule(
        0,
        prefs.get("movieName"),
        'Nhận xét phim',
        scheduledNotificationDateTime,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        payload: prefs.get("movieId").toString());
  }

  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return Scaffold(
      // endDrawer: MenuBar(),
      // key: _scaffoldKey,
      body: Column(children: <Widget>[
        FutureBuilder(
          future: _apiResult,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data);
              if (data["data"] == null || data["code"] == null)
                return errorScreen(context);
              return resultScreen(context, data["data"]["txnId"], data["code"],
                  data["message"]);
            } else {
              return errorScreen(context);
            }
          },
        ),
        SizedBox(
          height: 75,
        ),
        FlatButton(
          color: Colors.redAccent,
          onPressed: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            });
          },
          child: Text(
            "Trang chủ",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        )
      ]),
    );
  }
  Widget resultScreen(
      BuildContext context, String orderId, String code, String message) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: code == "00"
                  ? Icon(
                Icons.check_circle,
                size: 200,
                color: Colors.green,
              )
                  : Icon(
                Icons.error,
                size: 200,
                color: Colors.red,
              ),
            ),
            Text(message,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
  Widget errorScreen(BuildContext context) {
    print("failed");
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).copyWith().size.width / 10,
            ),
            Container(
              child: Icon(
                Icons.error,
                size: 200,
                color: Colors.red,
              ),
            ),
            Text(
              "Đã có lỗi xảy ra",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
  Map<String, String> decode(String url) {
    var params = url.split("?").last.split("&");
    var result = Map.fromIterable(params,
        key: (p) => p.split("=")[0].toString(),
        value: (p) => p.split("=")[1].toString());
    return result;
  }
  Future<String> callApi(int code, int id) async {

    String api =
        "http://testapi.chieuphimquocgia.com.vn/api/UpdateOrderPaymentApp?OrderId=$id&OrderCode=$code";
    var response = await http.post(api);
    print(response.statusCode);
    print(response.body);
    _scheduleNotification();
    if(response.statusCode == 200) {
      _scheduleNotification();
    }
    return response.body;
    //statuscode = 200, body: data{code: 30, data{txnID: orderId}}
  }
}