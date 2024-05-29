import 'package:flutter/material.dart';

class CropsListScreen extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'Potato', description: 'Incredible potato for sale', quantity: 1000, image: "https://e00-elmundo.uecdn.es/assets/multimedia/imagenes/2024/03/07/17098165627875.jpg" , price: 19.99),
    Product(name: 'Cucumber', description: 'Incredible cucumber for sale', quantity: 2000, image: "https://e00-elmundo.uecdn.es/assets/multimedia/imagenes/2024/03/07/17098165627875.jpg" , price: 19.99),
    Product(name: 'Broccoli', description: 'Incredible broccoli for sale', quantity: 1500, image: "https://e00-elmundo.uecdn.es/assets/multimedia/imagenes/2024/03/07/17098165627875.jpg" , price: 19.99),
    // Agrega más productos aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Welcome, Jose.', style: TextStyle(fontSize: 24)),
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
            child: Text('Hot Deals', style: TextStyle(fontSize: 24)),
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
                      Image.asset(products[index].image, width: 100, height: 100),
                      Text(products[index].name),
                      Text('\$${products[index].price} per kg'),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('All my products', style: TextStyle(fontSize: 24)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(products[index].image, width: 50, height: 50),
                  title: Text(products[index].name),
                  subtitle: Text(products[index].description),
                  trailing: Text('\$${products[index].price} per kg'),
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
  final double price;

  Product({required this.name, required this.description, required this.quantity, required this.image, required this.price});
}