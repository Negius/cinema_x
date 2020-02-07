import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/models/Movie.dart';
import 'package:cinema_x/screens/payment/paymentIndex.dart';
import 'package:cinema_x/utils/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get_ip/get_ip.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;

class CheckoutPage extends StatefulWidget {
  CheckoutPage(
      {this.movie, this.projectDateTime, this.label, this.total, this.orderId});

  final int total;
  final Movie movie;
  final int orderId;
  final DateTime projectDateTime;
  final String label;
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final textColor = Color(0xCC000000);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _current = 0;
  final paymentMethods = {
    // "momo": "Ví MoMo",
    "vnpay": "VNPAY - Cổng thanh toán điện tử",
    "payoo": "Thanh toán online qua Payoo",
    // "atm": "Thẻ ATM (Thẻ nội địa)",
    // "visa": "Thẻ quốc tế (VISA, Mastercard)",
    // "airpay": "AirPay"
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MenuBar(),
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Thanh toán"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Image.network(widget.movie.imageUrl),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AutoSizeText(
                          "${widget.movie.name}",
                          maxLines: 1,
                          style: Theme.of(context).textTheme.body1.copyWith(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        AutoSizeText(
                          widget.movie.description,
                          style: TextStyle(color: Colors.red),
                        ),
                        AutoSizeText(
                          "Ngày chiếu: ${DateFormat("dd/MM/yyyy").format(widget.projectDateTime)}",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        AutoSizeText(
                          "Thời gian: ${DateFormat("hh:mm").format(widget.projectDateTime)} ~ ${DateFormat("hh:mm").format(widget.projectDateTime.add(new Duration(minutes: widget.movie.duration)))}",
                          style: TextStyle(fontSize: 16),
                        ),
                        AutoSizeText(
                          "Ghế: ${widget.label}",
                          style: TextStyle(
                              color: Color.fromARGB(132, 115, 99, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        AutoSizeText(
                          "Tổng cộng: ${widget.total} đ",
                          style: TextStyle(
                              color: Color.fromRGBO(173, 43, 50, 1),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                      // decoration: BoxDecoration(
                      //   color: Colors.red[50],
                      // ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                      Container(
                        height: 50,
                        color: Color.fromRGBO(218, 214, 204, 1),
                        child: Center(
                          child: Text(
                            "Thông tin vé",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black, width: 0.3)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Số lượng",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                widget.label.split(",").length.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Vị trí ghế",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                widget.label,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black, width: 0.3)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Tổng",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "${widget.total} VNĐ",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // paymentMethodRows("zalopay"),
                      Container(
                        height: 50,
                        color: Color.fromRGBO(218, 214, 204, 1),
                        child: Center(
                          child: Text(
                            "Phương thức thanh toán",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ] +
                    paymentMethods.keys
                        .map(
                          (key) => RadioListTile(
                            value: paymentMethods.keys.toList().indexOf(key),
                            groupValue: _current,
                            title: paymentMethodRows(key),
                            onChanged: (val) {
                              setState(() {
                                _current = val;
                              });
                            },
                          ),
                        )
                        .toList() +
                    [confirmButton(context)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget paymentMethodRows(String name) {
    String url = "assets/images/payment/$name.png";
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Image.asset(url),
          ),
        ),
        Expanded(
          flex: 8,
          child: Center(
            child: Text(paymentMethods[name]),
          ),
        ),
      ],
    );
  }

  Widget confirmButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      padding: EdgeInsets.only(top: 10),
      color: Colors.grey,
      child: Column(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: AutoSizeText(
              "Tôi đồng ý với Điều khoản Sử dụng và đang mua vé cho người có độ tuổi thích hợp",
              maxLines: 2,
              minFontSize: 17,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () => checkOut(context),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                child: Center(
                  child: (AutoSizeText(
                    "Tôi đồng ý và tiếp tục",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("movieId", widget.movie.id);
    prefs.setString("movieName", widget.movie.name);
    prefs.setString("endTime",DateFormat("yyyyMMddHHmmss").format(widget.projectDateTime.add(Duration(minutes: widget.movie.duration))));
    print(_current);
    switch (_current) {
      case 0:
        DateTime now = DateTime.now();
        String vnp_CreateDate = DateFormat('yyyyMMddkkmmss').format(now);
        String ipAddress = await GetIp.ipAddress;
        String _vnp_HashSecret = "IPCYRCERGNCBFGRYXUBYSWTDCEPHWGUZ";
        String inforSendVNPay = prefs.getString("lastName") +
            " " +
            prefs.getString("firstName") +
            ";" +
            prefs.getString("email") +
            ";" +
            prefs.getString("phone");

        String api = "http://sandbox.vnpayment.vn/paymentv2/vpcpay.html?";
        String _requestData = "";
        Map<String, String> headers = {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        };

        Map<String, dynamic> body = {
          "vnp_Amount": widget.total * 100,
          "vnp_Command": "pay",
          "vnp_CreateDate": vnp_CreateDate,
          "vnp_CurrCode": "VND",
          "vnp_IpAddr": ipAddress,
          "vnp_Locale": "vn",
          // "vnp_Merchant": "DEMO",
          "vnp_OrderInfo": removeUnicode(inforSendVNPay),
          "vnp_OrderType": "filmticket",
          "vnp_ReturnUrl": "http://172.16.80.120/CheckOut/VNPayResult",
          "vnp_TmnCode": "DXUMNOYW",
          "vnp_TxnRef": widget.orderId.toString(),
          "vnp_Version": "2.0.0",
        };
        _requestData = transformBody(body);
        body["vnp_IpAddr"] = Uri.encodeComponent(ipAddress);
        body["vnp_OrderInfo"] =
            Uri.encodeComponent(removeUnicode(inforSendVNPay));
        body["vnp_ReturnUrl"] =
            Uri.encodeComponent("http://172.16.80.120/CheckOut/VNPayResult");

        var data = transformBody(body);
        var trimmed = _requestData.substring(0, _requestData.length - 1);
        print(trimmed);
        var trimmed2 = data.substring(0, data.length - 1);
        var vnpSecureHash = generateMd5(_vnp_HashSecret + trimmed);
        api += trimmed2 +
            "&vnp_SecureHashType=MD5&vnp_SecureHash=" +
            vnpSecureHash;
        print(api);
        // var response = await http.get(Uri.parse(api));
        // print(response.statusCode);
        // print(response.body);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentIndexPage(
              url: api,
            ),
          ),
        );
        break;

      case 1:
      String api = "https://newsandbox.payoo.com.vn/v2/paynow/"; //Sandbox, thay = url thật sau khi test
        break;
      default:
        break;
    }
  }

  String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  String transformBody(Map<String, dynamic> input) {
    var result = "";
    input.entries.forEach((entry) {
      result += entry.key +
          "=" +
          (entry.value is String ? entry.value : entry.value.toString()) +
          "&";
    });
    return result;
  }

  String removeUnicode(String text) {
    List<String> arr1 = [
      "á",
      "à",
      "ả",
      "ã",
      "ạ",
      "â",
      "ấ",
      "ầ",
      "ẩ",
      "ẫ",
      "ậ",
      "ă",
      "ắ",
      "ằ",
      "ẳ",
      "ẵ",
      "ặ",
      "đ",
      "é",
      "è",
      "ẻ",
      "ẽ",
      "ẹ",
      "ê",
      "ế",
      "ề",
      "ể",
      "ễ",
      "ệ",
      "í",
      "ì",
      "ỉ",
      "ĩ",
      "ị",
      "ó",
      "ò",
      "ỏ",
      "õ",
      "ọ",
      "ô",
      "ố",
      "ồ",
      "ổ",
      "ỗ",
      "ộ",
      "ơ",
      "ớ",
      "ờ",
      "ở",
      "ỡ",
      "ợ",
      "ú",
      "ù",
      "ủ",
      "ũ",
      "ụ",
      "ư",
      "ứ",
      "ừ",
      "ử",
      "ữ",
      "ự",
      "ý",
      "ỳ",
      "ỷ",
      "ỹ",
      "ỵ"
    ];
    List<String> arr2 = [
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "d",
      "e",
      "e",
      "e",
      "e",
      "e",
      "e",
      "e",
      "e",
      "e",
      "e",
      "e",
      "i",
      "i",
      "i",
      "i",
      "i",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "u",
      "u",
      "u",
      "u",
      "u",
      "u",
      "u",
      "u",
      "u",
      "u",
      "u",
      "y",
      "y",
      "y",
      "y",
      "y"
    ];
    var result = new List<String>();
    result.add(text);
    for (int i = 0; i < arr1.length; i++) {
      result.add(result.last.replaceAll(arr1[i], arr2[i]));
      result.add(
          result.last.replaceAll(arr1[i].toUpperCase(), arr2[i].toUpperCase()));
    }
    return result.last;
  }
}

enum paymentEnums { vnpay }
