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
                    return GestureDetector(
                      onTap: (){},
                      child: Card(
                        margin: EdgeInsets.all(5),
                        elevation: 1.0,
                        color: Colors.orange[900],
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      // Flexible(
                                      //   fit: FlexFit.tight,
                                      //   child:
                                        Text(data.name, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)
                                        // )
                                        ),
                                      SizedBox(height: 10),
                                      // Flexible(
                                      //   fit: FlexFit.tight,
                                      //   child: 
                                        Text('NCC', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)
                                        // )
                                        ), 
                                      // Divider(thickness: 3, color: Colors.white,),
                                      // Divider(thickness: 3, color: Colors.white,),
                                    ] 
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    // width: 70,
                                    child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      // Flexible(
                                      //   fit: FlexFit.tight,
                                      //   child: 
                                        Row(
                                        children: <Widget>[
                                          Icon(Icons.star_border, size: 5.0, color: Colors.white),
                                          Icon(Icons.star_half, size: 7.0, color: Colors.white),
                                          Icon(Icons.star, size: 10, color: Colors.white)
                                        ]
                                        // )
                                        ),
                                      // Flexible(
                                      //   fit: FlexFit.tight,
                                      //   child: 
                                        Row(
                                        children: <Widget>[
                                          Image.asset('assets/images/gift.png', height: 20, width: 20, fit: BoxFit.scaleDown, color: Colors.white)
                                        ]
                                      // )
                                      ),
                                      // Flexible(
                                      //   fit: FlexFit.tight,
                                        // child: 
                                        Row(
                                        children: <Widget>[
                                          Image.asset('assets/images/popcorn.png', height: 20, width: 20, fit: BoxFit.scaleDown, color: Colors.white),
                                          Image.asset('assets/images/beverage.png', height: 20, width: 20, fit: BoxFit.scaleDown, color: Colors.white)
                                        ]
                                      )
                                      // )
                                    ]
                                  )
                                  )
                                ]
                              ),
                              Text(data.price.toString() + 'đ', style: TextStyle(color: Colors.white,fontSize: 40, fontWeight: FontWeight.bold),)
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
}