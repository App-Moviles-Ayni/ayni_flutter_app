import 'package:ayni_flutter_app/feature_orders/models/sales.dart';
import 'package:ayni_flutter_app/feature_orders/services/sales_service.dart';
import 'package:ayni_flutter_app/finance_screens/screens/transaction_panels.dart';
import 'package:ayni_flutter_app/home_screens/screens/crops_list_screen.dart';
import 'package:ayni_flutter_app/home_screens/screens/products_list_screen.dart';
import 'package:ayni_flutter_app/feature_orders/models/orders.dart';
import 'package:ayni_flutter_app/feature_orders/screens/create_order_form_screen.dart';
import 'package:ayni_flutter_app/feature_orders/services/orders_service.dart';
import 'package:ayni_flutter_app/shared/widgets/bottom_navigation_bar.dart';
import 'package:ayni_flutter_app/feature_orders/widgets/confirmation_dialog.dart';
import 'package:ayni_flutter_app/feature_orders/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalesListScreen extends StatefulWidget {
  const SalesListScreen({super.key});

  @override
  State<SalesListScreen> createState() => _SalesListScreenState();
}

class _SalesListScreenState extends State<SalesListScreen> {
  final OrdersService _ordersService = OrdersService();

  List _orders = [];
  bool result = false;

  void onQuery(String query) async {
    _orders = await _ordersService.getByDescription(query);
    setState(() {
      _orders = _orders;
    });
  }

  void onDelete(int? id) async {
    await _ordersService.delete(id);
    reloadPage();
  }

  void onFinalize(int? id) async {
    await _ordersService.finalizeOrder(id);
    reloadPage();
  }

  void fetchData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getInt('userId');

    _orders = await _ordersService.getAll();
    List filteredOrders = _orders.where(
      (order) => order.acceptedBy == userId && order.status == 'pending').toList();
    setState(() {
      _orders = filteredOrders;
    });
  }

  void reloadPage() {
    setState(() {
      result = !result;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            onQuery(value);
          }),
          Expanded(
              child: SalesList(
                  orders: _orders,
                  reloadPage: reloadPage,
                  ordersService: _ordersService,
                  onDelete: onDelete,
                  onFinalize: onFinalize,))
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
        backgroundColor: Colors.green,
        tooltip: 'Add Order',
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavBar(
          currentIndex: 2,
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.push(context,
                    SlideTransitionPageRoute(page: ProductsListScreen()));
                break;
              case 1:
                Navigator.push(
                    context, SlideTransitionPageRoute(page: CropsListScreen()));
                break;
              case 2:
                Navigator.push(context,
                    SlideTransitionPageRoute(page: const SalesListScreen()));
                break;
              case 3:
                Navigator.push(context,
                    SlideTransitionPageRoute(page: TransactionListScreen2()));
                break;
            }
          }),
    );
  }
}

class SalesList extends StatefulWidget {
  const SalesList(
      {super.key,
      required this.orders,
      required this.reloadPage,
      required this.ordersService,
      required this.onDelete,
      required this.onFinalize});
  final List orders;
  final VoidCallback reloadPage;
  final OrdersService ordersService;
  final Function(int? id) onDelete;
  final Function(int? id) onFinalize;

  @override
  State<SalesList> createState() => _SalesListState();
}

class _SalesListState extends State<SalesList> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: widget.ordersService.getAll(),
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
            return ListView.builder(
                itemCount: widget.orders.length,
                itemBuilder: (context, index) {
                  return SalesItem(
                      order: widget.orders[index],
                      onDelete: widget.onDelete,
                      onFinalize: widget.onFinalize);
                });
          }
        });
  }
}

class SalesItem extends StatefulWidget {
  const SalesItem(
      {super.key,
      required this.order,
      required this.onDelete,
      required this.onFinalize});
  final Orders order;
  final Function(int?) onDelete;
  final Function(int?) onFinalize;

  @override
  State<SalesItem> createState() => _SalesItemState();
}

class _SalesItemState extends State<SalesItem> {
  final SalesService _salesService = SalesService();
  Sales? _sale;

  void fetchSale() async {
    try {
      if (widget.order.saleId != null) {
        _sale = await _salesService.getSaleById(widget.order.saleId.toString());
        setState(() {
          _sale = _sale;
        });
      }
    } catch (e) {
    }
  }

  @override
  void initState() {
    fetchSale();
    super.initState();
  }

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
          child: _sale != null && _sale!.imageUrl != null
              ? Image.network(
                  _sale!.imageUrl.toString(),
                  fit: BoxFit.cover,
                )
              : const Placeholder(),
        ),
        title: Text(
          '${_sale?.name}',
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
            "Price: \$${widget.order.totalPrice.toString()} - Status: ${widget.order.status}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                widget.onFinalize(widget.order.id);
              },
              icon: const Icon(Icons.check, color: Colors.green),
            ),
            IconButton(
              onPressed: () {
                ConfirmationDialog.showConfirmationDialog(context,
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
