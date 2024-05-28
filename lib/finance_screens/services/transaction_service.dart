import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ayni_flutter_app/finance_screens/models/transaction.dart';

class TransactionService {
  final String baseUrl = "https://ayni-api-v2.zeabur.app/api/v1/transactions";

  Future<List<Transaction>> getAll() async {
    final http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      print("jsonResponse: $jsonResponse");

      if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey("results")) {
        final List<dynamic> maps = jsonResponse["results"];
        print("results: $maps");

        return maps.map((map) => Transaction.fromJson(map)).toList();
      } else if (jsonResponse is List<dynamic>) {
        // Manejar el caso en el que el JSON principal es una lista en lugar de un mapa
        return jsonResponse.map((map) => Transaction.fromJson(map)).toList();
      } else {
        throw Exception('Unexpected JSON structure');
      }
    } else {
      throw Exception('Failed to load transactions');
    }
  
  }

  Future<Transaction> createTransaction(Transaction transaction) async {
    final http.Response response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(transaction.toJson()),
    );

    if (response.statusCode == HttpStatus.created) {
      final jsonResponse = json.decode(response.body);
      return Transaction.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to create transaction');
    }
  }
}