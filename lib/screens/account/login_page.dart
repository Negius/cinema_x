import 'dart:convert';

import 'package:cinema_x/config/AppSettings.dart';
import 'package:cinema_x/config/ValidateError.dart';
import 'package:cinema_x/models/user.dart';
import 'package:cinema_x/screens/home/Home.dart';
import 'package:cinema_x/screens/account/register_page.dart';
import 'package:cinema_x/screens/account/task/passwordrecovery.dart';
import 'package:cinema_x/utils/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String _userId;
  String _password;
  bool _showPass = false;
  int statusCode = 0;
  String _tokenFCM = '';

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MenuBar(),
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(CommonString.login),
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
                child: TextFormField(
                  onSaved: (value) => _userId = value,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: CommonString.emailID,
                    labelStyle:
                        new TextStyle(color: Colors.black26, fontSize: 15),
                    focusedBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.red[900],
                          width: 1.0,
                          style: BorderStyle.solid),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: Visibility(
                  child: Text(
                    ErrorId.notExisted,
                    style: TextStyle(color: Colors.red[900]),
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
                      onSaved: (value) => _password = value,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      obscureText: !_showPass,
                      decoration: InputDecoration(
                        labelText: CommonString.password,
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
                    GestureDetector(
                        onTap: onToggleShowPass,
                        child: Text(
                          _showPass ? CommonString.showpassF : CommonString.showpassT,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
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
                        onSignInClicked(context);
                      });
                    },
                    child: Text(
                      "Đăng nhập",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              Container(
                //padding: const EdgeInsets.fromLTRB(0,0,0,10),
                height: 130,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      child: Text(
                        CommonString.register,
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                    ),
                    InkWell(
                      child: Text(
                        CommonString.forgotPass,
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Passwordrecovery()));
                      },
                    ),
                    // Text(
                    //   CommonString.forgotPass,
                    //   style: TextStyle(fontSize: 15, color: Colors.grey),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  void onSignInClicked(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final form = _formKey.currentState;
    form.save();

    // Validate will return true if is valid, or false if invalid.
    if (form.validate()) {
      String url = NccUrl.login +
          "Email=${Uri.encodeFull(_userId)}&Password=$_password&tokenFCM=$_tokenFCM";
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        Map parsed = json.decode(response.body);
        setState(() {
          statusCode = parsed["StatusCode"] as int;
          print(statusCode);
        });
        if (statusCode == 30) {
          User user = User.fromJson(parsed["User"]);
          print(parsed["User"]);
          setUserInfo(prefs, user);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
          // Navigator.pop(context);
        }
      }
    }
  }

  void setUserInfo(SharedPreferences prefs, User user) {
    prefs.setBool('isLoggedIn', true);
    prefs.setString("fullName", user.fullName);
    prefs.setString("firstName", user.firstName);
    prefs.setString("lastName", user.lastName);
    prefs.setInt("customerId", user.id);
    prefs.setDouble("pointReward", user.pointReward);//
    prefs.setDouble("pointCard", user.pointCard);//
    prefs.setString("email", user.email);
    prefs.setString("phone", user.phoneNumber);
    prefs.setString("cardCode", user.cardCode);
    prefs.setString("cardLevelName", user.cardLevelName);
    prefs.setString("address", user.address);
    prefs.setString("birth", user.birthDay.toString());
    prefs.setString("gender", user.gender ? "M" : "F");
    print(prefs.getInt("customerId"));
  }

  void logOut(SharedPreferences prefs) async {
    await prefs.clear();
    prefs.setBool("isLoggedIn", false);
  }
}
