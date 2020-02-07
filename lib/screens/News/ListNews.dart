
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/models/user.dart';
import 'package:cinema_x/models/News.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListNews extends StatefulWidget {
  @override
  _ListNews createState() => _ListNews();
}

class _ListNews extends State<ListNews> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<List<News>> _listNews;
  List imgList;
  List nameList;
  List versionList;
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    _listNews = fetchNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // endDrawer: MenuBar(),
      key: _scaffoldKey,
      //  resizeToAvoidBottomPadding: false,
      body: FutureBuilder(
        future: _listNews,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: ListView(
                children: (snapshot.data as List<News>).map((data) {
                  return GestureDetector(
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => MovieDetailsPage(
                    //         movie: data,
                    //       ),
                    //     ),
                    //   );
                    // },
                    child: Card(
                      child: Row(
                        children: <Widget>[
                          Image(
                            image: NetworkImage(data.urlImage),
                            height: 100,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AutoSizeText(
                                  data.title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                ),
                                // Text(
                                //   DateFormat("dd/MM/yyyy").format(
                                //     DateTime.parse(data.premieredDay),
                                //   ),
                                // ),
                                // Text(data.duration.toString() + " phút"),
                                Row(
                                  children: <Widget>[
                                    AutoSizeText(
                                      data.short,
                                      // style: TextStyle(
                                      //     fontWeight: FontWeight.bold,
                                      //     color: Colors.red),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  pushToSave() {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login thành công"),
      ),
    );
    //print("Hello");
  }

  Widget test(BuildContext context, dynamic item) {
    return Container();
  }

  // void onSignInClicked(BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final form = _formKey.currentState;
  //   form.save();

  //   // Validate will return true if is valid, or false if invalid.
  //   if (form.validate()) {
  //     String api =
  //         'http://testapi.chieuphimquocgia.com.vn/api/LoginApp?Email=${Uri.encodeFull(_userId)}&Password=$_password';
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json'
  //     };
  //     var body = {"Email": Uri.encodeFull(_userId), "Password": _password};
  //     // var response = await http.post(api);
  //     var response = await http.post(Uri.parse(api),
  //         headers: headers, body: json.encode(body));
  //     print(response.body);
  //     if (response.statusCode == 200) {
  //       Map parsed = json.decode(response.body);
  //       setState(() {
  //         statusCode = parsed["StatusCode"] as int;
  //         print(statusCode);
  //       });
  //       if (statusCode == 30) {
  //         User user = User.fromJson(parsed["User"]);
  //         setUserInfo(prefs, user);
  //         // Navigator.push(
  //         //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //         Navigator.pop(context);
  //       }
  //     }
  //   }
  // }

  void setUserInfo(SharedPreferences prefs, User user) {
    prefs.setBool('isLoggedIn', true);
    prefs.setString("fullName", user.fullName);
    prefs.setString("firstName", user.firstName);
    prefs.setString("lastName", user.lastName);
    prefs.setInt("customerId", user.id);
    prefs.setDouble("pointReward", user.pointReward);
    prefs.setDouble("pointCard", user.pointCard);
    prefs.setString("email", user.email);
    prefs.setString("phone", user.phoneNumber);
  }

  void logOut(SharedPreferences prefs) async {
    await prefs.clear();
  }
}
