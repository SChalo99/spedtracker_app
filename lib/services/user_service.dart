import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:spedtracker_app/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<UserModel> getUser(String token) async {
    Uri endpoint = Platform.isAndroid
        ? Uri.parse("http://10.0.2.2:3000")
        : Uri.parse("http://127.0.0.1:3000");
    var response = await http.get(
      endpoint,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      UserModel userResponse = UserModel(
          responseBody['nombre'],
          responseBody['apellido'],
          responseBody['DNI'],
          responseBody['edad'],
          responseBody['email'],
          responseBody['genero'],
          responseBody['telefono']);
      return userResponse;
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<void> createUser(UserModel user) async {
    JsonEncoder encoder = json.encoder;
    Uri endpoint = Platform.isAndroid
        ? Uri.parse("http://10.0.2.2:3000")
        : Uri.parse("http://127.0.0.1:3000");
    Map body = {
      'idPersona': user.idPersona,
      'nombre': user.nombre,
      'apellido': user.apellido,
      'DNI': user.dni,
      'genero': user.genero,
      'telefono': user.telefono,
      'email': user.email,
      'edad': user.edad
    };
    String bodyToJson = encoder.convert(body);

    var response = await http.post(
      endpoint,
      body: bodyToJson,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      debugPrint("Created!");
    } else {
      throw Exception('Failed to create user');
    }
  }
}
