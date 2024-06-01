import 'dart:async';
import 'dart:math';
import 'package:ayni_flutter_app/feature_crops/screens/crop_details_screen.dart';
import 'package:ayni_flutter_app/home_screens/screens/products_list_screen.dart';
import 'package:ayni_flutter_app/shared/widgets/bottom_navigation_bar.dart';
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
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
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
        title: const Center(child: Text('Crops')),
        actions: <Widget>[
          TextButton(
            child: const Text('Filter'),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
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
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Hot Deals', style: TextStyle(fontSize: 24)),
            ),
          ),
          Container(
            height: 200,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _shuffledProducts.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CropDetailsScreen(product: _shuffledProducts[index]),
                            ),
                          );
                        },
                        child: Padding(
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
                              const SizedBox(height: 9.0),
                              Text(
                                _shuffledProducts[index].name,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('All my products', style: TextStyle(fontSize: 24)),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: _products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                        builder: (context) => CropDetailsScreen(product: _products[index]),
                      ),
                    );
                        },
                        child: Column(
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
                            const SizedBox(height: 9.0),
                            Text(_products[index].name,
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
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
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0, 
        onTap: (index){
          switch(index){
            case 0:
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => ProductsListScreen()));
              break;
            case 1:
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => CropsListScreen()));
              break;
            /*case 2:
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => OrdersScreen())
              break;*/
              /*case 3:
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => TransactionsScreen()));
              break;*/
          }
        }),
    );
  }
}

