import 'dart:convert';

import 'package:cinema_x/config/AppSettings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class History {
  int id;
  String filmName;
  String filmImage;
  String buyCreatedOnUtc;
  int tickets;
  String listChairValue;
  double orderTotal;

  History(
      {
      this.id,
      this.filmName,
      this.filmImage,
      this.buyCreatedOnUtc,
      this.tickets,
      this.listChairValue,
      this.orderTotal,
      });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json["Id"] as int,
      filmName: json["FilmName"] as String,
      filmImage: json["FilmImage"] as String,
      buyCreatedOnUtc: json["BuyCreatedOnUtc"] as String,
      tickets: json["Tickets"] as int,
      listChairValue: json["ListChairValue"] as String,
      orderTotal: json["OrderTotal"] as double,
    );
  }
}

Future<List<History>> fetchTicketHistory() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
    var customerId = prefs.getInt("customerId");
  String url = NccUrl.ticketHistory + customerId.toString();
  final response = await http.post(url);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    final ticketHistory =
        new List<History>.from(parsed.map((p) => new History.fromJson(p)).toList());
    return ticketHistory;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}


