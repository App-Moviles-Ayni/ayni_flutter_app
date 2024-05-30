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
        title: Center(child: Text('Crops')), // Centrar el título
        actions: <Widget>[
          TextButton(
            child: Text('Filter'), // Reemplazar el ícono de filtro con la palabra 'Filter'
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
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(_products[index].imageUrl), // Asegúrate de tener una URL válida para la imagen
                  title: Text(_products[index].name),
                  //subtitle: Text('\$${_products[index].price} per kg'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Implementar la funcionalidad de navegación a la página de detalles del producto
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
