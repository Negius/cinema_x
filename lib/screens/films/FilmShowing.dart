import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/models/Movie.dart';
import 'package:cinema_x/screens/details/MovieDetails.dart';
import 'package:flutter/material.dart';
import 'package:cinema_x/utils/menu_drawer.dart';
import 'package:intl/intl.dart';

class FilmShowing extends StatefulWidget {
  @override
  _ListFilms createState() => _ListFilms();
}

class _ListFilms extends State<FilmShowing> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<List<Movie>> _showingMovies;
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
    _showingMovies = fetchShowingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MenuBar(),
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('Chọn phim của bạn'),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    maxLines: 3,
                                  ),
                                  Text(
                                    DateFormat("dd/MM/yyyy").format(
                                      DateTime.parse(data.premieredDay),
                                    ),
                                  ),
                                  Text(data.duration.toString() + " phút"),
                                  Row(
                                    children: <Widget>[
                                      AutoSizeText(
                                        data.versionCode,
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
        },
      ),
    );
  }
}