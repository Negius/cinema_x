import 'dart:convert';

import 'package:http/http.dart' as http;

class Session {
  int id;
  int planCinemaId;
  DateTime projectDateTime;
  int roomId;
  String roomName;
  int price1;
  int price2;
  int price3;
  int price4;

  Session(
      {this.id,
      this.planCinemaId,
      this.projectDateTime,
      this.roomId,
      this.roomName,
      this.price1,
      this.price2,
      this.price3,
      this.price4});

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json["Id"] as int,
      planCinemaId: json["PlanCinemaId"] as int,
      projectDateTime: DateTime.parse(json["ProjectTime"] as String),
      roomId: json["RoomId"] as int,
      roomName: json["RoomName"] as String,
      price1: json["PriceOfPosition1"] != null
          ? int.parse(json["PriceOfPosition1"].split(":").last)
          : 0,
      price2: json["PriceOfPosition2"] != null
          ? int.parse(json["PriceOfPosition2"].split(":").last)
          : 0,
      price3: json["PriceOfPosition3"] != null
          ? int.parse(json["PriceOfPosition3"].split(":").last)
          : 0,
      price4: json["PriceOfPosition4"] != null
          ? int.parse(json["PriceOfPosition4"].split(":").last)
          : 0,
    );
  }
}

Future<List<Session>> fetchSessions(int id) async {
  String api =
      "http://testapi.chieuphimquocgia.com.vn/api/GetAllSessionbyFilm?Filmid=${id.toString()}";
  final response = await http.post(api);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    final sessions = new List<Session>.from(
        parsed.map((p) => new Session.fromJson(p)).toList());
    return Future.value(sessions);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
