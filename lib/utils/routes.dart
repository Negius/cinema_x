import 'package:cinema_x/screens/home/Home.dart';
import 'package:cinema_x/screens/account/login_page.dart';
import 'package:flutter/material.dart';
//import 'package:cimema_app/screens/login/login_page.dart';

final routes = {
  '/login':         (BuildContext context) => new LoginPage(),
  '/home':         (BuildContext context) => new HomeScreen(),
  '/' :          (BuildContext context) => new HomeScreen(),
};