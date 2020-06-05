import 'dart:convert';
import 'package:cinema_x/config/AppSettings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Watched {
  int id;
  String name;
  int duration;
  int minimumAge;
  String director;
  String description;
  List<String> actorsName;
  String introduction;
  String categories;
  String imageUrl;
  String bannerUrl;
  String videoUrl;
  String versionCode;
  String premieredDay;
  String countryName;

  

  Watched(
      {
      this.id,
      this.name,
      this.duration,
      this.minimumAge,
      this.director,
      this.description,
      this.actorsName,
      this.introduction,
      this.categories,
      this.imageUrl,
      this.bannerUrl,
      this.videoUrl,
      this.versionCode,
      this.premieredDay,
      this.countryName
      });
  
   factory Watched.fromJson(Map<String, dynamic> json) {
    return Watched(
      id: json["Id"] as int,
      name: json["FilmName"] as String,
      duration: json["Duration"] as int,
      minimumAge: json["AgeAbove"] as int,
      director: json["Director"] as String,
      description: json["Description"] as String,
      actorsName: (json["Actors"] as String).split(","),
      introduction: json["Introduction"] as String,
      categories: json["Category"] as String,
      imageUrl: json["ImageUrl"] as String,
      bannerUrl: json["BannerUrl"] as String,
      videoUrl: json["VideoUrl"] as String,
      versionCode: json["VersionCode"] as String,
      premieredDay: json["PremieredDay"] as String,
      countryName: json["CountryName"] as String,
    );
  }

}

  
  // Future<List<Watched>> fetchWatchedMovies() async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var customerId = prefs.getInt("customerId");
  // String url = NccUrl.filmHistory + customerId.toString();
  // final response = await http.post(url);
  // if (response.statusCode == 200) {
  //   final parsed = json.decode(response.body);
  //   final filmHistory =
  //       new List<Watched>.from(parsed.map((p) => new Watched.fromJson(p)).toList());
  //   return filmHistory;
  // } else {
  //   // If that call was not successful, throw an error.
  //   throw Exception('Failed to load post');
  // }
//}