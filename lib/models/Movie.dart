import 'dart:convert';

import 'package:cinema_x/config/AppSettings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
  String countryName;

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
      this.premieredDay,
      this.countryName
      });

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
       countryName: json["CountryName"] as String,
    );
  }
}

Future<List<Movie>> fetchShowingMovies() async {
  String url = NccUrl.getFilms;
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    var currentDayMovies = parsed["nextday"][0]["lstFilm"];
    final showingMovies = new List<Movie>.from(
        currentDayMovies.map((p) => new Movie.fromJson(p)).toList());
    return showingMovies;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<List<Movie>> fetchWatchedMovies() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var customerId = prefs.getInt("customerId");
  String url = NccUrl.filmHistory + customerId.toString();
  final response = await http.post(url);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    final filmHistory =
        new List<Movie>.from(parsed.map((p) => new Movie.fromJson(p)).toList());
    return filmHistory;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<List<Movie>> fetchComingMovies() async {
  String url = NccUrl.getFilmShowing;
  final response = await http.get(url);
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

RichText filmTitle(name, color){
  String age;
  if(name.contains('- P')){
    age = name.substring(name.length-1);
    return RichText(
      maxLines: 2,
      text: TextSpan(
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color),
        children: [
          TextSpan(text: name.substring(0, name.length-1)),
          TextSpan(text: age, style: TextStyle(color: Colors.green[600], ))
        ]
      ));
  }
  if(name.contains('- C18')){
    age = name.substring(name.length-3);
    return RichText(
      maxLines: 2,
      text: TextSpan(
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color),
        children: [
          TextSpan(text: name.substring(0, name.length-3)),
          TextSpan(text: age, style: TextStyle(color: Colors.red[600]))
        ]
      ));
  }
  if(name.contains('- C16')){
    age = name.substring(name.length-3);
    return RichText(
      maxLines: 2,
      text: TextSpan(
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color),
        children: [
          TextSpan(text: name.substring(0, name.length-3)),
          TextSpan(text: age, style: TextStyle(color: Colors.orange[600]))
        ]
      ));
  }
  if(name.contains('- C13')){
    age = name.substring(name.length-3);
    return RichText(
      maxLines: 2,
      text: TextSpan(
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color),
        children: [
          TextSpan(text: name.substring(0, name.length-3)),
          TextSpan(text: age, style: TextStyle(color: Colors.yellow[600]))
        ]
      ));
  }
  if(name.toLowerCase().contains('dự kiến')){
    return RichText(
      maxLines: 2,
      text: TextSpan(
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color),
        children: [
          TextSpan(text: name),
        ]
      ));
  }
  else{
    return RichText(
      maxLines: 2,
      text: TextSpan(
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color),
        children: [
          TextSpan(text: name),
        ]
      ));
  }
}


