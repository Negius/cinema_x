import 'package:cinema_x/config/AppSettings.dart';
import 'package:cinema_x/models/Movie.dart';
import 'package:cinema_x/models/Session.dart';
import 'package:cinema_x/screens/booking/seatSelection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  BookingPage({Key key, this.movie}) : super(key: key);
  final Movie movie;
  @override
  _BookingPageState createState() {
    return _BookingPageState();
  }
}

class _BookingPageState extends State<BookingPage> {
  Session session;
  double itemHeight = 100.0;
  double radius = 24.0;
  int totalField = 2;
  int diffPerTone = 12;
  Future<List<Session>> _sessions;
  var dateList = new List<String>();
  var timeList = new Map<String, List<Map<String, dynamic>>>();

  @override
  void initState() {
    super.initState();

    _sessions = fetchSessions(widget.movie.id);
  }

  Color getColor(index) {
    int color;
    if (Theme.of(context).brightness == Brightness.dark)
      color = diffPerTone * totalField + 20 - diffPerTone * (index + 1);
    else
      color = 255 - diffPerTone * totalField + 20 - diffPerTone * (index + 1);

    return Color.fromRGBO(color, color, color, 1);
  }

  Widget itemContainer(context, constraints,
      {child, int index, colorIndex, int span = 1}) {
    double top = (itemHeight - radius) * index;
    return Container(
      margin: EdgeInsets.only(top: top),
      child: ClipRRect(
        child: Container(
          padding: EdgeInsets.only(top: 16, left: 8, right: 8),
          height: (itemHeight - radius) * span + radius + 32,
          color: getColor(colorIndex),
          width: constraints.maxWidth,
          child: child,
        ),
        borderRadius: BorderRadius.only(topRight: Radius.circular(24)),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return sessions(context);
  }

  Widget sessions(BuildContext context) {
    return FutureBuilder(
      future: _sessions,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          dateList.clear();
          timeList.clear();
          DateFormat df = new DateFormat("dd-MM");
          DateFormat tf = new DateFormat("HH:mm");
          for (Session s in snapshot.data) {
            var dt = s.projectDateTime;
            var id = s.id;
            var date = df.format(dt);
            var time = tf.format(dt);
            if (!dateList.contains(date)) dateList.add(date);
            if (timeList.containsKey(date)) {
              timeList[date].add(
                  {"id": id, "time": time, "dateTimeFull": s.projectDateTime});
            } else {
              timeList.addAll({
                date: [
                  {"id": id, "time": time, "dateTimeFull": s.projectDateTime}
                ]
              });
            }
          }
          dateList = dateList.toSet().toList();
          return DefaultTabController(
            length: dateList.length,
            initialIndex: 0,
            child: Scaffold(
              appBar: AppBar(
                title: Text(widget.movie.name),
                elevation: 26,
                bottom: new TabBar(
                  tabs: dateList.map<Widget>((d) {
                    return new Container(
                      child: Text(
                        d,
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }).toList(),
                ),
              ),
              body: TabBarView(
                children: dateList.map<Widget>((d) {
                  var t = timeList[d];
                  t.sort((a, b) => a["time"].compareTo(b["time"]));
                  var tL = new List<List<Map<String, dynamic>>>();
                  if (t.length < 3) {
                    tL = [t];
                  } else {
                    for (int i = 0; i + 3 <= t.length; i += 3) {
                      tL.add(t.sublist(i, i + 3));
                      if (i + 3 <= t.length && i + 6 > t.length) {
                        tL.add(t.sublist(i + 3, t.length));
                      }
                    }
                  }
                  return new Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          CommonString.chooseSession,
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        new Column(
                          children: tL
                              .map<Widget>((t) => timeRow(context, t))
                              .toList(),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        } else {
          return DefaultTabController(length: 1, child: Scaffold());
        }
      },
    );
  }

  Widget timeRow(BuildContext context, List<Map<String, dynamic>> timeList) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: timeList.map<Widget>((time) {
        return RaisedButton(
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
                    movie: widget.movie,
                    planId: time["id"],
                    dateTimeFull: time["dateTimeFull"]),
              ),
            );
          },
          child: Text(
            time["time"],
            style: TextStyle(fontSize: 20),
          ),
        );
      }).toList(),
    );
  }
}
