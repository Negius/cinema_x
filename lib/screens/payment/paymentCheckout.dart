import 'dart:convert';
import 'package:cinema_x/config/AppSettings.dart';
import 'package:cinema_x/screens/home/Home.dart';
import 'package:cinema_x/screens/payment/paymentNoti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PaymentCheckoutPage extends StatefulWidget {
  @override
  _PaymentCheckoutPageState createState() => _PaymentCheckoutPageState();
  PaymentCheckoutPage({@required this.url});
  final String url;
}

class _PaymentCheckoutPageState extends State<PaymentCheckoutPage> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPluginAfterPurchase;//
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPluginReview;//
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
    getUser();
    super.initState();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    
    flutterLocalNotificationsPluginAfterPurchase = new FlutterLocalNotificationsPlugin();//
    flutterLocalNotificationsPluginAfterPurchase.initialize(initializationSettings,
        onSelectNotification: onSelectPurchaseNotification);

    // flutterLocalNotificationsPluginReview = new FlutterLocalNotificationsPlugin();//
    // flutterLocalNotificationsPluginReview.initialize(initializationSettings,
    //     onSelectNotification: onSelectReviewNotification);
  }
  Future onSelectPurchaseNotification(String payload) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Giao dịch thành công"),
          content: Text('Bạn đã mua vé phim ${prefs.get("movieName")}, vị trí ghế ${prefs.getString("seat")}, khung giờ ${prefs.getString("time")} ngày ${prefs.getString('date')}')
        );
      },
    );
  }

  // Future onSelectReviewNotification(String payload) async {
  //   String comment = '';
  //   int _point = 0;
  //   return showDialog<String>(
  //       context: context,
  //       barrierDismissible:
  //           false, // dialog is dismissible with a tap on the barrier
  //       builder: (BuildContext context) {
  //         return StatefulBuilder(builder: (context, setState) {
  //           return AlertDialog(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: new BorderRadius.circular(15)),
  //             title: ListTile(
  //               title: Text(CommonString.rating),
  //             ),
  //             content: new Column(
  //               children: <Widget>[
  //                 new Row(
  //                   children: <Widget>[
  //                     new IconButton(
  //                       icon: _point >= 1
  //                           ? new Icon(
  //                               Icons.star,
  //                               color: Colors.amber,
  //                             )
  //                           : new Icon(Icons.star_border),
  //                       onPressed: () {
  //                         setState(() {
  //                           _point = 1;
  //                         });
  //                       },
  //                     ),
  //                     new IconButton(
  //                       icon: _point >= 2
  //                           ? new Icon(
  //                               Icons.star,
  //                               color: Colors.amber,
  //                             )
  //                           : new Icon(Icons.star_border),
  //                       onPressed: () {
  //                         setState(() {
  //                           _point = 2;
  //                         });
  //                       },
  //                     ),
  //                     new IconButton(
  //                       icon: _point >= 3
  //                           ? new Icon(
  //                               Icons.star,
  //                               color: Colors.amber,
  //                             )
  //                           : new Icon(Icons.star_border),
  //                       onPressed: () {
  //                         setState(() {
  //                           _point = 3;
  //                         });
  //                       },
  //                     ),
  //                     new IconButton(
  //                       icon: _point >= 4
  //                           ? new Icon(
  //                               Icons.star,
  //                               color: Colors.amber,
  //                             )
  //                           : new Icon(Icons.star_border),
  //                       onPressed: () {
  //                         setState(() {
  //                           _point = 4;
  //                         });
  //                       },
  //                     ),
  //                     new IconButton(
  //                       icon: _point >= 5
  //                           ? new Icon(
  //                               Icons.star,
  //                               color: Colors.amber,
  //                             )
  //                           : new Icon(Icons.star_border),
  //                       onPressed: () {
  //                         setState(() {
  //                           _point = 5;
  //                         });
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //                 new Expanded(
  //                     child: new TextField(
  //                   autofocus: true,
  //                   decoration:
  //                       new InputDecoration(hintText: CommonString.comment),
  //                   onChanged: (value) {
  //                     comment = value;
  //                   },
  //                 ))
  //               ],
  //             ),
  //             actions: <Widget>[
  //               FlatButton(
  //                 child: Text(
  //                   CommonString.cancel,
  //                   style: TextStyle(color: Colors.black26),
  //                 ),
  //                 onPressed: () {
  //                   Navigator.of(context).pop(comment);
  //                 },
  //               ),
  //               FlatButton(
  //                 child: Text(
  //                   CommonString.ok,
  //                   style: TextStyle(color: Colors.red[900]),
  //                 ),
  //                 onPressed: () {
  //                   onSubmitReview(context, comment, _point, payload);
  //                 },
  //               ),
  //             ],
  //           );
  //         });
  //       });
  // }

  void onSubmitReview(BuildContext context, comment, point, filmId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = NccUrl.createComment;

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

    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));

    if (response.statusCode == 200) {
      Navigator.of(context).pop(comment);
      await flutterLocalNotificationsPluginReview.cancel(1);//
    }
  }

  Future _scheduleNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '1', 'Schedule', 'your channel description',
        importance: Importance.High, priority: Priority.High);//
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    String dateWithT = prefs.get("endTime").substring(0, 8) +
        'T' +
        prefs.get("endTime").substring(8);
    var scheduledNotificationDateTime = DateTime.parse(dateWithT);

    await flutterLocalNotificationsPluginReview.schedule(//
        1,
        prefs.get("movieName"),
        CommonString.comment,
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
      body: FutureBuilder(
        future: _apiResult,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data);
              if (data["data"] == null || data["code"] == null) {
                print(data);
                return errorScreen(context);
              }
              return resultScreen(context, data["data"]["txnId"],
                  data["code"], data["message"]);
            } else {
              print("No data");
              return errorScreen(context);
            }
          } else {
            return Container();
          }
        },
      ),
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
            SizedBox(
              height: 100,
            ),
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
                      color: Colors.red[900],
                    ),
            ),
            Text(message,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 75,
            ),
            FlatButton(
              color: code == "00" ? Colors.green : Colors.redAccent,
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
                CommonString.homePage,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget errorScreen(BuildContext context) {
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
                color: Colors.red[900],
              ),
            ),
            Text(
              CommonString.commonError,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                CommonString.homePage,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
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
    String api = NccUrl.updateOrder + "OrderId=$id&OrderCode=$code";
    var response = await http.post(api);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      if (parsed.code == 00){
        _showNotificationWithoutSound();}
      // _scheduleNotification();
    }
    return response.body;
    //statuscode = 200, body: data{code: 30, data{txnID: orderId}}
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
      prefs.setDouble("pointReward", pr);
      prefs.setDouble("pointCard", pc);
    }}

  Future _showNotificationWithoutSound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '0', 'After Purchase', 'your channel description',
        playSound: false, importance: Importance.High, priority: Priority.High);
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPluginAfterPurchase.show(
      0,
      'Giao dịch thành công',
      'Bạn đã mua vé phim ${prefs.get("movieName")}, vị trí ghế ${prefs.getString("seat")}, khung giờ ${prefs.getString("time")} ngày ${prefs.getString('date')}',
      platformChannelSpecifics,
      payload: 'No_Sound',
    );
  }
}

