import 'package:flutter/material.dart';
import 'package:ayni_flutter_app/home_screens/screens/crops_list_screen.dart';
import 'package:ayni_flutter_app/home_screens/screens/products_list_screen.dart';
import 'package:ayni_flutter_app/feature_orders/screens/sales_list_screen.dart';
import 'package:ayni_flutter_app/shared/widgets/bottom_navigation_bar.dart';
import 'package:ayni_flutter_app/finance_screens/models/transaction.dart';
import 'package:ayni_flutter_app/finance_screens/services/transaction_service.dart';
import 'package:ayni_flutter_app/finance_screens/screens/transaction_form.dart';
import 'package:ayni_flutter_app/finance_screens/screens/transaction_edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionListScreen2 extends StatefulWidget {
  const TransactionListScreen2({super.key});

  @override
  _TransactionListScreenState createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen2> {
  final TransactionService _transactionService = TransactionService();
  late List _transactions = [];
  List _data = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _deleteTransaction(int id) async {
    try {
      await _transactionService.deleteTransaction(id);
      _loadTransactions();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to delete transaction')));
    }
  }

  void _loadTransactions() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getInt('userId');

    List allTransactions = await _transactionService.getAll();
    List filteredTransactions =
        allTransactions.where((transaction) => transaction.userId == userId).toList();
    
    setState(() {
      _transactions = filteredTransactions;
      _data = filteredTransactions;
    });
  }

  void _addTransaction(Transaction transaction) async {
    await _transactionService.createTransaction(transaction);
    _loadTransactions();
  }

  void _updateTransaction(Transaction transaction) async {
    await _transactionService.updateTransaction(transaction.id, transaction);
    _loadTransactions(); // Actualizar la lista después de actualizar
  }

  List<Item> generateItems(List<Transaction> transactions) {
    return transactions.map((transaction) {
      return Item(
        headerValue: 'Transaction ${transaction.id}',
        expandedValue: transaction,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Transactions', textAlign: TextAlign.center),
            SizedBox(height: 8),
            Text('Tap rows to show more info!',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/images/ayni.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor:
                  MaterialStateColor.resolveWith((states) => Colors.green),
              columns: const [
                DataColumn(
                    label: Text('Name', style: TextStyle(color: Colors.white))),
                DataColumn(
                    label: Text('Date', style: TextStyle(color: Colors.white))),
                DataColumn(
                    label: Text('Type', style: TextStyle(color: Colors.white))),
                DataColumn(
                    label: Text('Price', style: TextStyle(color: Colors.white))),
              ],
              rows: _transactions.map((transaction) {
                return DataRow(
                  cells: [
                    DataCell(Text(transaction.costName), onTap: () {
                      _showTransactionDetails(context, transaction);
                    }),
                    DataCell(Text(transaction.date), onTap: () {
                      _showTransactionDetails(context, transaction);
                    }),
                    DataCell(Text(transaction.transactionType), onTap: () {
                      _showTransactionDetails(context, transaction);
                    }),
                    DataCell(
                        Text(transaction.price.toString()), onTap: () {
                      _showTransactionDetails(context, transaction);
                    }),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final newTransaction = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTransactionScreen()),
            );
            if (newTransaction != null) {
              _addTransaction(newTransaction);
            }
          },
          label: const Text('Add Transaction'),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                  context, SlideTransitionPageRoute(page: ProductsListScreen()));
              break;
            case 1:
              Navigator.push(
                  context, SlideTransitionPageRoute(page: CropsListScreen()));
              break;
            case 2:
              Navigator.push(
                  context, SlideTransitionPageRoute(page: const SalesListScreen()));
              break;
            case 3:
              Navigator.push(
                  context, SlideTransitionPageRoute(page: TransactionListScreen2()));
              break;
          }
        },
      ),
    );
  }

  void _showTransactionDetails(BuildContext context, Transaction transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Transaction Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('ID: ${transaction.id}'),
                Text('Cost Name: ${transaction.costName}'),
                Text('Description: ${transaction.description}'),
                Text('Date: ${transaction.date}'),
                Text('Type: ${transaction.transactionType}'),
                Text('Price: ${transaction.price}'),
                Text('Quantity: ${transaction.quantity}'),
                Text('User ID: ${transaction.userId}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteTransaction(transaction.id);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final updatedTransaction = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditTransactionScreen(transaction: transaction)),
                );
                if (updatedTransaction != null) {
                  _updateTransaction(updatedTransaction);
                }
              },
              child: const Text('Edit', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  Transaction expandedValue;
  String headerValue;
  bool isExpanded;
}
