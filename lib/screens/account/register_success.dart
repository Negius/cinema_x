import 'package:cinema_x/config/AppSettings.dart';
import 'package:cinema_x/screens/home/Home.dart';
import 'package:flutter/material.dart';

class RegisterSuccessPage extends StatefulWidget {
  final String message;
  final int code;
  RegisterSuccessPage({@required this.code, @required this.message});
  @override
  _RegisterSuccessPageState createState() => _RegisterSuccessPageState();
}

class _RegisterSuccessPageState extends State<RegisterSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              widget.code == 30
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 200,
                    )
                  : Icon(
                      Icons.error,
                      color: Colors.red[900],
                      size: 200,
                    ),
              Text(
                widget.message,
                style: TextStyle(
                    fontSize: 20,
                    color: widget.code == 30 ? Colors.green : Colors.red[900]),
              ),
              FlatButton(
                color: widget.code == 30 ? Colors.green : Colors.red[900],
                child: Text(
                  widget.code == 30 ? CommonString.homePage : CommonString.back,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onPressed: () {
                  setState(() {
                    widget.code == 30
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          )
                        : Navigator.pop(context);
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
