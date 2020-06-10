import 'package:cinema_x/models/giftCard.dart';
import 'package:flutter/material.dart';

class GiftCardPage extends StatefulWidget {
  @override
  _GiftCardPageState createState() => _GiftCardPageState();
}

class _GiftCardPageState extends State<GiftCardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<List<GiftCard>> _giftCard;

  @override
  void initState(){
    _giftCard = fetchGiftCards();//
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // endDrawer: MenuBar(),
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('Thẻ quà tặng'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
          ),
        ],
        backgroundColor: Colors.red[900],
      ),
      body: FutureBuilder(
        future: _giftCard,
        builder: (context, snapshot){
          if(snapshot.hasData){
            if(snapshot.data.length > 0){
              return Container(
                child: ListView(
                  children: (snapshot.data as List<GiftCard>).map((data) {
                    String tkPrice = data.price.toString();
                    String shownPrice = tkPrice.substring(0, tkPrice.length-2);
                    String giftPoint = data.point.toString();
                    String exchangePoint = giftPoint.substring(0, giftPoint.length-2);
                  
                    return GestureDetector(
                      onTap: (){},
                      child: Card(
                        margin: EdgeInsets.all(5),
                        elevation: 2.0,
                        shadowColor: Colors.grey,
                        // color: Colors.orange[900],
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              Column(
                                children:<Widget>[
                                  getImage(data.name),
                                  SizedBox(height: 10),
                                  Image.asset('assets/images/logo_home.png', height: 30, width: 30, alignment: Alignment.center, fit: BoxFit.contain,),
                                ]
                              ),
                              SizedBox(width:20),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:<Widget>[
                                    Text(data.name, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red[900])),
                                    SizedBox(height: 20),
                                    Text(shownPrice + ' đ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                                    SizedBox(height: 10),
                                    Text('Điểm quy đổi: '+ exchangePoint, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue))
                                  ]
                              ))
                            ]
                          ),
                        )
                      ),
                    );
                  }).toList(),
                )
              );
            } else {
              return Container();
            }
          } 
          else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          
          } 
        }),
    );
  }

  Image getImage(name) {
    double iconDimension = 80;
    if(name.contains('Bắp')){
      return Image.asset('assets/images/popcorn.png', height: iconDimension, width: iconDimension, fit: BoxFit.scaleDown);
    }
    if(name.contains('Vé')){
      return Image.asset('assets/images/film.png', height: iconDimension, width: iconDimension, fit: BoxFit.scaleDown);
    }   
    if(name.contains('Nước')){
      return Image.asset('assets/images/beverage.png', height: iconDimension, width: iconDimension, fit: BoxFit.scaleDown);
    }
  }
}