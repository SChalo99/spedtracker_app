import 'dart:convert';
import 'package:spedtracker_app/models/card_list.dart';
import 'package:spedtracker_app/models/card_model.dart';
import 'package:http/http.dart' as http;
import 'package:spedtracker_app/models/credit_card_model.dart';
import 'package:spedtracker_app/models/debit_card_model.dart';

class CardService {
  Future<List<CardModel>> fetchAllDebit(String token) async {
    Uri endpoint = Uri.parse(
        "https://proyectosoftii-backend-production.up.railway.app/tarjetas_debito");

    var response = await http.get(endpoint, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token",
    });
    CardModelList cards = CardModelList.instance;
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      for (var item in responseBody) {
        cards.addCard(
          DebitCard(
            item['idTarjetaDebito'],
            item['numeroTarjeta'],
            item['moneda'],
            item['fechaVencimiento'],
            item['operadoraFinanciera'],
            item['numeroCuenta'],
            item['ingresoMinimo'],
          ),
        );
      }
      return cards.cardList;
    } else {
      throw Exception('Failed to fecth card');
    }
  }

  Future<List<CardModel>> fetchAllCredit(String token) async {
    Uri endpoint = Uri.parse(
        "https://proyectosoftii-backend-production.up.railway.app/tarjetas_credito");

    var response = await http.get(endpoint, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token",
    });
    CardModelList cards = CardModelList.instance;
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      for (var item in responseBody) {
        cards.addCard(CreditCard(
          item['idTarjetaCredito'],
          item['numeroTarjeta'],
          item['moneda'],
          item['fechaVencimiento'],
          item['operadoraFinanciera'],
          item['fechaFacturacion'],
          item['ultimoDiaPago'],
          item['tasaInteres'],
          item['lineaCredito'],
        ));
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
    Uri endpoint;
    Map body;
    if (card is DebitCard) {
      endpoint = Uri.parse(
          "https://proyectosoftii-backend-production.up.railway.app/tarjetas_debito");
      body = {
        'idTarjetaDebito': card.idTarjeta,
        'numeroTarjeta': card.numeroTarjeta,
        'numeroCuenta': card.accountNum,
        'moneda': card.moneda,
        'fechaVencimiento': card.expDate,
        'operadoraFinanciera': card.operadoraFinanciera,
        'ingresoMinimo': card.ingresoMinimo,
      };
    } else if (card is CreditCard) {
      endpoint = Uri.parse(
          "https://proyectosoftii-backend-production.up.railway.app/tarjetas_credito");
      body = {
        'idTarjetaCredito': card.idTarjeta,
        'numeroTarjeta': card.numeroTarjeta,
        'moneda': card.moneda,
        'fechaVencimiento': card.expDate,
        'operadoraFinanciera': card.operadoraFinanciera,
        'ultimoDiaPago': card.ultimoDiaPago,
        'fechaFacturacion': card.fechaFacturacion,
        'tasaInteres': card.tasaInteres,
        'lineaCredito': card.lineaCredito,
      };
    } else {
      endpoint = Uri.parse(
          "https://proyectosoftii-backend-production.up.railway.app/tarjetas_debito");
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
      throw Exception('Failed to create card');
    }
  }

  Future<void> editCard(
    String token,
    CardModel card,
  ) async {
    JsonEncoder encoder = json.encoder;
    Map body;
    Uri endpoint;
    if (card is DebitCard) {
      endpoint = Uri.parse(
          "https://proyectosoftii-backend-production.up.railway.app/tarjetas_debito");
      body = {
        'idTarjetaDebito': card.idTarjeta,
        'numeroTarjeta': card.numeroTarjeta,
        'numeroCuenta': card.accountNum,
        'moneda': card.moneda,
        'fechaVencimiento': card.expDate,
        'operadoraFinanciera': card.operadoraFinanciera,
        'ingresoMinimo': card.ingresoMinimo,
      };
    } else if (card is CreditCard) {
      endpoint = Uri.parse(
          "https://proyectosoftii-backend-production.up.railway.app/tarjetas_credito");
      body = {
        'idTarjetaCredito': card.idTarjeta,
        'numeroTarjeta': card.numeroTarjeta,
        'moneda': card.moneda,
        'fechaVencimiento': card.expDate,
        'operadoraFinanciera': card.operadoraFinanciera,
        'ultimoDiaPago': card.ultimoDiaPago,
        'fechaFacturacion': card.fechaFacturacion,
        'tasaInteres': card.tasaInteres,
        'lineaCredito': card.lineaCredito,
      };
    } else {
      endpoint = Uri.parse(
          "https://proyectosoftii-backend-production.up.railway.app/tarjetas_credito");
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
      throw Exception('Failed to edit card');
    }
  }

  Future<void> removeCard(
    String token,
    CardModel card,
  ) async {
    JsonEncoder encoder = json.encoder;
    Uri endpoint;
    Map body;
    if (card is DebitCard) {
      endpoint = Uri.parse(
          "https://proyectosoftii-backend-production.up.railway.app/tarjetas_debito/${card.idTarjeta}");
      body = {
        'idTarjetaCredito': card.idTarjeta,
      };
    } else if (card is CreditCard) {
      endpoint = Uri.parse(
          "https://proyectosoftii-backend-production.up.railway.app/tarjetas_credito/${card.idTarjeta}");
      body = {
        'idTarjetaCredito': card.idTarjeta,
      };
    } else {
      endpoint = Uri.parse(
          "https://proyectosoftii-backend-production.up.railway.app/tarjetas_credito");
      body = {};
    }

    String bodyToJson = encoder.convert(body);

    var response = await http.post(endpoint, body: bodyToJson, headers: {
      "Authorization": "Bearer $token",
    });
    CardModelList cards = CardModelList.instance;
    if (response.statusCode == 200) {
      cards.removeCard(card.idTarjeta);
    } else {
      throw Exception('Failed to remove card');
    }
  }
}
