import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/config/AppSettings.dart';
import 'package:cinema_x/models/News.dart';
import 'package:cinema_x/screens/News/NewsDetail.dart';
import 'package:flutter/material.dart';

class ListAllNews extends StatefulWidget {
  @override
  _ListNews createState() => _ListNews();
}

class _ListNews extends State<ListAllNews> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<List<News>> _listNews;
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    _listNews = fetchAllNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // endDrawer: MenuBar(),
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(CommonString.news2),
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
        future: _listNews,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: ListView(
                // physics: NeverScrollableScrollPhysics(),
                children: (snapshot.data as List<News>).map((data) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetail(
                            news: data,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 100,
                              child: Image(
                                image: NetworkImage(data.urlImage),
                                // height: 100,
                                // width: 150,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 100,
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AutoSizeText(
                                    data.title,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                  ),
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
