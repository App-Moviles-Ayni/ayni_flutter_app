import 'package:ayni_flutter_app/home_screens/screens/crops_list_screen.dart';
import 'package:ayni_flutter_app/home_screens/screens/products_list_screen.dart';
import 'package:ayni_flutter_app/screens/sales_list_screen.dart';
import 'package:ayni_flutter_app/shared/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ayni_flutter_app/finance_screens/models/transaction.dart';
import 'package:ayni_flutter_app/finance_screens/screens/transaction_form.dart';
import 'package:ayni_flutter_app/finance_screens/services/transaction_service.dart';
import 'package:ayni_flutter_app/finance_screens/screens/transaction_edit.dart';

class TransactionListScreen2 extends StatefulWidget {
  @override
  _TransactionListScreenState createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen2> {
  final TransactionService _transactionService = TransactionService();
  late Future<List<Transaction>> _transactions;
  List<Item> _data = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _deleteTransaction(int id) async {
  try {
    await _transactionService.deleteTransaction(id);
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Transaction deleted')));
  }
}

  

  

  void _loadTransactions() {
    _transactions = _transactionService.getAll();
    _transactions.then((value) {
      setState(() {
        _data = generateItems(value);
      });
    });
  }

  void _addTransaction(Transaction transaction) {
    _loadTransactions();
  }

  void _updateTransaction(Transaction transaction) {
    _transactionService.updateTransaction(transaction.id, transaction).then((_) {
      _loadTransactions();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update transaction: $error')));
    });
  }

  List<Item> generateItems(List<Transaction> transactions) {
    return List<Item>.generate(transactions.length, (int index) {
      return Item(
        headerValue: 'Transaction ${transactions[index].id}',
        expandedValue: transactions[index],
      );
    });
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
            Text('Tap rows to show more info!', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Opacity(
              opacity: 0.2, // Ajusta la opacidad según sea necesario
              child: Image.asset(
                'assets/images/ayni.png', // Ruta de tu imagen
                fit: BoxFit.cover,
              ),
            ),
          ),
          FutureBuilder<List<Transaction>>(
            future: _transactions,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No transactions found'));
              } else {
                return Column(
                  children: [
                    SizedBox(height: 16), // Añade espacio encima de la tabla
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: WidgetStateColor.resolveWith((states) => Colors.green),
                        columns: const [
                          DataColumn(label: Text('Name', style: TextStyle(color: Colors.white))),
                          DataColumn(label: Text('Date', style: TextStyle(color: Colors.white))),
                          DataColumn(label: Text('Type', style: TextStyle(color: Colors.white))),
                          DataColumn(label: Text('Price', style: TextStyle(color: Colors.white))),
                        ],
                        rows: snapshot.data!.map((transaction) {
                          return DataRow(
                            cells: [
                              DataCell(Text(transaction.costName), onTap: () {
                                _showTransactionDetails(context, transaction);
                              }),
                              DataCell(Text(transaction.description), onTap: () {
                                _showTransactionDetails(context, transaction);
                              }),
                              DataCell(Text(transaction.transactionType), onTap: () {
                                _showTransactionDetails(context, transaction);
                              }),
                              DataCell(Text(transaction.price.toString()), onTap: () {
                                _showTransactionDetails(context, transaction);
                              }),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.9, // Ajusta el ancho del botón
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
          label: Text('Add Transaction'), // Cambia el icono por un texto
          icon: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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

  

  

  void _showTransactionDetails(BuildContext context, Transaction transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Transaction Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('ID: ${transaction.id}'),
                Text('Cost Name: ${transaction.costName}'),
                Text('Description: ${transaction.date}'),
                Text('Date: ${transaction.description}'),
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
    _loadTransactions();
  },
  child: const Text('Delete', style: TextStyle(color: Colors.red)),
), 
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final updatedTransaction = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditTransactionScreen(transaction: transaction)),
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

