import 'dart:convert';

import 'package:cinema_x/models/Movie.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Schedule {
  int id;
  int planCinemaId;
  DateTime projectDateTime;
  int roomId;
}

Future<List<Map<String, dynamic>>> fetchSchedules() async {
  String api = "http://testapi.chieuphimquocgia.com.vn/api/GetAllSession";
  List<Map<String, dynamic>> listSchedule = [];
  var response = await http.get(api);
  if (response.statusCode == 200) {
    var body = json.decode(response.body);
    List<dynamic> listDay = body["listday"].toList().map((t) {
      return {
        "Day": DateFormat("dd-MM-yyyy").parse(t["Day"]),
        "listFilm": listFilmByDay(t["lstFilm"]),
      };
    }).toList();
    for (Map<String, dynamic> i in listDay) {
      if (i["listFilm"].toList().isNotEmpty) {
        listSchedule.add(i);
      }
    }
  }
  if (listSchedule.isNotEmpty)
    return listSchedule;
  else
    throw Exception("Cannot load schedule");
}

List<Map<String, dynamic>> listFilmByDay(List<dynamic> list) {
  return list.toList().map((film) {
    return {
      "Movie": new Movie(
        id: film["Id"] as int,
        name: film["FilmName"] as String,
        imageUrl: film["ImageUrl"] as String,
        description: film["Description"] as String,
        duration: film["Duration"] as int,
      ),
      "listSession": listSessionByFilm(film["lstSession"]),
    };
  }).toList();
}

List<Map<String, dynamic>> listSessionByFilm(List<dynamic> film) {
  return film.toList().map((session) {
    return {
      "Id": session["Id"],
      "ProjectDateTime": DateTime.parse(session["ProjectTime"]),
    };
  }).toList();
}
