import 'dart:async';
import 'dart:math';
import 'package:ayni_flutter_app/feature_orders/screens/sales_list_screen.dart';
import 'package:ayni_flutter_app/finance_screens/screens/transaction_panels.dart';
import 'package:ayni_flutter_app/shared/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ayni_flutter_app/home_screens/screens/crops_list_screen.dart';
import 'package:ayni_flutter_app/home_screens/services/products_service.dart';
import 'package:ayni_flutter_app/home_screens/models/products.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  _ProductsListScreenState createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  final ProductsService _productsService = ProductsService();
  List<Products> _products = [];
  List<Products> _shuffledProducts = [];
  bool _isLoading = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _startShuffleTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startShuffleTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      _shuffleProducts();
    });
  }

  Future<void> _fetchProducts() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getInt('userId');

    List<Products> products = await _productsService.getAll();
    List<Products> filteredProducts = products.where(
      (product) => product.userId == userId).toList();
    
    setState(() {
      _products = filteredProducts;
      _isLoading = false;
    });
  }

  void _shuffleProducts() {
    setState(() {
      _shuffledProducts = List.of(_products);
      _shuffledProducts.shuffle(Random());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Welcome.',
                    style: TextStyle(fontSize: 35),
                    textAlign: TextAlign.left,
                  ),
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
                        const Text('Find your product',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Latest Crops',
                          style: TextStyle(fontSize: 24)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CropsListScreen()),
                          );
                        },
                        child: const Text('See All ->',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _shuffledProducts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                  _shuffledProducts[index].imageUrl,
                                  width: 100,
                                  height: 150,
                                  fit: BoxFit.cover),
                            ),
                            Positioned(
                              top: 8.0,
                              left: 8.0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                child: Text(
                                  _shuffledProducts[index].name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child:
                      Text('Your products', style: TextStyle(fontSize: 24)),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: _products.length,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.all(8.0),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_products[index].name,
                                style: const TextStyle(fontSize: 16)),
                            Text(
                              _products[index].description.length > 50
                                  ? _products[index]
                                          .description
                                          .substring(0, 50) +
                                      '...'
                                  : _products[index].description,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        trailing: ClipOval(
                          child: Image.network(_products[index].imageUrl,
                              width: 50, height: 50, fit: BoxFit.cover),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 1.0, // Altura de la línea negra
            color: Colors.white, // Color de la línea negra
          ),
          BottomNavBar(
              currentIndex: 0,
              onTap: (index) {
                switch (index) {
                  case 0:
                    Navigator.push(context,
                        SlideTransitionPageRoute(page: const ProductsListScreen()));
                    break;
                  case 1:
                    Navigator.push(context,
                        SlideTransitionPageRoute(page: CropsListScreen()));
                    break;
                  case 2:
                    Navigator.push(
                        context,
                        SlideTransitionPageRoute(
                            page: const SalesListScreen()));
                    break;
                  case 3:
                    Navigator.push(
                        context,
                        SlideTransitionPageRoute(
                            page: TransactionListScreen2()));
                    break;
                }
              }),
        ],
      ),
    );
  }
}
