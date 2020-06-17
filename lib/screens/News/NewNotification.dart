import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/models/News.dart';
// import 'package:cinema_x/screens/payment/notiDetail.dart';
import 'package:cinema_x/screens/News/NewsDetail.dart';
import 'package:flutter/material.dart';

class NotiList extends StatefulWidget {
  @override
  _NotiListState createState() => _NotiListState();
}

class _NotiListState extends State<NotiList> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<List<News>> _listNoties;
  List imgList;
  List nameList;
  List versionList;

  News get news => news;
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    _listNoties = fetchNews();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),),
        title: Text('Thông báo'),
      ), 
      key: _scaffoldKey,
      body: FutureBuilder(
        future: _listNoties,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: ListView(
                children: (snapshot.data as List<News>).map((data) {
                  return ListTile(
                    title: AutoSizeText(
                                  data.title.toUpperCase(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 3,
                                ),
                    trailing: Icon(Icons.arrow_right),
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
                   
                  );
                }).toList(),
              ),
            );
          } else {
            return Container();
          }
        }
      ),
    );
  }

  // void _navigatetoNotiDetail(BuildContext context, News news) {
  //   Navigator.push(context, MaterialPageRoute( builder: (context) => NotiDetail(news: news),));
  // }
}