import 'dart:convert';
import 'dart:io';
import 'package:spedtracker_app/models/card_list.dart';
import 'package:spedtracker_app/models/card_model.dart';
import 'package:http/http.dart' as http;

class CardService {
  Future<List<CardModel>> fetchAll(String token) async {
    Uri endpoint = Platform.isAndroid
        ? Uri.parse("http://10.0.2.2:3000")
        : Uri.parse("http://127.0.0.1:3000");

    var response = await http.get(endpoint, headers: {
      "Authorization": "Bearer $token",
    });
    CardModelList cards = CardModelList.instance;
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      for (var item in responseBody) {
        cards.addCard(
          CardModel(
            item['id'],
            item['numTarjeta'],
            item['tipo'],
            item['cardHolder'],
            item['expMonth'],
            item['expYear'],
            item['service'],
          ),
        );
      }
      return cards.cardList;
    } else {
      throw Exception('Failed to fecth card');
    }
  }
}
