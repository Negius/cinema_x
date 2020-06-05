import 'dart:convert';

import 'package:cinema_x/config/AppSettings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PointHistory {
  int id;
  String pointDate;
  double pointRewardChange;
  double pointCardChange;
  String changeReason;

  PointHistory(
      {
      this.id,
      this.pointDate,
      this.pointRewardChange,
      this.pointCardChange,
      this.changeReason,
      });

  factory PointHistory.fromJson(Map<String, dynamic> json) {
    return PointHistory(
      id: json["Id"] as int,
      pointDate: json["PointDate"] as String,
      pointRewardChange: json["PointRewardChange"] as double,
      pointCardChange: json["PointCardChange"] as double,
      changeReason: json["ChangeReason"] as String,
    );
  }
}

Future<List<PointHistory>> fetchPointHistory() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
    var customerId = prefs.getInt("customerId");
  String url = NccUrl.pointHistory + customerId.toString();
  final response = await http.post(url);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    final pointHistory =
        new List<PointHistory>.from(parsed.map((p) => new PointHistory.fromJson(p)).toList());
    return pointHistory;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}


