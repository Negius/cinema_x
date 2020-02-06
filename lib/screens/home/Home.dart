import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:cinema_x/screens/News/AllNews.dart';
import 'package:cinema_x/screens/account/login_page.dart';
import 'package:cinema_x/screens/account/userInfo.dart';
import 'package:cinema_x/utils/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cinema_x/widget/messaging_widget.dart';

import './FilmComming.dart' as Fcomming;
import './FilmShowing.dart' as Fshowing;
import './ListNews.dart' as News;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final List imgList = [
    'https://chieuphimquocgia.com.vn/Themes/RapChieuPhim/Content/content.v2/images/ch%e1%bb%8b%20ch%E1%BB%8B%20em%20em.jpg',
    'https://chieuphimquocgia.com.vn/Themes/RapChieuPhim/Content/content.v2/images/1jumanji.jpg',
    'https://chieuphimquocgia.com.vn/Themes/RapChieuPhim/Content/content.v2/images/2m%e1%ba%aft%20bi%E1%BA%BFc.jpg',
    'https://chieuphimquocgia.com.vn/Themes/RapChieuPhim/Content/content.v2/images/1.anh%20trai%20y%C3%AAu%20qu%C3%A1i.jpg',
    'https://chieuphimquocgia.com.vn/Themes/RapChieuPhim/Content/content.v2/images/2.%20FROZEN.jpg',
  ];

  final List imgSlider = [
    'https://chieuphimquocgia.com.vn/Themes/RapChieuPhim/Content/content.v2/images/ch%e1%bb%8b%20ch%E1%BB%8B%20em%20em.jpg',
    'https://chieuphimquocgia.com.vn/Themes/RapChieuPhim/Content/content.v2/images/1jumanji.jpg',
    'https://chieuphimquocgia.com.vn/Themes/RapChieuPhim/Content/content.v2/images/2m%e1%ba%aft%20bi%E1%BA%BFc.jpg',
    'https://chieuphimquocgia.com.vn/Themes/RapChieuPhim/Content/content.v2/images/1.anh%20trai%20y%C3%AAu%20qu%C3%A1i.jpg',
    'https://chieuphimquocgia.com.vn/Themes/RapChieuPhim/Content/content.v2/images/2.%20FROZEN.jpg',
  ];
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      SharedPreferences.getInstance().then((prefs) {
        isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      endDrawer: MenuBar(),
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: ListView(children: <Widget>[
              imageSliderCarousel(),
              tabNotifications(),
              tabFilms(),
              tabNews(),
            ]),
          ),
          new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            isLoggedIn ? UserInfoPage() : LoginPage(),
                      ),
                    );
                  });
                },
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
      //)
    );
  }

  Widget tabNotifications() {
    return Container(
        height: 0,
        child: MessagingWidget()
    );
  }

  Widget imageSliderCarousel() {
    return Container(
      height: 135,
      child: Carousel(
        dotSize: 0.0,
        boxFit: BoxFit.cover,
        images: imgSlider.map((img) => Image.network(img)).toList(),
        autoplay: true,
        indicatorBgPadding: 0.0,
      ),
    );
  }

  Widget tabFilms() {
    return Container(
      height: 510,
      color: Colors.brown,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              backgroundColor: Colors.red,
              //height: 700,
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: 'ĐANG CHIẾU',
                  ),
                  Tab(
                    text: 'SẮP CHIẾU',
                  ),
                  Tab(
                    text: 'ĐẶC BIỆT',
                  ),
                ],
              ),
            ),
          ),
          body: new TabBarView(
            children: <Widget>[
              new Fshowing.Showing(),
              new Fcomming.Comming(),
              new Fshowing.Showing(),
            ],
          ),
        ),
      ),
    );
  }

  Widget tabNews() {
    return Container(
      height: 600,
      color: Colors.brown,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: new AppBar(
            title: Text("Tin tức"),
            backgroundColor: Colors.red,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              InkWell(
                  child: Center(
                    child: Container(
                      width: 60,
                      height: 25,
                      margin: EdgeInsets.only(right: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.5, color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Tất cả",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListAllNews()));
                    });
                  } //Xem tất cả,
                  ),
            ],
          ),
          body: new News.ListNews(),
        ),
      ),
    );
  }
}
