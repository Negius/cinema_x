import 'dart:convert';

import 'package:cinema_x/config/AppSettings.dart';
import 'package:cinema_x/config/ValidateError.dart';
import 'package:cinema_x/utils/procedure_result.dart';
import 'package:cinema_x/screens/account/login_page.dart';
import 'package:cinema_x/utils/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Passwordrecovery extends StatefulWidget {
  @override
  _ChangePageState createState() => _ChangePageState();
}

class _ChangePageState extends State<Passwordrecovery> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final passController = TextEditingController();
  String _emailRecovery;
  bool _showPass = false;
  int statusCode = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MenuBar(),
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('Lấy lại mật khẩu'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
          ),
        ],
        backgroundColor: Colors.red[900],
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
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    TextFormField(
                      onSaved: (value) => _emailRecovery = value,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      // obscureText: !_showPass,
                      decoration: InputDecoration(
                        labelText: CommonString.emailRecoverPassword,
                        labelStyle:
                            TextStyle(color: Colors.black26, fontSize: 15),
                        focusedBorder: new UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.red[900],
                              width: 1.0,
                              style: BorderStyle.solid),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              //   child: Stack(
              //     alignment: AlignmentDirectional.centerEnd,
              //     children: <Widget>[
              //       TextFormField(
              //         onSaved: (value) => _newPassword = value,
              //         style: TextStyle(fontSize: 20, color: Colors.black),
              //         controller: passController,
              //         validator: (value) {
              //           if (value.length < 8)
              //             return ErrorPassword.length;
              //           else
              //             return null;
              //         },
              //         obscureText: !_showPass,
              //         decoration: InputDecoration(
              //           labelText: CommonString.newPassword,
              //           labelStyle:
              //               TextStyle(color: Colors.black26, fontSize: 15),
              //           focusedBorder: new UnderlineInputBorder(
              //             borderSide: BorderSide(
              //                 color: Colors.red[900],
              //                 width: 1.0,
              //                 style: BorderStyle.solid),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              //   child: Stack(
              //     alignment: AlignmentDirectional.centerEnd,
              //     children: <Widget>[
              //       TextFormField(
              //         onSaved: (value) => _retype = value,
              //         style: TextStyle(fontSize: 20, color: Colors.black),
              //         obscureText: !_showPass,
              //         validator: (value) => validateField(value),
              //         decoration: InputDecoration(
              //           labelText: CommonString.newPassword2,
              //           labelStyle:
              //               TextStyle(color: Colors.black26, fontSize: 15),
              //           focusedBorder: new UnderlineInputBorder(
              //             borderSide: BorderSide(
              //                 color: Colors.red[900],
              //                 width: 1.0,
              //                 style: BorderStyle.solid),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Visibility(
                  child: Text(
                    ErrorPassword.wrongPassword,
                    style: TextStyle(color: Colors.red[900]),
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
                    color: Colors.red[900],
                    onPressed: () {
                      setState(() {
                        onChangePasswordClick(context);
                      });
                    },
                    child: Text(
                      CommonString.passwordRecovery,
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
    return value == _pass ? null : ErrorPassword.wrongPassword2;
  }

  pushToSave() {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(CommonString.changePasswordSuccess),
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
      String url = NccUrl.passwordRecovery + _emailRecovery;
      var response = await http.post(url);
      if (response.statusCode == 200) {
        showDialog(
                        context: context,
                        builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Thư hướng dẫn đã được gửi đến Email của bạn!'),
                          actions: [
            FlatButton(
              onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
              }, 
              child: Text('TIẾP TỤC')),
          ],
                          );
                    });
      }
    }
  }
}
