import 'package:ayni_flutter_app/finance_screens/screens/transaction_panels.dart';
import 'package:ayni_flutter_app/screens/sales_list_screen.dart';
import 'package:ayni_flutter_app/home_screens/screens/products_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    /*return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TransactionListScreen2(),*/
    /*return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SalesListScreen(),*/
    return MaterialApp(
      title: 'Tu Aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductsListScreen()
    );
  }
}
