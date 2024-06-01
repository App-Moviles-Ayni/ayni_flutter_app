import 'package:ayni_flutter_app/home_screens/models/products.dart';
import 'package:ayni_flutter_app/home_screens/services/products_service.dart';
import 'package:flutter/material.dart';

class CropsListScreen extends StatefulWidget {
  @override
  _CropsListScreenState createState() => _CropsListScreenState();
}

class _CropsListScreenState extends State<CropsListScreen> {
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
      title: Center(child: Text('Crops')),
      actions: <Widget>[
        TextButton(
          child: Text('Filter'),
          onPressed: () {
            // Implementar la funcionalidad de filtro
          },
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
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Número de columnas
              childAspectRatio: 3 / 2, // Relación de aspecto de los elementos de la cuadrícula
            ),
            itemCount: _products.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 18 / 11,
                      child: Image.network(_products[index].imageUrl, fit: BoxFit.fitWidth),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_products[index].name),
                          SizedBox(height: 8.0),
                          //Text('\$${_products[index].price} per kg'),
                        ],
                      ),
                    ),
                  ],
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