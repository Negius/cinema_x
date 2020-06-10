import 'dart:convert';
import 'package:cinema_x/config/AppSettings.dart';
import 'package:http/http.dart' as http;

class GiftCard {
  // int id;
  String name;
  double price;
  int point;

  GiftCard(
    {
      // this.id,
    this.name,
    this.price,
    this.point
    });

  factory GiftCard.fromJson(Map<String, dynamic> json) {
    return GiftCard(
      // id: json["Id"] as int,
      name: json["Name"] as String,
      price: json["Price"] as double,
      point: json["Point"] as int
    );
  }
}

Future<List<GiftCard>> fetchGiftCards() async{
  String url = NccUrl.giftCard;
  final response = await http.post(url);
  if(response.statusCode == 200) {
    final parsed = json.decode(response.body);
    final giftCards = List<GiftCard>.from(parsed.map((p)=> GiftCard.fromJson(p))).toList();
    return giftCards;
  }else {
    throw Exception('Hiện không có thẻ quà tặng');
  }
}