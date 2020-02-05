import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Đã có lỗi xảy ra"),
              FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Quay lại"),
              )
            ],
          ),
        ),
      ),
    );
  }
}