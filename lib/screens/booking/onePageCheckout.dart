import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/config/AppSettings.dart';
import 'package:cinema_x/models/Movie.dart';
import 'package:cinema_x/screens/payment/paymentIndex.dart';
import 'package:cinema_x/utils/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:http/http.dart' as http;

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
    "vnpay": CommonString.paymentNameVnpay,
    "payoo": CommonString.paymentNamePayoo,
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
        title: Text(CommonString.checkout),
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
                          "${CommonString.projectDate}: ${DateFormat("dd/MM/yyyy").format(widget.projectDateTime)}",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        AutoSizeText(
                          "${CommonString.projectTime}: ${DateFormat("hh:mm").format(widget.projectDateTime)} ~ ${DateFormat("hh:mm").format(widget.projectDateTime.add(new Duration(minutes: widget.movie.duration)))}",
                          style: TextStyle(fontSize: 16),
                        ),
                        AutoSizeText(
                          "${CommonString.seat}: ${widget.label}",
                          style: TextStyle(
                              color: Color.fromARGB(132, 115, 99, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        AutoSizeText(
                          "${CommonString.total}: ${widget.total} đ",
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
                            CommonString.ticketInfo,
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
                                CommonString.seatAmount,
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
                                CommonString.seatLabel,
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
                                CommonString.total,
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
                            CommonString.choosePayment,
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
              CommonString.accept1,
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
                    CommonString.accept2,
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

    var cFirstName = prefs.getString("firstName");
    var cLastName = prefs.getString("lastName");
    var cEmail = prefs.getString("email");
    var cPhone = prefs.getString("phone");

    prefs.setInt("movieId", widget.movie.id);
    prefs.setString("movieName", widget.movie.name);
    prefs.setString(
        "endTime",
        DateFormat("yyyyMMddHHmmss").format(widget.projectDateTime
            .add(Duration(minutes: widget.movie.duration))));
    switch (_current) {
      case 0:
        DateTime now = DateTime.now();
        String vnpCreateDate = DateFormat('yyyyMMddkkmmss').format(now);
        // String ipAddress = await GetIp.ipAddress;
        String ipAddress = "118.70.117.56";
        String vnpHashSecret = AppSettings.vnpayHashSecret;
        String inforSendVNPay = "$cLastName $cFirstName;$cEmail;$cPhone";
        String url = PaymentUrl.vnpayInit;
        String _requestData = "";


        Map<String, dynamic> body = {
          "vnp_Amount": widget.total * 100,
          "vnp_Command": "pay",
          "vnp_CreateDate": vnpCreateDate,
          "vnp_CurrCode": "VND",
          "vnp_IpAddr": ipAddress,
          "vnp_Locale": "vn",
          // "vnp_Merchant": "DEMO",
          "vnp_OrderInfo": removeUnicode(inforSendVNPay),
          "vnp_OrderType": "filmticket",
          "vnp_ReturnUrl": PaymentUrl.vnpayResult,
          "vnp_TmnCode": AppSettings.vnpayTmnCode,
          "vnp_TxnRef": widget.orderId.toString(),
          "vnp_Version": "2.0.0",
        };
        _requestData = transformBodyVNPay(body);
        body["vnp_IpAddr"] = Uri.encodeComponent(ipAddress);
        body["vnp_OrderInfo"] =
            Uri.encodeComponent(removeUnicode(inforSendVNPay));
        body["vnp_ReturnUrl"] = Uri.encodeComponent(PaymentUrl.vnpayResult);

        var data = transformBodyVNPay(body);
        var trimmed = _requestData.substring(0, _requestData.length - 1);
        var trimmed2 = data.substring(0, data.length - 1);
        var vnpSecureHash = generateMd5(vnpHashSecret + trimmed);
        url += trimmed2 +
            "&vnp_SecureHashType=MD5&vnp_SecureHash=" +
            vnpSecureHash;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentIndexPage(
              url: url,
            ),
          ),
        );
        break;

      case 1:
        //Sandbox, thay = url thật sau khi test
        String url = PaymentUrl.payooInit;

        var planInfo =
            "Phim: ${widget.movie.name}, Suất chiếu: ${DateFormat("HH:mm").format(widget.projectDateTime)}";

        var data = {
          "Session": widget.orderId.toString(),
          "BusinessUsername": "iss_PhimQuocGia",
          "OrderCashAmount": widget.total,
          "OrderNo": widget.orderId,
          "ShippingDays": 1,
          "ShopBackUrl": PaymentUrl.payooResult,
          "ShopDomain": "http://localhost",
          "ShopID": 1061,
          "ShopTitle": "PhimQuocGia",
          "StartShippingDate": DateFormat("dd/MM/yyyy").format(DateTime.now()),
          "NotifyUrl": "",
          "ValidityTime": DateFormat("yyyyMMddHHmmss")
              .format(DateTime.now().add(Duration(days: 1))),
          "OrderDescription": Uri.encodeComponent(planInfo),
          "CustomerName": Uri.encodeComponent("$cLastName $cFirstName"),
          "CustomerPhone": cPhone,
          "CustomerEmail": cEmail,
          "CustomerCity": "",
          "CustomerAddress": "",
        };

        String checksumKey = AppSettings.checksumPayoo;
        // String APIUsername = "iss_PhimQuocGia_BizAPI";
        // String APIPassword = "9zom6iIJvUjNJSjy";
        // String APISignature =
        //     "3m0P3urXfwsxDgPlNJ29oR5GnvXTottopIERGVkT5oUAMERSLY6KjxZM4T8WB1s3";

        var xml = transformBodyPayoo(data);

        var checkSum = generateSHA512(checksumKey + xml);

        var body = {
          "data": xml,
          "checksum": checkSum,
          "refer": "http://localhost",
          "restrict": "0",
        };
        print(checkSum);
        var response = await http.post(Uri.parse(url), body: body);
        if (response.statusCode == 200) {
          var resultData = json.decode(response.body);
          if (resultData["result"] == "success") {
            var url2 = Uri.decodeFull(resultData["order"]["payment_url"]);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentIndexPage(
                  url: url2,
                ),
              ),
            );
          }
        }
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

  String generateSHA512(String data) {
    var sha512 = crypto.sha512;
    var digest = sha512.convert(data.codeUnits);
    return hex.encode(digest.bytes);
  }

  String transformBodyVNPay(Map<String, dynamic> input) {
    var result = "";
    input.entries.forEach((entry) {
      result += entry.key +
          "=" +
          (entry.value is String ? entry.value : entry.value.toString()) +
          "&";
    });
    return result;
  }

  String transformBodyPayoo(Map<String, dynamic> input) {
    try {
      if (input == null) throw Exception("Order parameters are not set.");
      String part1 = """<shops>
                    <shop>
                      <session>${input["Session"]}</session>
                      <username>${input["BusinessUsername"]}</username>
                      <shop_id>${input["ShopID"]}</shop_id>
                      <shop_title>${input["ShopTitle"]}</shop_title>
                      <shop_domain>${input["ShopDomain"]}</shop_domain>
                      <shop_back_url>${input["ShopBackUrl"]}</shop_back_url>
                      <order_no>${input["OrderNo"]}</order_no>
                      <order_cash_amount>${input["OrderCashAmount"]}</order_cash_amount>
                      <order_ship_date>${input["StartShippingDate"]}</order_ship_date>
                      <order_ship_days>${input["ShippingDays"]}</order_ship_days>
                      <order_description>${input["OrderDescription"]}</order_description>
                      <notify_url>${input["NotifyUrl"]}</notify_url>""";
      String part2 = """<customer>
                        <name>${input["CustomerName"]}</name>
                        <phone>${input["CustomerPhone"]}</phone>
                        <address>${input["CustomerAddress"]}</address>
                        <city>${input["CustomerCity"]}</city>
                        <email>${input["CustomerEmail"]}</email>
                      </customer>
                    </shop>
                  </shops>""";

      return part1 +
          ("""<validity_time>${input["ValidityTime"]}</validity_time>""" ??
              """""") +
          part2;
    } on Exception catch (e) {
      throw e;
    }
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
