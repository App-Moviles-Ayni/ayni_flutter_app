import 'dart:convert';
import 'dart:io';
import 'package:ayni_flutter_app/feature_orders/models/sales.dart';
import 'package:ayni_flutter_app/feature_orders/models/sales_response.dart';
import 'package:http/http.dart' as http;

class SalesService {
  final String baseUrl = "https://ayni-api-v2.zeabur.app/api/v1/sales";

  Future<List> getAll() async {
    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse.map((map) => Sales.fromJson(map)).toList();
    }
    return [];
  }

  Future<Sales> getSaleByOrderId(String saleId, String orderId) async {
    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse.map((map) => Sales.fromJson(map)).toList();
    }
    return {} as Sales;
  }

  Future<Sales> getSaleById(String saleId) async {
    http.Response response = await http.get(Uri.parse('$baseUrl/$saleId'));
    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      return Sales.fromJson(jsonResponse);
    }
    return {} as Sales;
  }
  

  Future<SalesResponse> post(Sales sale) async {
    http.Response response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(sale),
    );
    if (response.statusCode == HttpStatus.created) {
      final jsonResponse = json.decode(response.body);
      return SalesResponse.fromJson(jsonResponse);
    }
    return {} as SalesResponse;
  }
}