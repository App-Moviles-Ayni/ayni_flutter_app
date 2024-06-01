import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ayni_flutter_app/home_screens/models/products.dart';
import 'package:ayni_flutter_app/home_screens/screens/crops_add_screen.dart';
import 'package:ayni_flutter_app/home_screens/services/products_service.dart';

class CropsListScreen extends StatefulWidget {
  @override
  _CropsListScreenState createState() => _CropsListScreenState();
}

class _CropsListScreenState extends State<CropsListScreen> {
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
    _timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      _shuffleProducts();
    });
  }

  Future<void> _fetchProducts() async {
    List<Products> products = await _productsService.getAll();
    setState(() {
      _products = products;
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
        title: Center(child: Text('Crops')),
        actions: <Widget>[
          TextButton(
            child: Text('Filter'),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Hot Deals', style: TextStyle(fontSize: 24)),
            ),
          ),
          Container(
            height: 200,
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _shuffledProducts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                _shuffledProducts[index].imageUrl,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 9.0),
                            Text(
                              _shuffledProducts[index].name,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('All my products', style: TextStyle(fontSize: 24)),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: _products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              _products[index].imageUrl,
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 9.0),
                          Text(_products[index].name,
                              style: TextStyle(fontSize: 16)),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CropsAddScreen()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.green,
      ),
    );
  }
}

