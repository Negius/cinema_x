import 'package:carousel_pro/carousel_pro.dart';
import 'package:cinema_x/config/AppSettings.dart';
import 'package:cinema_x/screens/News/AllNews.dart';
import 'package:cinema_x/screens/account/login_page.dart';
import 'package:cinema_x/screens/account/userInfo.dart';
import 'package:cinema_x/utils/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

import './FilmComming.dart' as Fcomming;
import './FilmShowing.dart' as Fshowing;
import './ListNews.dart' as News;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final List imgSlider = [
    'https://chieuphimquocgia.com.vn/Themes/RapChieuPhim/Content/content.v2/images/sky.jpg',
    'https://chieuphimquocgia.com.vn/Themes/RapChieuPhim/Content/content.v2/images/troll.jpg',
    'https://chieuphimquocgia.com.vn/Themes/RapChieuPhim/Content/content.v2/images/thang6.jpg',
    'https://chieuphimquocgia.com.vn/Themes/RapChieuPhim/Content/content.v2/toi%20la%20nao%20ca%20vang.jpg',
    'https://chieuphimquocgia.com.vn/Themes/RapChieuPhim/Content/content.v2/images/can phong dam mau.jpg',
    'https://chieuphimquocgia.com.vn/Themes/RapChieuPhim/Content/content.v2/ke%20truc%20dem.jpg',
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
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return new WillPopScope(
      onWillPop: _closeConfirm, 
      child: Scaffold(
      endDrawer: MenuBar(),
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: ListView(children: <Widget>[
              imageSliderCarousel(),
              tabFilms(),
              tabNews(),
              tabfooter(),
            ]),
          ),
          new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
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
                  // color: Colors.red[50],
                  onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
                ),
              ],
            ),
          ),
        ],
      ),
      //)
    ));
  }

  Widget imageSliderCarousel() {
    return Container(
      height: 129,
      child: Carousel(
        dotSize: 0.0,
        boxFit: BoxFit.fill,
        images: imgSlider.map((img) => Image.network(img, )).toList(),
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
              backgroundColor: Colors.red[900],
              //height: 700,
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: CommonString.showing,
                  ),
                  Tab(
                    text: CommonString.coming,
                  ),
                  Tab(
                    text: CommonString.special,
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
            title: Text(ReCase(CommonString.news).sentenceCase),
            backgroundColor: Colors.red[900],
            automaticallyImplyLeading: false,
            actions: <Widget>[
              InkWell(
                  child: Center(
                    child: Container(
                      width: 60,
                      height: 25,
                      margin: EdgeInsets.only(right: 15,),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.5, color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        CommonString.all,
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
 Widget tabfooter(){
  return Container(
    height: 160,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white,
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new AssetImage(
                                      "assets/images/footer.png"),
                                ),
                              ),
                            );
 }

 Future<bool> _closeConfirm() async{
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bạn muốn đóng ứng dụng ?'),
          actions: [
            FlatButton(
              onPressed: ()=>Navigator.of(context).pop(false), 
              child: Text('HUỶ')),
            FlatButton(
              onPressed: (){
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              }, 
              child: Text('ĐỒNG Ý'))
          ],
        );
      });
  }
}
