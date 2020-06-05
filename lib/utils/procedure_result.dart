import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/config/AppSettings.dart';
import 'package:cinema_x/screens/account/userInfo.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class ProcedureResultPage extends StatefulWidget {
  ProcedureResultPage({@required this.statusCode, @required this.message});
  @override
  _ProcedureResultPageState createState() => _ProcedureResultPageState();
  final int statusCode;
  final String message;
}

class _ProcedureResultPageState extends State<ProcedureResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            widget.statusCode == 30 ? Icons.check_circle : Icons.error,
            color: widget.statusCode == 30 ? Colors.green : Colors.red[900],
            size: 150,
          ),
          SizedBox(
            height: 25,
          ),
          AutoSizeText(
            new ReCase(widget.message).sentenceCase,
            minFontSize: 25,
            maxLines: 1,
          ),
          SizedBox(
            height: 25,
          ),
          FlatButton(
            color: widget.statusCode == 30 ? Colors.green : Colors.red[900],
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserInfoPage()));
            },
            child: AutoSizeText(
              CommonString.back,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ));
  }
}
