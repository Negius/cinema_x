import 'dart:async';
import 'package:cinema_x/screens/booking/onePageCheckout.dart';
import 'package:cinema_x/screens/home/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:cinema_x/config/AppSettings.dart';
import 'package:cinema_x/screens/payment/paymentCheckout.dart';
import 'package:cinema_x/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
//payment index temp
class PaymentIndexPage extends StatefulWidget {
  PaymentIndexPage({@required this.url}) : super();
  final String url;
  @override
  _PaymentIndexPageState createState() => _PaymentIndexPageState();
}

class _PaymentIndexPageState extends State<PaymentIndexPage>{
  InAppWebViewController webView;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _cancelConfirm,
      child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text('Thanh toán'),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context)),
      ),
      body: InAppWebView(
        initialUrl: widget.url,
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
              debuggingEnabled: true,
          )
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          webView = controller;
        },
        onLoadStart: (InAppWebViewController controller, String url) {
          if (url.contains("CheckOut/")) {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentCheckoutPage(
                                url: url,
                              )));
                });
              }
            },
        )
    ));
  }

  Future _cancelOrder() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var order = prefs.getInt("orderId");
    String url = NccUrl.cancelOrder + order.toString();
    final response = await http.post(url);
    if(response.statusCode == 200){
      // _cancelSelection(prefs);
      // Navigator.pop(context);
      print('nani');
    }
  }

    Future<bool> _cancelConfirm() async{
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Bạn có chắc chắn không muốn tiếp tục đặt vé ?'),
          actions: [
            FlatButton(
              onPressed: ()=>Navigator.of(context).pop(false), 
              child: Text('TIẾP TỤC')),
            FlatButton(
              onPressed: (){
                _cancelOrder();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
              }, 
              child: Text('HUỶ'))
          ],
        );
      });
  }
  
}