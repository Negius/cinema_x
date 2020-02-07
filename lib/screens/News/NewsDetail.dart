import 'package:cinema_x/models/News.dart';
import 'package:cinema_x/utils/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class NewsDetail extends StatefulWidget {
  NewsDetail({Key key, @required this.news, this.expanded}) : super(key: key);
  final News news;
  final Function() expanded;

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MenuBar(),
      body: Stack(
        children: <Widget>[
          new Center(
            child: Container(
              padding:
                  EdgeInsets.only(top: 70, left: 10, right: 10, bottom: 10),
              child: SingleChildScrollView(
                child: Html(
                  data: widget.news.full,
                  padding: EdgeInsets.all(8.0),
                  onLinkTap: (url) {
                    print("Opening $url...");
                  },
                  customRender: (node, children) {
                    if (node is dom.Element) {
                      switch (node.localName) {
                        case "custom_tag": // using this, you can handle custom tags in your HTML
                          return Column(children: children);
                        default:
                          return Column();
                      }
                    } else
                      return Column();
                  },
                ),
              ),
            ),
          ),
          new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              title: Text(widget.news.title),
              backgroundColor: Colors.red,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
