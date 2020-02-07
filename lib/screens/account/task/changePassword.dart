import 'dart:convert';

import 'package:cinema_x/utils/procedure_result.dart';
import 'package:cinema_x/utils/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePageState createState() => _ChangePageState();
}

class _ChangePageState extends State<ChangePasswordPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final passController = TextEditingController();
  String _oldPassword;
  String _newPassword;
  String _retype;
  bool _showPass = false;
  int statusCode = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MenuBar(),
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('Thay đổi mật khẩu'),
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
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
                child: Container(
                  width: 70,
                  height: 70,
                  padding: EdgeInsets.all(15),
                  child: Image.asset("assets/images/logo_home.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: Visibility(
                  child: Text(
                    "Tài khoản không tồn tại!",
                    style: TextStyle(color: Colors.red),
                  ),
                  visible: (statusCode == 40),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    TextFormField(
                      onSaved: (value) => _oldPassword = value,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      obscureText: !_showPass,
                      decoration: InputDecoration(
                        labelText: "Mật khẩu hiện tại",
                        labelStyle:
                            TextStyle(color: Colors.black26, fontSize: 15),
                        focusedBorder: new UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                              style: BorderStyle.solid),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //     onTap: onToggleShowPass,
                    //     child: Text(
                    //       _showPass ? "Ẩn" : "Hiện",
                    //       style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 13,
                    //           fontWeight: FontWeight.bold),
                    //     ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    TextFormField(
                      onSaved: (value) => _newPassword = value,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      controller: passController,
                      validator: (value) {
                        if (value.length < 8)
                          return "Mật khẩu mới phải dài ít nhất 8 ký tự";
                        else
                          return null;
                      },
                      obscureText: !_showPass,
                      decoration: InputDecoration(
                        labelText: "Mật khẩu mới",
                        labelStyle:
                            TextStyle(color: Colors.black26, fontSize: 15),
                        focusedBorder: new UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                              style: BorderStyle.solid),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //     onTap: onToggleShowPass,
                    //     child: Text(
                    //       _showPass ? "Ẩn" : "Hiện",
                    //       style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 13,
                    //           fontWeight: FontWeight.bold),
                    //     ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    TextFormField(
                      onSaved: (value) => _retype = value,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      obscureText: !_showPass,
                      validator: (value) => validateField(value),
                      decoration: InputDecoration(
                        labelText: "Nhập lại mật khẩu mới",
                        labelStyle:
                            TextStyle(color: Colors.black26, fontSize: 15),
                        focusedBorder: new UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                              style: BorderStyle.solid),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //     onTap: onToggleShowPass,
                    //     child: Text(
                    //       _showPass ? "Ẩn" : "Hiện",
                    //       style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 13,
                    //           fontWeight: FontWeight.bold),
                    //     ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Visibility(
                  child: Text(
                    "Mật khẩu không chính xác!",
                    style: TextStyle(color: Colors.red),
                  ),
                  visible: (statusCode == 50),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: RaisedButton(
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        onChangePasswordClick(context);
                      });
                    },
                    child: Text(
                      "Thay đổi mật khẩu",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String validateField(String value) {
    var _pass = passController.text;
    return value == _pass ? null : "Hãy nhập lại chính xác mật khẩu";
  }

  pushToSave() {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Thay đổi mật khẩu thành công"),
      ),
    );
    //print("Hello");
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  void onChangePasswordClick(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt("customerId");
    final form = _formKey.currentState;
    form.save();
    if (form.validate()) {
      String api = "http://testapi.chieuphimquocgia.com.vn/api/ChangePassword?userId=$id&Password=$_oldPassword&_PassNew=$_newPassword";
      var response = await http.post(api);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProcedureResultPage(
                        statusCode: body["StatusCode"],
                        message: body["Status"],
                      )));
        });
      }
    }
  }
}
