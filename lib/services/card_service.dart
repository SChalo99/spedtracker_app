import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:spedtracker_app/models/card_model.dart';
import 'package:http/http.dart' as http;
import 'package:spedtracker_app/models/credit_card_model.dart';
import 'package:spedtracker_app/models/debit_card_model.dart';
import 'package:spedtracker_app/models/user_singleton.dart';

class CardService {
  1
  Future<List<CardModel>> fetchAllDebit(String token) async {
    Uri endpoint = Uri.parse(
        "https://proyectosoftii-backend-production.up.railway.app/tarjetas_debito");

    var response = await http.get(endpoint, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token",
    });
    List<CardModel> cards = [];

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      UserSingleton user = UserSingleton.instance;
      for (var item in responseBody) {
        cards.add(
          DebitCard(
              item['idTarjetaDebito'],
              item['numeroTarjeta'],
              item['moneda'],
              DateTime.parse(item['fechaVencimiento']),
              item['operadoraFinanciera'],
              item['numeroCuenta'],
              item['ingresoMinimo'].toDouble(),
              cardHolder:
                  "${user.currentUser.nombre} ${user.currentUser.apellido}"),
        );
      }
      return cards;
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
    List<CardModel> cards = [];
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      UserSingleton user = UserSingleton.instance;
      for (var item in responseBody) {
        cards.add(CreditCard(
          item['idTarjetaCredito'],
          item['numeroTarjeta'],
          item['moneda'],
          DateTime.parse(item['fechaVencimiento']),
          item['operadoraFinanciera'],
          DateTime.parse(item['fechaFacturacion']),
          DateTime.parse(item['ultimoDiaPago']),
          item['tasaInteres'].toDouble(),
          item['lineaCredito'].toDouble(),
          cardHolder: "${user.currentUser.nombre} ${user.currentUser.apellido}",
        ));
      }
      return cards;
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
        'fechaVencimiento': card.expDate.toString(),
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
        'fechaVencimiento': card.expDate.toString(),
        'operadoraFinanciera': card.operadoraFinanciera,
        'ultimoDiaPago': card.ultimoDiaPago.toString(),
        'fechaFacturacion': card.fechaFacturacion.toString(),
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
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      debugPrint("Created");
    } else {
      throw Exception('Failed to create card');
    }
  }

  /*4
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
        'fechaVencimiento': card.expDate.toString(),
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
        'fechaVencimiento': card.expDate.toString(),
        'operadoraFinanciera': card.operadoraFinanciera,
        'ultimoDiaPago': card.ultimoDiaPago.toString(),
        'fechaFacturacion': card.fechaFacturacion.toString(),
        'tasaInteres': card.tasaInteres,
        'lineaCredito': card.lineaCredito,
      };
    } else {
      endpoint = Uri.parse(
          "https://proyectosoftii-backend-production.up.railway.app/tarjetas_credito");
      body = {};
    }

    String bodyToJson = encoder.convert(body);

    var response = await http.put(endpoint, body: bodyToJson, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token",
    });

    if (response.statusCode == 200) {
      debugPrint("Edited");
    } else {
      throw Exception('Failed to edit card');
    }
  }
  4*/
/*5
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
        'idTarjetaDebito': card.idTarjeta,
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

    var response = await http.delete(endpoint, body: bodyToJson, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      debugPrint("Deleted");
    } else {
      throw Exception('Failed to remove card');
    }
  }
  5
}*/

