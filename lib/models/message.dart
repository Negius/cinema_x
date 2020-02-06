import 'package:flutter/material.dart';

@immutable
class Message {
  final String title;
  final String body;
  final String filmId;
  final String filmName;

  const Message({
    @required this.title,
    @required this.body,
    @required this.filmId,
    @required this.filmName,
  });
}