import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/screens/account/register_success.dart';
import 'package:cinema_x/screens/payment/validate_error.dart';
import 'package:cinema_x/utils/menu_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;
  bool _showPass = false;
  DateTime selectedDate = DateTime.now();
  DateFormat df = new DateFormat("dd/MM/yyyy");
  final passController = TextEditingController();
  final birthdayController = TextEditingController();
  var formFields = {
    "_id": "Tên đăng nhập",
    "_email": "Email",
    "_password": "Mật khẩu",
    "_retype": "Nhập lại mật khẩu",
    "_fName": "Tên",
    "_lName": "Họ",
    "_birth": "Ngày sinh",
    "_phone": "Điện thoại",
    "_address": "Địa chỉ",
  };

  var formValues = {
    "_id": "",
    "_email": "",
    "_password": "",
    "_retype": "",
    "_fName": "",
    "_lName": "",
    "_birth": "",
    "_phone": "",
    "_address": "",
    "_gender": ""
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MenuBar(),
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('Đăng ký tài khoản'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
          ),
        ],
        backgroundColor: Colors.red,
      ),
      //  resizeToAvoidBottomPadding: false,
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Form(
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
                generateField("_email"),
                generateField("_id"),
                generatePasswordField("_password"),
                generatePasswordField("_retype"),
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
                generateField("_lName"),
                generateField("_fName"),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      TextFormField(
                        onSaved: (value) =>
                            formValues["_birth"] = selectedDate.toString(),
                        controller: birthdayController,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        readOnly: true,
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
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Giới tính"),
                        Container(
                            padding: EdgeInsets.only(right: 0),
                            child: Row(
                              children: <Widget>[
                                Radio(
                                  groupValue: formValues["_gender"],
                                  value: "M",
                                  onChanged: (val) {
                                    setState(() {
                                      formValues["_gender"] = val;
                                    });
                                  },
                                ),
                                Text("Nam"),
                                Radio(
                                  groupValue: formValues["_gender"],
                                  value: "F",
                                  onChanged: (val) {
                                    setState(() {
                                      formValues["_gender"] = val;
                                    });
                                  },
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
                generateField("_phone"),
                generateField("_address"),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: RaisedButton(
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        onRegisterClicked(context);
                      });
                    },
                    child: Text(
                      "Đăng ký",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget generateField(String type) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextFormField(
        onSaved: (value) => formValues[type] = value,
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
          labelStyle: new TextStyle(color: Colors.black26, fontSize: 15),
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

  Widget generatePasswordField(String type) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: <Widget>[
          TextFormField(
            onSaved: (value) => formValues[type] = value,
            style: TextStyle(fontSize: 20, color: Colors.black),
            obscureText: !_showPass,
            validator: (value) => validateForm(type, value),
            controller: type == "_password" ? passController : null,
            decoration: InputDecoration(
              labelText: formFields[type],
              labelStyle: TextStyle(color: Colors.black26, fontSize: 15),
              focusedBorder: new UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.red, width: 1.0, style: BorderStyle.solid),
              ),
            ),
          ),
          GestureDetector(
            onTap: onToggleShowPass,
            child: Text(
              _showPass ? "Ẩn" : "Hiện",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  String validateForm(String type, String value) {
    RegExp emailRegex = new RegExp(
        r"^[a-z][a-z0-9_\.]{5,32}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$");
    RegExp phoneRegex = new RegExp(r"^[0-9]*$");

    switch (type) {
      case "_id":
        if (value.isEmpty)
          return ErrorId.isEmpty;
        else if (value.length < 6 || value.length > 15)
          return ErrorId.wrongLength;
        else
          return null;
        break;
      case "_email":
        if (value.isEmpty)
          return ErrorEmail.isEmpty;
        else if (emailRegex.allMatches(value).isEmpty)
          return ErrorEmail.wrongFormat;
        else
          return null;
        break;
      case "_password":
        if (value.isEmpty)
          return ErrorPassword.isEmpty;
        // else if (RegexPassword().digit.allMatches(value).isEmpty)
        //   return ErrorPassword.digit;
        // else if (RegexPassword().lower.allMatches(value).isEmpty)
        //   return ErrorPassword.lower;
        // else if (RegexPassword().upper.allMatches(value).isEmpty)
        //   return ErrorPassword.upper;
        // else if (RegexPassword().special.allMatches(value).isEmpty)
        //   return ErrorPassword.special;
        else if (value.length < 8)
          return ErrorPassword.length;
        else
          return null;
        break;
      case "_retype":
        var _pass = passController.text;
        return _pass == value ? null : "Mật khẩu nhập lại không trùng khớp";
      case "_phone":
        return phoneRegex.allMatches(value).isEmpty
            ? "Số điện thoại không hợp lệ"
            : value.length < 9 ? "Số điện thoại không hợp lệ" : null;
      default:
        return null;
    }
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    // final DateTime picked = await showDatePicker(
    //     context: context,
    //     initialDate: selectedDate,
    //     firstDate: DateTime(1950, 8),
    //     lastDate: DateTime(2101));
    // if (picked != null && picked != selectedDate)
    //   setState(() {
    //     selectedDate = picked;
    //     birthdayController.text = df.format(picked.toLocal());
    //   });
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).copyWith().size.height / 2,
                  child: Localizations.override(
                    context: context,
                    locale: const Locale('vi'),
                    child: CupertinoDatePicker(
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (DateTime newdate) {
                        setState(() {
                          selectedDate = newdate;
                        });
                      },
                      use24hFormat: true,
                      minimumYear: 1950,
                      maximumDate: DateTime.now(),
                      maximumYear: DateTime.now().year,
                      minuteInterval: 1,
                      mode: CupertinoDatePickerMode.date,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Text("Thoát"),
                      onPressed: () {
                        setState(() {
                          if (birthdayController.text != null &&
                              birthdayController.text.isNotEmpty) {
                            selectedDate = DateFormat("dd/MM/yyyy")
                                .parse(birthdayController.text);
                          } else {
                            selectedDate = DateTime.now();
                          }
                        });
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    ),
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        setState(() {
                          birthdayController.text =
                              df.format(selectedDate.toLocal());
                        });
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  void onRegisterClicked(BuildContext context) async {
    final form = _formKey.currentState;
    form.save();

    if (form.validate()) {
      var api = "http://testapi.chieuphimquocgia.com.vn/api/Register";
      print(api);
      var body = {
        "Username": formValues["_id"],
        "Email": formValues["_email"],
        "Password": formValues["_password"],
        "FirstName": formValues["_fName"],
        "LastName": formValues["_lName"],
        "BirthDay": formValues["_birth"],
        "Mobile": formValues["_phone"],
        "Address": formValues["_address"],
        "Sex": formValues["_gender"]
      };
      print(body);
      var response = await http.post(api, body: body);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        var code = body["StatusCode"];
        var status = body["Status"];
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterSuccessPage(
                code: code,
                message: status,
              ),
            ),
          );
        });
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
