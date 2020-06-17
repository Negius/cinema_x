import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/config/AppSettings.dart';
import 'package:cinema_x/models/Movie.dart';
import 'package:cinema_x/models/hall.dart';
import 'package:cinema_x/models/palette.dart';
import 'package:cinema_x/screens/booking/onePageCheckout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SeatSelection extends StatefulWidget {
  SeatSelection({
    this.movie,
    this.planId,
    this.dateTimeFull,
    Key key,
  }) : super(key: key);
  final Movie movie;
  final int planId;
  final DateTime dateTimeFull;
  
  @override
  _SeatSelectionState createState() {
    return _SeatSelectionState();
  }
}

class _SeatSelectionState extends State<SeatSelection> {
  double seatSize = 26;

  List<Map> seatSelected = [];
  List<Map> baseList = [];
  ScrollController scrollController;
  bool canLoad = true;
  bool _loading;
  bool canChangeSeat = true;
  int numOfRows = 1;
  int numOfColumns = 1;
  Future<List<Map>> _seatMap;
  final SnackBar invalidSeatChange = SnackBar(
    content: Text(CommonString.seatNoEmptySpace),
  );
  @override
  void initState() {
    _loading = true;
    _seatMap = getSeatInfo();

    super.initState();
  }

  Future<List<Map>> getSeatInfo() async {
    try {
      List<List<Map>> seats = await fetchApiSeats(widget.planId);
      numOfRows = seats.length;
      numOfColumns = seats.map((r) => r.length).toList().reduce(max);
      List<Map> result = [];
      seats.forEach((row) {
        row.forEach((seat) {
          result.add(seat);
        });
      });
      setState(() {
        _loading = false;
      });
      return result;
    } on Exception catch (error) {
      canLoad = false;
      throw (error);
    }
  }

  double scale = 1;
  double previousScale = 1;
  double startScale = 1;
  double currentSize;

