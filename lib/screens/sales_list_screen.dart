import 'package:ayni_flutter_app/models/orders.dart';
import 'package:ayni_flutter_app/screens/create_order_form_screen.dart';
import 'package:ayni_flutter_app/services/orders_service.dart';
import 'package:ayni_flutter_app/widgets/confirmation_dialog.dart';
import 'package:ayni_flutter_app/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';

class SalesListScreen extends StatefulWidget {
  const SalesListScreen({super.key});

  @override
  State<SalesListScreen> createState() => _SalesListScreenState();
}

class _SalesListScreenState extends State<SalesListScreen> {

  String query = "";
  bool result = false;

  void onQueryChanged(String value) {
    setState(() {
      query = value;
    });
  }
  void reloadPage() {
    setState(() {
      result = !result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('My Orders', textAlign: TextAlign.center),
            SizedBox(height: 8),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CustomSearchBar(callback: (value) {
            onQueryChanged(value);
          }),
          Expanded(child: SalesList(query: query, shouldFetchData: result, reloadPage: reloadPage))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateOrderFormScreen()));
          if (result == true) {
            reloadPage();
          }
        },
        tooltip: 'Add Order',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SalesList extends StatefulWidget {
  const SalesList(
      {super.key, required this.query, required this.shouldFetchData, required this.reloadPage});
  final String query;
  final bool shouldFetchData;
  final VoidCallback reloadPage;

  @override
  State<SalesList> createState() => _SalesListState();
}

class _SalesListState extends State<SalesList> {
  List _orders = [];
  final OrdersService _ordersService = OrdersService();

  void onDelete(int? id) async {
    await _ordersService.delete(id);
    widget.reloadPage();
  }
  void fetchData() async {
    _orders = await _ordersService.getAll();
    setState(() {
      _orders = _orders;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: _ordersService.getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong..."),
            );
          } else {
            _orders = snapshot.data ?? [];
            return ListView.builder(
                itemCount: _orders.length,
                itemBuilder: (context, index) {
                  return SalesItem(order: _orders[index], onDelete: onDelete);
                });
          }
        });
  }
}

class SalesItem extends StatefulWidget {
  const SalesItem({super.key, required this.order, required this.onDelete});
  final Orders order;
  final Function(int?) onDelete;

  @override
  State<SalesItem> createState() => _SalesItemState();
}

class _SalesItemState extends State<SalesItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 14.0),
      padding: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: SizedBox(
          width: 60,
          child: Image.network(widget.order.imageUrl.toString(),
              fit: BoxFit.cover),
        ),
        title: Text(
          widget.order.description.toString(),
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text("Price: \$${widget.order.totalPrice.toString()} - Status: ${widget.order.status}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.check, color: Colors.green),
            ),
            IconButton(
              onPressed: () {
                ConfirmationDialog.showConfirmationDialog(
                  context, 
                  onConfirm: () => widget.onDelete(widget.order.id));
              },
              icon: const Icon(Icons.close, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
