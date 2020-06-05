import 'package:cinema_x/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cinema_x/screens/home/Home.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main(){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarBrightness: Brightness.light,
  ));
  
// SystemChrome.setPreferredOrientations([
//         DeviceOrientation.portraitUp,
//       ]);
  runApp(MaterialApp(
         theme: new ThemeData(
          primarySwatch: Colors.red,
        ),
  home: MyApp(),));
} 

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(
      seconds:3
    ),(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),),);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: Image.asset("assets/images/splash_screen.png", fit: BoxFit.fill),
        
      )
    );
    // return new MaterialApp(
    //     theme: new ThemeData(
    //       primarySwatch: Colors.red[900],
    //     ),
    //     routes: routes,
    //     localizationsDelegates: [
    //       // ... app-specific localization delegate[s] here
    //       GlobalMaterialLocalizations.delegate,
    //       GlobalWidgetsLocalizations.delegate,
    //       GlobalCupertinoLocalizations.delegate,
    //     ],
    //     supportedLocales: [
    //       const Locale('en'), // English
    //       const Locale('vi'),
    //       // ... other locales the app supports
    //     ]);
  }
}
