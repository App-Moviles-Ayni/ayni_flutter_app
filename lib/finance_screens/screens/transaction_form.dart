import 'package:flutter/material.dart';
import 'package:ayni_flutter_app/finance_screens/models/transaction.dart';
import 'package:ayni_flutter_app/finance_screens/services/transaction_service.dart';

class AddTransactionScreen extends StatefulWidget {
  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TransactionService _transactionService = TransactionService();

  int? _id;
  String? _costName;
  String? _date;
  String? _description;
  String? _transactionType;
  double? _price;
  String? _quantity;
  int? _userId;

  // Lista de opciones para el DropdownMenu
  final List<String> transactionTypes = ['Cost', 'Profits'];
  // Estado para mantener la opción seleccionada
  String? _selectedTransactionType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ID';
                  }
                  try {
                    _id = int.parse(value);
                  } catch (e) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Cost Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter cost name';
                  }
                  _costName = value;
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter date';
                  }
                  _date = value;
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  _description = value;
                  return null;
                },
              ),
              // Cambiar TextFormField por DropdownButtonFormField
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Transaction Type'),
                value: _selectedTransactionType,
                items: transactionTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedTransactionType = value;
                    _transactionType = value; // Guardar la opción seleccionada
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select transaction type';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  try {
                    _price = double.parse(value);
                  } catch (e) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quantity'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter quantity';
                  }
                  _quantity = value;
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'User ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter User ID';
                  }
                  try {
                    _userId = int.parse(value);
                  } catch (e) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final transaction = Transaction(
                      id: _id!,
                      costName: _costName!,
                      date: _date!,
                      description: _description!,
                      transactionType: _transactionType!,
                      price: _price!,
                      quantity: _quantity!,
                      userId: _userId!,
                    );

                    await _transactionService.createTransaction(transaction);
                    Navigator.pop(context, transaction);
                  }
                },
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                ),
                child: const Text('Finish'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
