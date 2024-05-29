import 'dart:convert';
import 'dart:io';

import 'package:ayni_flutter_app/home_screens/models/products.dart';
import 'package:http/http.dart' as http;

class ProductsService {
  final String baseUrl = "https://ayni-api-v2.zeabur.app/api/v1/products";

  Future<List> getAll(int page) async {
    http.Response response = await http.get(Uri.parse("$baseUrl?page=$page"));

    if (response.statusCode == HttpStatus.ok) {
      final Map<String, dynamic> responseMap = json.decode(response.body);
      List maps = responseMap["products"];
      return maps.map((map) => Products.fromJson(map)).toList();
    }
    return [];
  }
}