  @override
  Widget build(BuildContext context) {
    double width =
        ((MediaQuery.of(context).size.width - 64) / numOfColumns < seatSize
                ? seatSize * numOfColumns + 64
                : MediaQuery.of(context).size.width) *
            scale;

    double seatLayoutWidth = width - 32;

    currentSize = (seatLayoutWidth) / numOfColumns;
    if (scrollController == null)
      scrollController = new ScrollController(
          initialScrollOffset: (width - MediaQuery.of(context).size.width) / 2);
    return Scaffold(
    //  backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(CommonString.selectSeat),
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Container(
              height: 60,
            ),
            GestureDetector(
              onScaleStart: (s) {
                setState(() {
                  startScale = scale;
                });
              },
              onScaleUpdate: (scaleDetails) {
                double newScale = startScale * scaleDetails.scale;
                if (newScale >= 1)
                  setState(() {
                    scale = newScale;
                  });
              },
              onScaleEnd: (s) {},
              child: LayoutBuilder(
                builder: (context, constraint) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: scrollController,
                  child: Container(
                    child: SizedBox(
                      width: seatLayoutWidth,
                      child: SingleChildScrollView(
                        child: LayoutBuilder(
                          builder: (context, constraints) => Column(
                            children: <Widget>[
                              Container(
                                height: 20,
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 12),
                                width: constraint.maxWidth,
                                alignment: Alignment.center,
                                child: Text(
                                  CommonString.screen,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subhead
                                      .copyWith(
                                          fontSize: Theme.of(context)
                                                  .textTheme
                                                  .subhead
                                                  .fontSize *
                                              scale,
                                          color:
                                              Palette.getContrastColor(context),
                                          fontWeight: FontWeight.w700),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: double.infinity,
                                padding: EdgeInsets.only(left: 20),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        width: 2,
                                        color: Palette.getContrastColor(context)
                                            .withOpacity(0.3),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: buildSeatLayout(context, constraints),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(bottom: 0, child: buildInfoLayout(context)),
            Visibility(
              child: Center(
                child: new CircularProgressIndicator(),
              ),
              visible: _loading,
            ),
          ],
        ),
      ),
    );
  }

  buildSeatLayout(BuildContext context, BoxConstraints constraints) {
    return FutureBuilder(
        future: _seatMap,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            baseList = snapshot.data;
            return Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 15,
                            height: 15,
                            color: Color(0xFFab9c90),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          AutoSizeText(
                            CommonString.seatNormal,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 15,
                            height: 15,
                            color: Color(0xFF914453),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          AutoSizeText(
                            CommonString.seatVip,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 15,
                            height: 15,
                            color: Colors.pink,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          AutoSizeText(
                            CommonString.seatCouple,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(color: Colors.white),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              child: Icon(
                                Icons.close,
                                size: 14,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            AutoSizeText(
                              CommonString.seatBought,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 15,
                              height: 15,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            AutoSizeText(
                              CommonString.seatSelecting,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: currentSize * numOfRows + 24,
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: numOfColumns,
                      children: snapshot.data.map<Widget>((item) {
                        int type = item["type"];
                        int status = item["status"];
                        String label = item["label"];
                        bool isSelected = seatSelected.contains(item);
                        return GestureDetector(
                          onTap: status == 0
                              ? () {
                                  seatSelect(context, item);
                                }
                              : () {},
                          child: Container(
                            width: seatSize,
                            height: seatSize,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(2),
                            decoration: type != 12
                                ? BoxDecoration(
                                    color: isSelected
                                        ? Theme.of(context).accentColor
                                        : status != 0
                                            ? Color(0xFFdbd7cc)
                                            : type == 0
                                                ? Color(0xFFab9c90)
                                                : type == 1
                                                    ? Color(0xFF914453)
                                                    : Colors.pink,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                      color: Palette.getContrastColor(context)
                                          .withOpacity(0.5),
                                    ),
                                  )
                                : null,
                            child: type != 12
                                ? FittedBox(
                                    fit: BoxFit.fill,
                                    child: status == 0
                                        ? Text(
                                            label,
                                            style: TextStyle(
                                              fontSize: seatSize * .5,
                                              color: Colors.white,
                                            ),
                                          )
                                        : Icon(Icons.close,
                                            color: Colors.white),
                                  )
                                : null,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          } else
            return Visibility(visible: false, child: Container());
        });
  }

  //Chọn ghế
  Future seatSelect(BuildContext context, Map<dynamic, dynamic> seat) async {
    
    setState(() {
      if (seatSelected.contains(seat)) {
        canChangeSeat = hasEmptySpace(seat, 1);
        if (canChangeSeat) {
          if (seat["type"] != 2) {
            seatSelected.remove(seat);
          } else {
            coupleSeatSelect(seat, 1);
          }
        } else {
          Scaffold.of(context).showSnackBar(invalidSeatChange);
        }
      } else {
        canChangeSeat = hasEmptySpace(seat, 0);
        if (canChangeSeat) {
          if (seat["type"] != 2) {
            seatSelected.add(seat);
          } else {
            coupleSeatSelect(seat, 0);
          }
        } else {
          Scaffold.of(context).showSnackBar(invalidSeatChange);
        }
      }
    });
  }

  //Chọn ghế đôi
  Future coupleSeatSelect(Map<dynamic, dynamic> seat, int option) async {    
    var coupleSeatList = baseList.where((value) => value["type"] == 2).toList();
    var index = coupleSeatList.indexOf(seat);
    if (index != -1) {
      var firstCol = coupleSeatList.first["column"];
      var col = seat["column"];
      var coupleSeat;
      if (col % 2 == firstCol % 2) {
        coupleSeat = coupleSeatList[index + 1];
      } else {
        coupleSeat = coupleSeatList[index - 1];
      }
      if (option == 0) {
        //add
        seatSelected.add(seat);
        seatSelected.add(coupleSeat);
      } else {
        seatSelected.remove(seat);
        seatSelected.remove(coupleSeat);
      }
      // print(seat);//
      // print(prefs.getString("coupleSeat"));
    }
  }

  //Kiểm tra có khoảng trống giữa các ghế được chọn không
  bool hasEmptySpace(Map<dynamic, dynamic> seat, int type) {
    var result = true;
    var col = seat["column"];
    var row = seat["row"];
    var sameRow = [];
    var colMap = [];
    seatSelected.forEach((seat) {
      if (seat["row"] == row) sameRow.add(seat);
    });
    if (sameRow.isNotEmpty) {
      colMap = sameRow.map((value) => value["column"]).toList();
      // if ((colMap.contains(col + 2) && !colMap.contains(col + 1)) ||
      //     (colMap.contains(col - 2) && !colMap.contains(col - 1)))
      type == 0 ? colMap.add(col) : colMap.remove(col);
      colMap = colMap.toSet().toList();
      colMap.sort();
      for (var i = 1; i < colMap.length; i++) {
        if (colMap[i] - colMap[i - 1] > 1) {
          result = false;
          break;
        }
      }
    }
    return result;
  }

  buildInfoLayout(BuildContext context) {
    return Hero(
      tag: "payment",
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.all(0),
        elevation: 6,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0))),
        child: Container(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          height: 120,
          padding: EdgeInsets.only(bottom: 24, top: 24, left: 24, right: 24),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "${CommonString.seatSelectedAmount}: ${seatSelected.length}",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "${CommonString.seatSelected}: ${seatSelected.map((s) => s["label"]).join(", ")}",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                ),
                flex: 1,
              ),
              GestureDetector(
                onTap: () {
                  // isSeatSelected();
                  if(seatSelected.isNotEmpty){               
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            CommonString.ticketInfo,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text(
                            CommonString.ticketInfoRecommendation,
                          ),
                          actions: <Widget>[
                            new FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                CommonString.cancel.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            new FlatButton(
                              onPressed: () {
                                setState(() {
                                  createOrder(context);
                                });
                              },
                              child: Text(
                                CommonString.accept.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                    }else{
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Quý khách vui lòng chọn ghế trước khi thanh toán!'));
                    });
                }},
                child: Container(
                  height: 30,
                  width: 100,
                  alignment: Alignment.center,
                  child: Text(
                    CommonString.checkout,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future isSeatSelected() async {
    bool isSelected = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isSelected = prefs.getBool("isSelected");
    if(isSelected=!isSelected){
      seatSelected=[];
    }
    // else{
    //   seatSelected=seatSelected;
    // }
  }

  void createOrder(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var listChairValueF1 = seatSelected.map((s) => s["label"]).join(", ");
    var seatsF1 = seatSelected.map((s) => s["seat"]).join(",");
    prefs.setString('seat', listChairValueF1);
    String url = NccUrl.createOrder;

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };

    var body = {
      "customerId": prefs.getInt("customerId") ?? 0,
      "planScreenId": widget.planId ?? 0,
      "seatsF1": seatsF1,
      "ListChairValueF1": listChairValueF1,
      "CustomerFirstName": prefs.getString("firstName") ?? "",
      "CustomerLastName": prefs.getString("lastName") ?? "",
      "CustomerEmail": prefs.getString("email") ?? "",
      "CustomerPhone": prefs.getString("phone") ?? "",
      "PaymentMethodSystemName":
          "VNPAY" //TODO: implement different payment system names?
    };
    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    var parsed = json.decode(response.body);
    var orderId = parsed["OrderId"];
    prefs.setInt("orderId", orderId);
    var total = (parsed["OrderTotal"] as double).toInt() ?? 0;
    

    var pointReward ;
    var cardlevel = prefs.getString("cardLevelName") ?? "";
    if (cardlevel == "Vip")
    {
      pointReward = total * 6 / 100;
    }
    else
    {
      pointReward = total * 4 / 100;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(
          movie: widget.movie,
          projectDateTime: widget.dateTimeFull,
          orderId: orderId,
          total: total,
          label: listChairValueF1,
          pointreward: pointReward,
        ),
      ),
    );
  }
}
