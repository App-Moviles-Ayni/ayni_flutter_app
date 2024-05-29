import 'package:flutter/material.dart';

class HomeListScreen extends StatelessWidget {

  final List<Product> products = [
    Product(name: 'Potato', description: 'Incredible potato for sale', quantity: 3000, image: "https://e00-elmundo.uecdn.es/assets/multimedia/imagenes/2024/03/07/17098165627875.jpg" ),
    Product(name: 'Broccoli', description: 'Incredible broccoli for sale', quantity: 3000, image: "https://e00-elmundo.uecdn.es/assets/multimedia/imagenes/2024/03/07/17098165627875.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu), // Asume que tienes un ícono de menú
          onPressed: () {
            // Acción al presionar el ícono de menú
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications), // Asume que tienes un ícono de campana
            onPressed: () {
              // Acción al presionar el ícono de campana
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea los widgets al inicio del eje horizontal
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Welcome, Jose.', style: TextStyle(fontSize: 35), textAlign: TextAlign.left),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Text('Find your product', style: TextStyle(fontSize: 20, color: Colors.white)),
                  TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Search',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Latest Purchases', style: TextStyle(fontSize: 24), textAlign: TextAlign.left),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(products[index].image, width: 100, height: 100),
                      Text(products[index].name),
                      Text('${products[index].quantity}kg'),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Products In Stock', style: TextStyle(fontSize: 24), textAlign: TextAlign.left),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(products[index].image, width: 50, height: 50),
                  title: Text(products[index].name),
                  subtitle: Text(products[index].description),
                  trailing: Text('${products[index].quantity}kg'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final String description;
  final int quantity;
  final String image;

  Product({required this.name, required this.description, required this.quantity, required this.image});
}

