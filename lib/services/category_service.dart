import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spedtracker_app/models/categoria_model.dart';

class CategoryService {
  Future<List<CategoriaModel>> fetchCategories() async {
    Uri endpoint = Uri.parse(
        "https://proyectosoftii-backend-production.up.railway.app/categoria");

    var response = await http.get(endpoint, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });
    List<CategoriaModel> categories = [];

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      for (var item in responseBody) {
        categories
            .add(CategoriaModel(item['idCategoria'], item['nombreCategoria']));
      }
      return categories;
    } else {
      throw Exception('Failed to fecth categories');
    }
  }
}
