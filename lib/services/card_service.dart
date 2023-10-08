import 'dart:convert';
import 'dart:io';
import 'package:spedtracker_app/models/card_list.dart';
import 'package:spedtracker_app/models/card_model.dart';
import 'package:http/http.dart' as http;
import 'package:spedtracker_app/models/credit_card_model.dart';
import 'package:spedtracker_app/models/debit_card_model.dart';

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
        if (item['tipo'] == 'DEBITO') {
          cards.addCard(
            DebitCard(
              item['id'],
              item['numTarjeta'],
              item['currency'],
              item['tipo'],
              item['cardHolder'],
              item['expMonth'],
              item['expYear'],
              item['service'],
              item['accountNum'],
            ),
          );
        } else if (item['tipo'] == 'CREDITO') {
          cards.addCard(CreditCard(
            item['id'],
            item['numTarjeta'],
            item['currency'],
            item['tipo'],
            item['cardHolder'],
            item['expMonth'],
            item['expYear'],
            item['service'],
            item['dueDate'],
            item['lastPayDay'],
            item['interest'],
          ));
        }
      }
      return cards.cardList;
    } else {
      throw Exception('Failed to fecth card');
    }
  }

  Future<void> createCard(
    String token,
    CardModel card,
  ) async {
    JsonEncoder encoder = json.encoder;
    Uri endpoint = Platform.isAndroid
        ? Uri.parse("http://10.0.2.2:3000")
        : Uri.parse("http://127.0.0.1:3000");
    Map body;
    if (card is DebitCard) {
      body = {
        'cardId': card.cardId,
        'cardNumber': card.cardNum,
        'accountNum': card.accountNum,
        'currency': card.currency,
        'expMonth': card.expMonth,
        'expYear': card.expYear,
        'service': card.service,
        'cardHolder': card.cardHolder,
        'type': card.type,
      };
    } else if (card is CreditCard) {
      body = {
        'cardId': card.cardId,
        'cardNumber': card.cardNum,
        'currency': card.currency,
        'expMonth': card.expMonth,
        'expYear': card.expYear,
        'service': card.service,
        'cardHolder': card.cardHolder,
        'type': card.type,
        'lastPayDay': card.lastPayDay,
        'dueDate': card.dueDate,
        'interest': card.interest
      };
    } else {
      body = {};
    }

    String bodyToJson = encoder.convert(body);

    var response = await http.post(endpoint, body: bodyToJson, headers: {
      "Authorization": "Bearer $token",
    });
    CardModelList cards = CardModelList.instance;
    if (response.statusCode == 200) {
      cards.addCard(card);
    } else {
      throw Exception('Failed to fecth card');
    }
  }

  Future<void> editCard(
    String token,
    CardModel card,
  ) async {
    JsonEncoder encoder = json.encoder;
    Uri endpoint = Platform.isAndroid
        ? Uri.parse("http://10.0.2.2:3000")
        : Uri.parse("http://127.0.0.1:3000");
    Map body;
    if (card is DebitCard) {
      body = {
        'cardId': card.cardId,
        'cardNumber': card.cardNum,
        'accountNum': card.accountNum,
        'currency': card.currency,
        'expMonth': card.expMonth,
        'expYear': card.expYear,
        'service': card.service,
        'cardHolder': card.cardHolder,
        'type': card.type,
      };
    } else if (card is CreditCard) {
      body = {
        'cardId': card.cardId,
        'cardNumber': card.cardNum,
        'currency': card.currency,
        'expMonth': card.expMonth,
        'expYear': card.expYear,
        'service': card.service,
        'cardHolder': card.cardHolder,
        'type': card.type,
        'lastPayDay': card.lastPayDay,
        'dueDate': card.dueDate,
        'interest': card.interest
      };
    } else {
      body = {};
    }

    String bodyToJson = encoder.convert(body);

    var response = await http.post(endpoint, body: bodyToJson, headers: {
      "Authorization": "Bearer $token",
    });
    CardModelList cards = CardModelList.instance;
    if (response.statusCode == 200) {
      cards.editCard(card);
    } else {
      throw Exception('Failed to fecth card');
    }
  }

  Future<void> removeCard(
    String token,
    CardModel card,
  ) async {
    JsonEncoder encoder = json.encoder;
    Uri endpoint = Platform.isAndroid
        ? Uri.parse("http://10.0.2.2:3000")
        : Uri.parse("http://127.0.0.1:3000");
    Map body;
    if (card is DebitCard) {
      body = {
        'cardId': card.cardId,
        'cardNumber': card.cardNum,
        'accountNum': card.accountNum,
        'currency': card.currency,
        'expMonth': card.expMonth,
        'expYear': card.expYear,
        'service': card.service,
        'cardHolder': card.cardHolder,
        'type': card.type,
      };
    } else if (card is CreditCard) {
      body = {
        'cardId': card.cardId,
        'cardNumber': card.cardNum,
        'currency': card.currency,
        'expMonth': card.expMonth,
        'expYear': card.expYear,
        'service': card.service,
        'cardHolder': card.cardHolder,
        'type': card.type,
        'lastPayDay': card.lastPayDay,
        'dueDate': card.dueDate,
        'interest': card.interest
      };
    } else {
      body = {};
    }

    String bodyToJson = encoder.convert(body);

    var response = await http.post(endpoint, body: bodyToJson, headers: {
      "Authorization": "Bearer $token",
    });
    CardModelList cards = CardModelList.instance;
    if (response.statusCode == 200) {
      cards.removeCard(card.cardId);
    } else {
      throw Exception('Failed to remove debit card');
    }
  }
}
