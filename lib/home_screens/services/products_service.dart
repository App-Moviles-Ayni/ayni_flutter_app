import 'dart:convert';
import 'dart:io';

import 'package:ayni_flutter_app/home_screens/models/products.dart';
import 'package:http/http.dart' as http;

class ProductsService {
  final String baseUrl = "https://ayni-api-v2.zeabur.app/api/v1/products";

  Future<List<Products>> getAll() async {
    final http.Response response = await http.get(Uri.parse(baseUrl));

     if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      print("jsonResponse: $jsonResponse");

      if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey("results")) {
        final List<dynamic> maps = jsonResponse["results"];
        print("results: $maps");

        return maps.map((map) => Products.fromJson(map)).toList();
      } else if (jsonResponse is List<dynamic>) {
        return jsonResponse.map((map) => Products.fromJson(map)).toList();
      } else {
        throw Exception('Unexpected JSON structure');
      }
    } else {
      throw Exception('Failed to load products');
    }
  
  }

  Future<List<Products>> getByName(String name) async {
    final http.Response response = await http.get(Uri.parse('$baseUrl?name="$name"'));

     if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      print("ProductService jsonResponse: $jsonResponse");

      if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey("results")) {
        final List<dynamic> maps = jsonResponse["results"];
        print("ProductService results: $maps");

        return maps.map((map) => Products.fromJson(map)).toList();
      } else if (jsonResponse is List<dynamic>) {
        return jsonResponse.map((map) => Products.fromJson(map)).toList();
      } else {
        throw Exception('ProductService Unexpected JSON structure');
      }
    } else {
      throw Exception('Failed to load products');
    }
  }
}