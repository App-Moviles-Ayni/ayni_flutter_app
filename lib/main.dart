import 'package:ayni_flutter_app/screens/sales_list_screen.dart';
import 'package:ayni_flutter_app/home_screens/screens/products_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
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
