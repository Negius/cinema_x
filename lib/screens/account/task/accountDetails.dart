import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/screens/account/register_success.dart';
import 'package:cinema_x/screens/payment/validate_error.dart';
import 'package:cinema_x/utils/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AccountDetailsPage extends StatefulWidget {
  @override
  _AccountDetailsPageState createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  DateFormat df = new DateFormat("dd/MM/yyyy");
  bool _autoValidate = false;
  var formFields = {
    "_email": "Email",
    "_fName": "Tên",
    "_lName": "Họ",
    "_phone": "Điện thoại",
    "_address": "Địa chỉ",
  };
  var _id = "";
  var formValues = {
    "_fName": "",
    "_lName": "",
    "_phone": "",
    "_address": "",
    "_gender": "",
  };
  Future<Map<String, String>> _initValues;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    _initValues = setInitValues();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: MenuBar(),
      appBar: new AppBar(
        title: new Text('Thông tin chi tiết'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
          ),
        ],
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: <Widget>[
          FutureBuilder(
            future: _initValues,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _id = snapshot.data["_id"];
                return Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 60,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                          color: Color.fromRGBO(218, 214, 204, 1),
                          child: AutoSizeText(
                            "THÔNG TIN TÀI KHOẢN",
                            maxLines: 1,
                            minFontSize: 20,
                            style: TextStyle(
                              color: Color.fromARGB(132, 115, 99, 1),
                            ),
                          ),
                        ),
                        generateField("_email", snapshot.data["_email"]),
                        Container(
                          height: 60,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                          color: Color.fromRGBO(218, 214, 204, 1),
                          child: AutoSizeText(
                            "THÔNG TIN THÊM",
                            maxLines: 1,
                            minFontSize: 20,
                            style: TextStyle(
                              color: Color.fromARGB(132, 115, 99, 1),
                            ),
                          ),
                        ),
                        generateField("_lName", snapshot.data["_lName"]),
                        generateField("_fName", snapshot.data["_fName"]),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: TextFormField(
                            initialValue: df.format(
                                DateTime.parse(snapshot.data["_birth"])),
                            readOnly: true,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              labelText: formFields["_birth"],
                              labelStyle: new TextStyle(
                                  color: Colors.black26, fontSize: 15),
                              focusedBorder: new UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Giới tính",
                                  style: TextStyle(color: Colors.red),
                                ),
                                Container(
                                    padding: EdgeInsets.only(right: 0),
                                    child: Row(
                                      children: <Widget>[
                                        Radio(
                                          groupValue: formValues["_gender"],
                                          value: "M",
                                          onChanged: null,
                                        ),
                                        Text("Nam"),
                                        Radio(
                                          groupValue: formValues["_gender"],
                                          value: "F",
                                          onChanged: null,
                                        ),
                                        Text("Nữ"),
                                      ],
                                    ))
                              ]),
                        ),
                        Container(
                          height: 60,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                          color: Color.fromRGBO(218, 214, 204, 1),
                          child: AutoSizeText(
                            "LIÊN HỆ",
                            maxLines: 1,
                            minFontSize: 20,
                            style: TextStyle(
                              color: Color.fromARGB(132, 115, 99, 1),
                            ),
                          ),
                        ),
                        generateField("_phone", snapshot.data["_phone"]),
                        generateField("_address", snapshot.data["_address"]),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FlatButton(
                              padding: EdgeInsets.all(10),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5)),
                              color: Colors.redAccent,
                              child: AutoSizeText(
                                "Lưu thông tin",
                                minFontSize: 18,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  updateInfo(context);
                                });
                              },
                            ),
                            FlatButton(
                              padding: EdgeInsets.all(10),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5)),
                              color: Colors.grey,
                              child: AutoSizeText(
                                "Quay lại",
                                minFontSize: 18,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return Visibility(visible: false, child: Container());
              }
            },
          ),
          Visibility(
            child: Center(
              child: new CircularProgressIndicator(),
            ),
            visible: loading,
          ),
        ],
      ),
    );
  }

  Widget generateField(String type, String value) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextFormField(
        readOnly: ["_email", "_birth"].contains(type) ? true : false,
        onSaved: (value) => formValues[type] = value,
        initialValue: value,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
        keyboardType: type == "_phone"
            ? TextInputType.phone
            : type == "_birth"
                ? TextInputType.datetime
                : type == "_email"
                    ? TextInputType.emailAddress
                    : TextInputType.text,
        validator: (value) => validateForm(type, value),
        decoration: InputDecoration(
          labelText: formFields[type],
          labelStyle: new TextStyle(color: Colors.redAccent, fontSize: 18),
          focusedBorder: new UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }

  String validateForm(String type, String value) {
    RegExp emailRegex = new RegExp(
        r"^[a-z][a-z0-9_\.]{5,32}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$");
    RegExp phoneRegex = new RegExp(r"^[0-9]*$");

    switch (type) {
      case "_email":
        if (value.isEmpty)
          return ErrorEmail.isEmpty;
        else if (emailRegex.allMatches(value).isEmpty)
          return ErrorEmail.wrongFormat;
        else
          return null;
        break;
      case "_phone":
        return phoneRegex.allMatches(value).isEmpty
            ? "Số điện thoại không hợp lệ"
            : value.length < 9 ? "Số điện thoại không hợp lệ" : null;
      default:
        return null;
    }
  }

  Future<Map<String, String>> setInitValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      formValues["_gender"] = prefs.getString("gender");
    });
    return {
      "_email": prefs.getString("email"),
      "_id": prefs.getInt("customerId").toString(),
      "_fName": prefs.getString("firstName"),
      "_lName": prefs.getString("lastName"),
      "_phone": prefs.getString("phone"),
      "_address": prefs.getString("address"),
      "_birth": prefs.getString("birth"),
      "_gender": prefs.getString("gender"),
    };
  }

  void updateInfo(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final form = _formKey.currentState;
    form.save();
    if (form.validate()) {
      // var api =
      //     "http://testapi.chieuphimquocgia.com.vn/api/UpdateCustomer?customerId=$_id&FirstName=${Uri.encodeComponent(formValues["_fName"])}&LastName=${Uri.encodeComponent(formValues["_lName"])}&Mobile=${Uri.encodeComponent(formValues["_phone"])}&Address=${Uri.encodeComponent(formValues["_address"])}";
      var api = "http://testapi.chieuphimquocgia.com.vn/api/UpdateCustomer?";
      print(formValues);
      var body = [
        "customerId=$_id",
        "FirstName=${Uri.encodeComponent(formValues["_fName"])}",
        "LastName=${Uri.encodeComponent(formValues["_lName"])}",
        "phone=${Uri.encodeComponent(formValues["_phone"])}",
        "address=${Uri.encodeComponent(formValues["_address"])}",
      ];

      api += body.join("&");
      print(Uri.parse(api));
      var response = await http.post(Uri.parse(api));
      // var response = await http.post(Uri.parse(api));
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        var code = int.parse(body["code"]);
        var status = body["message"];
        if (code == 30) {
          prefs.setString(
              "fullName", formValues["_lName"] + " " + formValues["_fName"]);
          prefs.setString("firstName", formValues["_fName"]);
          prefs.setString("lastName", formValues["_lName"]);
          prefs.setString("phone", formValues["_phone"]);
          prefs.setString("address", formValues["_address"]);
        }
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RegisterSuccessPage(code: code, message: status)));
        });
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
