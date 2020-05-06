import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/config/AppSettings.dart';
import 'package:cinema_x/models/TicketHistory.dart';
import 'package:flutter/material.dart';
import 'package:cinema_x/utils/menu_drawer.dart';
import 'package:intl/intl.dart';

class TicketHistory extends StatefulWidget {
  @override
  TicketHistoryState createState() => TicketHistoryState();
}

class TicketHistoryState extends State<TicketHistory> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<List<History>> _showingMovies;
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
    _showingMovies = fetchTicketHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MenuBar(),
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(CommonString.ticketHistory),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
          ),
        ],
        backgroundColor: Colors.red,
      ),
      //  resizeToAvoidBottomPadding: false,
      body: FutureBuilder(
        future: _showingMovies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return Container(
                child: ListView(
                  children: (snapshot.data as List<History>).map((data) {
                    return GestureDetector(
                      child: Card(
                        child: Row(
                          children: <Widget>[
                            Image(
                              image: NetworkImage(data.filmImage),
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
                                      data.filmName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      maxLines: 3,
                                    ),
                                    Text(
                                      DateFormat("dd/MM/yyyy").format(
                                        DateTime.parse(data.buyCreatedOnUtc),
                                      ),
                                    ),
                                    Text(CommonString.number.replaceAll(
                                        "_value_", data.tickets.toString())),
                                    Text(CommonString.seats.replaceAll(
                                        "_value_", data.listChairValue)),
                                    Row(
                                      children: <Widget>[
                                        AutoSizeText(
                                          CommonString.ordertotal.replaceAll(
                                              "_value_",
                                              data.orderTotal.toString()),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                      ],
                                    )
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
}
