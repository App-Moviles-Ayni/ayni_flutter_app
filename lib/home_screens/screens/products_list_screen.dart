import 'package:ayni_flutter_app/home_screens/screens/crops_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:ayni_flutter_app/home_screens/services/products_service.dart';
import 'package:ayni_flutter_app/home_screens/models/products.dart';

class ProductsListScreen extends StatefulWidget {
  @override
  _ProductsListScreenState createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  final ProductsService _productsService = ProductsService();
  List<Products> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    List<Products> products = await _productsService.getAll();
    setState(() {
      _products = products;
      _isLoading = false;
    });
  }

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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Latest Crops', style: TextStyle(fontSize: 24), textAlign: TextAlign.left),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CropsListScreen()),
                          );
                        },
                        child: Text('See All ->', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                    
                  ),
                ),
                Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(_products[index].imageUrl, width: 100, height: 150, fit: BoxFit.cover),
                            ),
                            Positioned(
                              top: 8.0,
                              left: 8.0,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                child: Text(
                                  _products[index].name,
                                  style: TextStyle(
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
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text('Products On Sale', style: TextStyle(fontSize: 24), textAlign: TextAlign.left),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: _products.length,
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_products[index].name, style: TextStyle(fontSize: 16)),
                            Text(
                              _products[index].description.length > 50
                                  ? _products[index].description.substring(0, 50) + '...'
                                  : _products[index].description,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        trailing: ClipOval(
                          child: Image.network(_products[index].imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
