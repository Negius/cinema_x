import 'package:cinema_x/config/AppSettings.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(CommonString.commonError),
              FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(CommonString.back),
              )
            ],
          ),
        ),
      ),
    );
  }
}
