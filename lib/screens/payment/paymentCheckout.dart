import 'dart:convert';

import 'package:cinema_x/screens/home/Home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaymentCheckoutPage extends StatefulWidget {
  @override
  _PaymentCheckoutPageState createState() => _PaymentCheckoutPageState();
  PaymentCheckoutPage({@required this.url});
  final String url;
}

class _PaymentCheckoutPageState extends State<PaymentCheckoutPage> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
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
        // new Positioned(
        //   top: 0.0,1
        //   left: 0.0,
        //   right: 0.0,
        //   child: AppBar(
        //     backgroundColor: Colors.transparent,
        //     leading: IconButton(
        //       icon: Icon(Icons.home),
        //       onPressed: () => Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => HomeScreen(),
        //         ),
        //       ),
        //     ),
        //     actions: <Widget>[
        //       IconButton(
        //         icon: Icon(Icons.menu),
        //         onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
        //       ),
        //     ],
        //   ),
        // ),
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

    return response.body;
  }
}
