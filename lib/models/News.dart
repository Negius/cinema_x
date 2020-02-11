import 'dart:convert';

import 'package:cinema_x/config/AppSettings.dart';
import 'package:http/http.dart' as http;

class News {
  int id;
  int languageId;
  String title;
  String short;
  String full;
  String urlImage;

  News(
      {this.id,
      this.languageId,
      this.title,
      this.short,
      this.full,
      this.urlImage,
      });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        id: json["Id"] as int,
        languageId: json["LanguageId"] as int,
        title: json["Title"] as String,
        short: json["Short"] as String,
        full: json["Full"] as String,
        urlImage: json["UrlImage"] as String);
       
  }
}

Future<List<News>> fetchNews() async {
  String url = NccUrl.getNews;
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    final listNews = new List<News>.from(
        parsed.map((p) => new News.fromJson(p)).toList());
    return Future.value(listNews);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}


Future<List<News>> fetchAllNews() async {
  String api = NccUrl.getAllNews;
  final response = await http.get(api);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    final listNews = new List<News>.from(
        parsed.map((p) => new News.fromJson(p)).toList());
    return Future.value(listNews);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}




