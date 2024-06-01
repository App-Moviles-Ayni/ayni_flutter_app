import 'package:ayni_flutter_app/feature_crops/screens/create_crop_screen.dart';
import 'package:ayni_flutter_app/finance_screens/screens/transaction_panels.dart';
import 'package:ayni_flutter_app/home_screens/models/products.dart';
import 'package:ayni_flutter_app/home_screens/screens/crops_list_screen.dart';
import 'package:ayni_flutter_app/home_screens/screens/products_list_screen.dart';
import 'package:ayni_flutter_app/screens/sales_list_screen.dart';
import 'package:ayni_flutter_app/shared/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class CropDetailsScreen extends StatelessWidget {
  const CropDetailsScreen({super.key, required this.product});
  final Products product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(product.name)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                "Plant Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DetailRow(label: "Distance", value: product.recommendedCultivationDistance),
              DetailRow(label: "Depth", value: product.recommendedCultivationDepth),
              DetailRow(label: "Weather", value: product.recommendedGrowingClimate),
              DetailRow(label: "Soil", value: product.recommendedSoilType),
              DetailRow(label: "Season", value: product.recommendedGrowingSeason),
              const SizedBox(height: 16),

              const Divider(thickness: 1),

              const SizedBox(height: 16),
              const Text(
                "Plant Description",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                product.description,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => CreateCropScreen(product: product),
            ));
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
            case 2:
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => SalesListScreen()));
              break;
            case 3:
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => TransactionListScreen2()));
              break;
          }
        }),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
