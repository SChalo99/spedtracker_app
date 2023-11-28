import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:spedtracker_app/models/movement_model.dart';
import 'package:http/http.dart' as http;
import 'package:spedtracker_app/models/ingreso_model.dart';
import 'package:spedtracker_app/models/gasto_model.dart';
import 'package:spedtracker_app/models/card_model.dart';
//import 'package:spedtracker_app/models/credit_card_model.dart';
//import 'package:spedtracker_app/models/debit_card_model.dart';

class MovementService {
  
  Future<List<MovementModel>> fetchAllIncomes(String token) async {
    Uri endpoint = Uri.parse(
        "https://proyectosoftii-backend-production.up.railway.app/ingresos");

    var response = await http.get(endpoint, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token",
    });
    List<MovementModel> movements = [];

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      for (var item in responseBody) {
        movements.add(
          IngresoModel(
              item['idIngreso'],
              item['monto'].toDouble(),
              item['descripcion'],
              DateTime.parse(item['hora']),
              DateTime.parse(item['fecha']),
              ),
        );
      }
      return movements;
    } else {
      throw Exception('Failed to fecth movement');
    }
  }
  

  Future<List<MovementModel>> fetchAllExpenses(String token) async {
    Uri endpoint = Uri.parse(
        "https://proyectosoftii-backend-production.up.railway.app/gastos");

    var response = await http.get(endpoint, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token",
    });

    List<MovementModel> movements = [];

    

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      for (var item in responseBody) {
        movements.add(
          GastoModel(
            item['idCategoria'].toInt(),
            item['nroCuotas'].toInt(),
            item['idGasto'],
            item['monto'].toDouble(),
            item['descripcion'],
            DateTime.parse(item['hora']),
            DateTime.parse(item['fecha'])),
        );
      }
      return movements;
    } else {
      throw Exception('Failed to fecth movement');
    }
  }

  Future<List<MovementModel>> fetchAllIncomesByCard(String token, CardModel? card) async {
    Uri endpoint = Uri.parse(
        "https://proyectosoftii-backend-production.up.railway.app/ingresos//ingresosPorTarjeta/${card?.idTarjeta}");

    var response = await http.get(endpoint, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token",
    });
    List<MovementModel> movements = [];

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      for (var item in responseBody) {
        movements.add(
          IngresoModel(
              item['idIngreso'],
              item['monto'].toDouble(),
              item['descripcion'],
              DateTime.parse(item['hora']),
              DateTime.parse(item['fecha']),
              ),
        );
      }
      return movements;
    } else {
      throw Exception('Failed to fecth movement');
    }
  }

  Future<List<MovementModel>> fetchAllExpensesByCard(String token, CardModel? card) async {
    Uri endpoint = Uri.parse(
        "https://proyectosoftii-backend-production.up.railway.app/gastos/gastosPorTarjeta/${card?.idTarjeta}");

    var response = await http.get(endpoint, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token",
    });
    List<MovementModel> movements = [];

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      for (var item in responseBody) {
        movements.add(
          GastoModel(
            item['idCategoria'].toInt(),
            item['nroCuotas'].toInt(),
            item['idGasto'],
            item['monto'].toDouble(),
            item['descripcion'],
            DateTime.parse(item['hora']),
            DateTime.parse(item['fecha'])),
        );
      }
      return movements;
    } else {
      throw Exception('Failed to fecth movement');
    }
  }


  Future<void> createMovement(String token, MovementModel movement, CardModel? card) async {
    JsonEncoder encoder = json.encoder;
    Uri endpoint;
    Map body;
    if (movement is IngresoModel) {
      endpoint = Uri.parse(
          "https://proyectosoftii-backend-production.up.railway.app/ingresos");
      body = {
        'monto': movement.monto,
        'descripcion': movement.descripcion,
        'idIngreso': movement.idMovimiento,
        'hora': movement.hora.toString(),
        'fecha': movement.fecha.toString(),
        'idTarjetaCredito': card?.idTarjeta
      };
    } else if (movement is GastoModel) {
      endpoint = Uri.parse(
          "https://proyectosoftii-backend-production.up.railway.app/gastos");
      body = {
        'idGasto': movement.idMovimiento,
        'hora': movement.hora.toString(),
        'fecha': movement.fecha.toString(),
        'idCategoria': movement.idCategoria,
        'monto': movement.monto,
        'descripcion': movement.descripcion,
        'nroCuotas': movement.nroCuotas,
        'idTarjetaCredito': card?.idTarjeta
      };
    } else {
      endpoint = Uri.parse(
          "https://proyectosoftii-backend-production.up.railway.app/gastos");
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
      throw Exception('Failed to create movement');
    }
  }


  Future<void> editMovement(String token, MovementModel? movement) async {
    JsonEncoder encoder = json.encoder;
    Map body;
    Uri endpoint;
    if (movement is IngresoModel) {
      endpoint = Uri.parse(
          "https://proyectosoftii-backend-production.up.railway.app/ingresos");
      body = {
        'monto': movement.monto,
        'descripcion': movement.descripcion,
        'idIngreso': movement.idMovimiento,
        'hora': movement.hora.toString(),
        'fecha': movement.fecha.toString()
      };
    } else if (movement is GastoModel) {
      endpoint = Uri.parse(
          "https://proyectosoftii-backend-production.up.railway.app/gastos");
      body = {
        'idGasto': movement.idMovimiento,
        'hora': movement.hora.toString(),
        'fecha': movement.fecha.toString(),
        'idCategoria': movement.idCategoria,
        'monto': movement.monto,
        'descripcion': movement.descripcion,
        'nroCuotas': movement.nroCuotas
      };
    } else {
      endpoint = Uri.parse(
          "https://proyectosoftii-backend-production.up.railway.app/gastos");
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
      throw Exception('Failed to edit movement');
    }
  }


  Future<void> removeMovement(String token, MovementModel movement) async {
    JsonEncoder encoder = json.encoder;
    Uri endpoint;
    Map body;
    if (movement is IngresoModel) {
      endpoint = Uri.parse(
          "https://proyectosoftii-backend-production.up.railway.app/ingresos/${movement.idMovimiento}");
      body = {
        'idIngreso': movement.idMovimiento,
      };
    } else if (movement is GastoModel) {
      endpoint = Uri.parse(
          "https://proyectosoftii-backend-production.up.railway.app/gastos/${movement.idMovimiento}");
      body = {
        'idGasto': movement.idMovimiento,
      };
    } else {
      endpoint = Uri.parse(
          "https://proyectosoftii-backend-production.up.railway.app/gastos");
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
      throw Exception('Failed to remove movement');
    }
  }
  
}