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
  List<Products> _searchResults = [];
  bool _isLoading = true;
  Timer? _timer;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _startShuffleTimer();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _searchController.dispose();
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
      _shuffledProducts = List.of(products);
      _isLoading = false;
    });
  }

  void _shuffleProducts() {
    setState(() {
      _shuffledProducts.shuffle(Random());
    });
  }

  void _onSearchChanged() {
    String searchQuery = _searchController.text.toLowerCase();
    setState(() {
      if (searchQuery.isEmpty) {
        _searchResults.clear();
      } else {
        _searchResults = _products.where((product) {
          return product.name.toLowerCase().contains(searchQuery);
        }).toList();
      }
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
              controller: _searchController,
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
          _searchController.text.isNotEmpty ? _buildSearchResults() : _buildMainContent(),
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

  Widget _buildMainContent() {
    return Expanded(
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
          );
  }

  Widget _buildSearchResults() {
    return Expanded(
      child: ListView.separated(
        itemCount: _searchResults.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.all(8.0),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_searchResults[index].name, style: TextStyle(fontSize: 16)),
                Text(
                  _searchResults[index].description.length > 50
                      ? _searchResults[index].description.substring(0, 50) + '...'
                      : _searchResults[index].description,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            trailing: ClipOval(
              child: Image.network(
                _searchResults[index].imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}