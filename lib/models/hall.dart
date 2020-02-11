import 'dart:convert';

import 'package:cinema_x/config/AppSettings.dart';
import 'package:cinema_x/models/seat.dart';
import 'package:http/http.dart' as http;

Future<List<List<Map>>> fetchApiSeats(int planId) async {
  String url = NccUrl.getSeat + planId.toString();
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    List<Seat> seatList = new List<Seat>();
    var seatMap = new List<List<Map>>();
    var k = 0, l = 0;

    for (var i in parsed) {
      for (var j in i) {
        seatList.add(new Seat.fromJson(j));
        l++;
      }
      seatMap.add(seatList
          .sublist(k, l <= seatList.length ? l : seatList.length)
          .map((seat) => {
                "y": seat.y,
                "seat": seat.seat,
                "label": seat.code,
                "type": seat.type,
                "row": seat.row,
                "column": seat.column,
                "status": seat.status,
                "price": seat.price
              })
          .toList());
      k = l;
    }

    return Future.value(seatMap);
  } else {
    // If that call was not successful, throw an error.
    throw Exception("Error ${response.statusCode}: ${response.reasonPhrase}");
  }
}
