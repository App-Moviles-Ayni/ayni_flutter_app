import 'package:flutter/material.dart';
import 'package:ayni_flutter_app/finance_screens/models/transaction.dart';
import 'package:ayni_flutter_app/finance_screens/screens/transaction_form.dart';
import 'package:ayni_flutter_app/finance_screens/services/transaction_service.dart';

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
      leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      // Aquí puedes añadir la navegación hacia atrás cuando tengas la pantalla de inicio implementada
    },
  ),
      title: const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text('Transactions', textAlign: TextAlign.center),
      SizedBox(height: 8),
      Text('Tap rows show more info!', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
    ],
  ),
  centerTitle: true,
      
    ),
    body: FutureBuilder<List<Transaction>>(
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
                  columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Type')),
                    DataColumn(label: Text('Price')),
                  ],
                  rows: snapshot.data!.map((transaction) {
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
                Text('Date: ${transaction.date}'),
                Text('Description: ${transaction.description}'),
                Text('Type: ${transaction.transactionType}'),
                Text('Price: ${transaction.price}'),
                Text('Quantity: ${transaction.quantity}'),
                Text('User ID: ${transaction.userId}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
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