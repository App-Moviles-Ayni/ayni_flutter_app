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
              // Acción del botón de filtro
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          _products[index].imageUrl,
                          width: 150, // Ajusta el ancho de la imagen
                          height: 150, // Ajusta la altura de la imagen
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 9.0), // Espacio entre la imagen y el texto
                      Text(
                        _products[index].name,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ), // Nombre del producto debajo de la imagen
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alinea el texto a la izquierda
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
                      crossAxisCount: 3, // Número de elementos en el eje transversal (horizontal)
                      crossAxisSpacing: 10, // Espacio entre elementos en el eje transversal
                      mainAxisSpacing: 10, // Espacio entre elementos en el eje principal (vertical)
                      childAspectRatio: 0.6, // Ajusta este valor según la relación de aspecto deseada
                    ),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0), // Opcional: Añade bordes redondeados
                            child: Image.network(
                              _products[index].imageUrl,
                              width: double.infinity,
                              height: 150, // Ajusta la altura de la imagen
                              fit: BoxFit.cover, // Ajusta la imagen para cubrir todo el espacio
                            ),
                          ),
                          SizedBox(height: 9.0), // Espacio entre la imagen y el texto
                          Text(_products[index].name, style: TextStyle(fontSize: 16)), // Nombre del producto
                          //Text('${_products[index].weight}kg \$${_products[index].price} per kg'), // Peso y precio del producto
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
    );
  }
}
