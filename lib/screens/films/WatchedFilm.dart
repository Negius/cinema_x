import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/models/Movie.dart';
import 'package:cinema_x/screens/details/MovieDetails.dart';
import 'package:cinema_x/config/AppSettings.dart';
import 'package:cinema_x/models/TicketHistory.dart';
import 'package:cinema_x/models/watchedFilm.dart';
import 'package:cinema_x/screens/payment/paymentCheckout.dart';
import 'package:flutter/material.dart';
import 'package:cinema_x/utils/menu_drawer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recase/recase.dart';
import 'package:http/http.dart' as http;

class WatchedFilm extends StatefulWidget {
  final Movie movie;

  const WatchedFilm({Key key, this.movie}) : super(key: key);
  @override
  WatchedFilmState createState() => WatchedFilmState();
}

class WatchedFilmState extends State<WatchedFilm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<List<Movie>> _watchedMovies;
  List imgList;
  List nameList;
  List versionList;
  int _current = 0;
  Movie get movie => widget.movie;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }



  @override
  void initState(){
    _watchedMovies = fetchWatchedMovies();//
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MenuBar(),
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(CommonString.watchedMovies),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
          ),
        ],
        backgroundColor: Colors.red[900],
      ),
      //  resizeToAvoidBottomPadding: false,
      body: FutureBuilder(
        future: _watchedMovies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return Container(
                child: ListView(
                  
                  children: (snapshot.data as List<Movie>).map((data) {
                    return GestureDetector(
                        onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsPage(
                                  movie: data,
                                ),
                              ),
                            );
                          },
                      child: Card(
                        child: Row(
                          
                          children: <Widget>[
                            
                            Image(
                              image: NetworkImage(data.imageUrl),
                              height: 100,
                              width: 75,
                              fit: BoxFit.fill,
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    AutoSizeText(
                                      data.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      maxLines: 3,
                                    ),
                                    Text('Phim '+ data.countryName),
                                    Text('Thể loại: ' + data.categories.map((c) => ReCase(c).sentenceCase).join(", ")),
                                    Text('Khởi chiếu: ' +
                                      DateFormat("dd/MM/yyyy").format(
                                        DateTime.parse(data.premieredDay)
                                    )),
                                    RaisedButton(
                                      onPressed: ()=>getFilmId(),
                                      child: Text('Đánh giá'),)
                                  ],
                                ),
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
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Future<String> getFilmId() async{
    String comment = '';
    int _point = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var filmId = prefs.get("movieId").toString();
    return showDialog(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15)),
            title: ListTile(
              title: Text(CommonString.rating),
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
                  decoration:
                      new InputDecoration(hintText: CommonString.comment),
                  onChanged: (value) {
                    comment = value;
                  },
                ))
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  CommonString.cancel,
                  style: TextStyle(color: Colors.black26),
                ),
                onPressed: () {
                  Navigator.of(context).pop(comment);
                },
              ),
              FlatButton(
                child: Text(
                  CommonString.ok,
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  if(comment != '') {
                    onSubmitReview(context, comment, _point, filmId);
                  }
                },
              ),
            ],
          );
        });
      });
  }
  void onSubmitReview(BuildContext context, comment, point, filmId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = NccUrl.createComment;

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };

    var body = {
      "CustomerId": prefs.get("customerId"),
      "FilmId": int.parse(filmId),
      "IsApproved": true,
      "Title": '',
      "ReviewText": comment,
      "Rating": point,
      "HelpfulYesTotal": 0,
      "HelpfulNoTotal": 0,
      "CreatedOnUtc": DateTime.now().toString(),
      "IsDisabled": true
    };

    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      // Navigator.of(context).pop(comment);
      Navigator.pop(context, comment);
      _thankDialog();
      
    }
  }
  Future _thankDialog() async{
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15)),
          // insetPadding: EdgeInsets.all(30),
          title: Text('Cảm ơn bạn đã đánh giá !', 
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange[900]),),
          actions: [
            FlatButton(
              onPressed:()=>Navigator.pop(context), 
              child: Text('OK', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)))
          ],
        );
      }
    );
  }
  void navigateToMovieDetails(BuildContext context, Movie movie) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetailsPage(movie: movie)));

  }
}