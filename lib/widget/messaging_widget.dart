import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cinema_x/models/message.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((token) {
      print('token FCM: ' + token);
    });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        _asyncInputDialog(context, message['data']['FilmId'], message['data']['FilmName']);
        setState(() {
          messages.add(Message(
              title: notification['title'],
              body: notification['body'],
              filmName: message['data']['FilmName'],
              filmId: message['data']['FilmId']));
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        final notification = message['data'];
        if (notification['title']) {
          setState(() {
            messages.add(Message(
                title: '${notification['title']}',
                body: '${notification['body']}',
                filmId: message['data']['FilmId'],
                filmName: message['data']['FilmName']));
          });
        }
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResumeee: $message");
        _asyncInputDialog(context, message['data']['FilmId'], message['data']['FilmName']);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  Widget build(BuildContext context) => ListView(
        children: messages.map(buildMessage).toList(),
      );

  Widget buildMessage(Message message) => ListTile(
        title: Text(message.title),
        subtitle: Text(message.body),
        onTap: () => _asyncInputDialog(context, message.filmId, message.filmName),
      );

  Future<String> _asyncInputDialog(BuildContext context, filmId, filmName) async {
    print(filmId);
    print(filmName);
    String comment = '';
    int _point = 0;
    return showDialog<String>(
        context: context,
        barrierDismissible:
            false, // dialog is dismissible with a tap on the barrier
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape:
              RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
              title: ListTile(
                title: Text(filmName),
              ),
              content: new Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new IconButton(
                        icon: _point >= 1
                            ? new Icon(
                                Icons.star,
                                color: Colors.amber,
                              )
                            : new Icon(Icons.star_border),
                        onPressed: () {
                          setState(() {
                            _point = 1;
                          });
                        },
                      ),
                      new IconButton(
                        icon: _point >= 2
                            ? new Icon(
                                Icons.star,
                                color: Colors.amber,
                              )
                            : new Icon(Icons.star_border),
                        onPressed: () {
                          setState(() {
                            _point = 2;
                          });
                        },
                      ),
                      new IconButton(
                        icon: _point >= 3
                            ? new Icon(
                                Icons.star,
                                color: Colors.amber,
                              )
                            : new Icon(Icons.star_border),
                        onPressed: () {
                          setState(() {
                            _point = 3;
                          });
                        },
                      ),
                      new IconButton(
                        icon: _point >= 4
                            ? new Icon(
                                Icons.star,
                                color: Colors.amber,
                              )
                            : new Icon(Icons.star_border),
                        onPressed: () {
                          setState(() {
                            _point = 4;
                          });
                        },
                      ),
                      new IconButton(
                        icon: _point >= 5
                            ? new Icon(
                                Icons.star,
                                color: Colors.amber,
                              )
                            : new Icon(Icons.star_border),
                        onPressed: () {
                          setState(() {
                            _point = 5;
                          });
                        },
                      ),
                    ],
                  ),
                  new Expanded(
                      child: new TextField(
                    autofocus: true,
                    decoration: new InputDecoration(hintText: 'Nhận xét'),
                    onChanged: (value) {
                      comment = value;
                    },
                  ))
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black26),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(comment);
                  },
                ),
                FlatButton(
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    onSubmitReview(context, comment, _point, filmId, filmName);
                  },
                ),
              ],
            );
          });
        });
  }

  void onSubmitReview(BuildContext context, comment, point, filmId, filmName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String api = 'http://testapi.chieuphimquocgia.com.vn/api/CreateFilmComment';
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    var body = {
      "CustomerId": prefs.get("customerId"),
      "FilmId": filmId,
      "IsApproved": true,
      "Title": filmName,
      "ReviewText": comment,
      "Rating": point,
      "HelpfulYesTotal": 0,
      "HelpfulNoTotal": 0,
      "CreatedOnUtc": DateTime.now().toString(),
      "IsDisabled": true
    };
    var response = await http.post(Uri.parse(api),
        headers: headers, body: json.encode(body));
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.of(context).pop(comment);
//      Map parsed = json.decode(response.body);
    }
  }
}
