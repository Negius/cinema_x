import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/config/AppSettings.dart';
import 'package:cinema_x/models/Movie.dart';
import 'package:cinema_x/models/Schedule.dart';
import 'package:cinema_x/screens/booking/seatSelection.dart';
import 'package:cinema_x/screens/home/Home.dart';
import 'package:flutter/material.dart';
import 'package:cinema_x/utils/menu_drawer.dart';
import 'package:intl/intl.dart';

class FilmSchedule extends StatefulWidget {
  @override
  _ListFilms createState() => _ListFilms();
}

class _ListFilms extends State<FilmSchedule> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<List<Map<String, dynamic>>> _schedule;

  @override
  void initState() {
    _schedule = fetchSchedules();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _schedule,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            List<Map<String, dynamic>> listDay = snapshot.data;
            return DefaultTabController(
              length: listDay.length,
              initialIndex: 0,
              child: Scaffold(
                appBar: new AppBar(
                  title: new Text(CommonString.schedule),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () =>
                          _scaffoldKey.currentState.openEndDrawer(),
                    ),
                  ],
                  backgroundColor: Colors.red,
                  bottom: new TabBar(
                    tabs: listDay.map<Widget>((day) {
                      String date = DateFormat("dd/MM").format(day["Day"]);
                      return new Container(
                        child: Text(
                          date,
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                endDrawer: MenuBar(),
                key: _scaffoldKey,
                body: new TabBarView(
                  children: listDay.map<Widget>((day) {
                    List<Map<String, dynamic>> listFilm = day["listFilm"];
                    return Container(
                      child: ListView(
                        children: listFilm.map((data) {
                          List<Map<String, dynamic>> sessions =
                              data["listSession"];
                          Movie movie = data["Movie"];
                          var splittedSessionList = [];
                          if (sessions.length <= 2)
                            splittedSessionList = [sessions];
                          else {
                            for (int i = 0; i + 3 <= sessions.length; i += 3) {
                              splittedSessionList
                                  .add(sessions.sublist(i, i + 3));
                              if (i + 3 <= sessions.length &&
                                  i + 6 > sessions.length) {
                                splittedSessionList.add(
                                    sessions.sublist(i + 3, sessions.length));
                              }
                            }
                          }
                          return Card(
                            child: Row(
                              children: <Widget>[
                                Image(
                                  image: NetworkImage(movie.imageUrl),
                                  height: 160,
                                  width: 120,
                                  fit: BoxFit.fill,
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                            AutoSizeText(
                                              movie.name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 2,
                                            ),
                                          ] +
                                          splittedSessionList
                                              .map<Widget>((t) =>
                                                  timeRow(context, movie, t))
                                              .toList(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          } else {
            return Scaffold(
              endDrawer: MenuBar(),
              key: _scaffoldKey,
              appBar: new AppBar(
                title: new Text(CommonString.schedule),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
                  ),
                ],
                backgroundColor: Colors.red,
              ),
              body: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 200,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        CommonString.emptySchedules,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FlatButton(
                          color: Colors.red,
                          child: Text(
                            CommonString.homePage,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          onPressed: () {
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            });
                          }),
                    ],
                  ),
                ),
              ),
            );
          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget timeRow(
      BuildContext context, Movie movie, List<Map<String, dynamic>> timeList) {
    return ButtonTheme(
      minWidth: 75,
      buttonColor: Colors.grey[300],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: timeList.map<Widget>((time) {
          var timeString = DateFormat("HH:mm").format(time["ProjectDateTime"]);
          return Row(
            children: <Widget>[
              RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    side: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey
                            : Colors.black12)),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => SeatSelection(
                          movie: movie,
                          planId: time["Id"],
                          dateTimeFull: time["ProjectDateTime"]),
                    ),
                  );
                },
                child: Text(
                  timeString,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
