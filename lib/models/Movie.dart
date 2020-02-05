import 'dart:convert';

import 'package:http/http.dart' as http;

class Movie {
  int id;
  String name;
  int duration;
  int minimumAge;
  String director;
  String description;
  List<String> actorsName;
  String introduction;
  List<String> categories;
  String imageUrl;
  String bannerUrl;
  String videoUrl;
  String versionCode;
  String premieredDay;

  Movie(
      {this.id,
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
      this.premieredDay});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json["Id"] as int,
      name: json["FilmName"] as String,
      duration: json["Duration"] as int,
      minimumAge: json["AgeAbove"] as int,
      director: json["Director"] as String,
      description: json["Description"] as String,
      actorsName: (json["Actors"] as String).split(","),
      introduction: json["Introduction"] as String,
      categories: json["Category"] != null
          ? (json["Category"] as String).split(",")
          : [""],
      imageUrl: json["ImageUrl"] as String,
      bannerUrl: json["BannerUrl"] as String,
      videoUrl: json["VideoUrl"] as String,
      versionCode: json["VersionCode"] as String,
      premieredDay: json["PremieredDay"] as String,
    );
  }
}

Future<Movie> fetchMovie() async {
  String api = "http://testapi.chieuphimquocgia.com.vn/api/Films/9190";
  final response = await http.get(api);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    Movie movie = Movie.fromJson(parsed);

    return Future.value(movie);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<List<Movie>> fetchShowingMovies() async {
  String api = "http://testapi.chieuphimquocgia.com.vn/api/GetFilms";
  final response = await http.get(api);
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    var currentDayMovies = parsed["nextday"][0]["lstFilm"];
    final showingMovies = new List<Movie>.from(
        currentDayMovies.map((p) => new Movie.fromJson(p)).toList());
    return Future.value(showingMovies);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<List<Movie>> fetchComingMovies() async {
  String api = "http://testapi.chieuphimquocgia.com.vn/api/FilmShowings";
  final response = await http.get(api);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    final comingMovies =
        new List<Movie>.from(parsed.map((p) => new Movie.fromJson(p)).toList());
    return Future.value(comingMovies);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}


