import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/models/News.dart';
import 'package:flutter/material.dart';

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
      key: _scaffoldKey,
      body: FutureBuilder(
        future: _listNews,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: ListView(
                children: (snapshot.data as List<News>).map((data) {
                  return GestureDetector(
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
                                Row(
                                  children: <Widget>[
                                    AutoSizeText(
                                      data.short,
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
}
