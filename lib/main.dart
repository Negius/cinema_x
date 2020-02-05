import 'package:cinema_x/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_cupertino_localizations/flutter_cupertino_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'My Login App',
        theme: new ThemeData(
          primarySwatch: Colors.red,
        ),
        routes: routes,
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'), // English
          const Locale('vi'),
          // ... other locales the app supports
        ]);
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   bool _showPass = false;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//        resizeToAvoidBottomPadding: false,
//         body: Container(
//           padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
//           constraints: BoxConstraints.expand(),
//           color: Colors.white,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
//                 child: Container(
//                     width: 70,
//                     height: 70,
//                     padding: EdgeInsets.all(15),
//                     child: FlutterLogo()),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
//                 child: Text(
//                   "Đăng nhập",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                       fontSize: 30),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
//                 child: TextField(
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.black,
//                   ),
//                   decoration: InputDecoration(
//                     labelText: "Email hoặc Tên đăng nhập",
//                     labelStyle:
//                         new TextStyle(color: Colors.black26, fontSize: 15),
//                     focusedBorder: new UnderlineInputBorder(
//                       borderSide: BorderSide(
//                           color: Colors.red,
//                           width: 1.0,
//                           style: BorderStyle.solid),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
//                 child: Stack(
//                   alignment: AlignmentDirectional.centerEnd,
//                   children: <Widget>[
//                     TextField(
//                       style: TextStyle(fontSize: 20, color: Colors.black),
//                       obscureText: !_showPass,
//                       decoration: InputDecoration(
//                         labelText: "Mật khẩu",
//                         labelStyle:
//                             TextStyle(color: Colors.black26, fontSize: 15),
//                         focusedBorder: new UnderlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.red,
//                               width: 1.0,
//                               style: BorderStyle.solid),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                         onTap: onToggleShowPass,
//                         child: Text(
//                           _showPass ? "Ẩn" : "Hiện",
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 13,
//                               fontWeight: FontWeight.bold),
//                         ))
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 56,
//                   child: RaisedButton(
//                     color: Colors.red,
//                     onPressed: OnSignInClicked,
//                     child: Text(
//                       "Đăng nhập",
//                       style: TextStyle(color: Colors.white, fontSize: 18),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 //padding: const EdgeInsets.fromLTRB(0,0,0,10),
//                 height: 130,
//                 width: double.infinity,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text(
//                       "Đăng ký tài khoản",
//                       style: TextStyle(fontSize: 15, color: Colors.grey),
//                     ),
//                     Text(
//                       "Quên mật khẩu?",
//                       style: TextStyle(fontSize: 15, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void onToggleShowPass() {
//     setState(() {
//       _showPass = !_showPass;
//     });
//   }

//   void OnSignInClicked() {}
// }
