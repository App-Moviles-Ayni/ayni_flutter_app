import 'dart:async';
import 'dart:math';
import 'package:ayni_flutter_app/feature_crops/screens/crop_details_screen.dart';
import 'package:ayni_flutter_app/finance_screens/screens/transaction_panels.dart';
import 'package:ayni_flutter_app/home_screens/screens/products_list_screen.dart';
import 'package:ayni_flutter_app/feature_orders/screens/sales_list_screen.dart';
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
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
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

  void _onQuery(String query) async {
    setState(() {
      _isLoading = true;
    });
    List<Products> products = await _productsService.getByName(query);
    setState(() {
      _products = products;
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
        title: const Center(child: Text('Crops')),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,  
              onSubmitted: _onQuery,
              decoration: const InputDecoration(
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
          Align(
          /*const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Hot Deals', style: TextStyle(fontSize: 24)),
            ),
          ),
          SizedBox(
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
          ),*/
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
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 1.0, // Altura de la línea negra
            color: Colors.white, // Color de la línea negra
          ),
BottomNavBar(currentIndex: 1, 
        onTap: (index){
          switch(index){
            case 0:
              Navigator.push(context, SlideTransitionPageRoute(page: ProductsListScreen()));
              break;
            case 1:
              Navigator.push(context, SlideTransitionPageRoute(page: CropsListScreen()));
              break;
            case 2:
              Navigator.push(context, SlideTransitionPageRoute(page: const SalesListScreen()));
              break;
            case 3:
              Navigator.push(context, SlideTransitionPageRoute(page: TransactionListScreen2()));
              break;
          }
        }),
        ]
      )
      
    );
  }
}