import 'dart:convert';
import 'dart:io';
import 'package:ayni_flutter_app/feature_orders/models/orders.dart';
import 'package:http/http.dart' as http;

class OrdersService {
  final String baseUrl = "https://ayni-api-v2.zeabur.app/api/v1/orders";

  Future<List> getAll() async {
  final response = await http.get(
    Uri.parse(baseUrl),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == HttpStatus.ok) {
    final jsonResponse = json.decode(response.body);
    return jsonResponse.map((map) => Orders.fromJson(map)).toList();
  } else {
    return [];
  }
}

  Future post(Orders order) async {
    http.Response response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(order),
    );
    if (response.statusCode == HttpStatus.created) {
      final jsonResponse = json.decode(response.body);
      return Orders.fromJson(jsonResponse);
    }
  }

  Future<void> delete(int? id) async {
    final http.Response response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != HttpStatus.noContent) {
      throw Exception('Failed to delete');
    }
  }
}
