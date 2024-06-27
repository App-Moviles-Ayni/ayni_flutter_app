import 'package:flutter/material.dart';
import 'package:ayni_flutter_app/finance_screens/models/transaction.dart';


class EditTransactionScreen extends StatefulWidget {
  final Transaction transaction;

  EditTransactionScreen({required this.transaction});

  @override
  _EditTransactionScreenState createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _costNameController;
  late TextEditingController _dateController;
  late TextEditingController _descriptionController;
  late TextEditingController _transactionTypeController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _costNameController = TextEditingController(text: widget.transaction.costName);
    _dateController = TextEditingController(text: widget.transaction.date);
    _descriptionController = TextEditingController(text: widget.transaction.description);
    _transactionTypeController = TextEditingController(text: widget.transaction.transactionType);
    _priceController = TextEditingController(text: widget.transaction.price.toString());
    _quantityController = TextEditingController(text: widget.transaction.quantity);
  }

  @override
  void dispose() {
    _costNameController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    _transactionTypeController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Transaction'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _costNameController,
                decoration: InputDecoration(labelText: 'Cost Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a cost name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _transactionTypeController,
                decoration: InputDecoration(labelText: 'Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a transaction type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quantity';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedTransaction = Transaction(
                      id: widget.transaction.id,
                      costName: _costNameController.text,
                      date: _dateController.text,
                      description: _descriptionController.text,
                      transactionType: _transactionTypeController.text,
                      price: double.parse(_priceController.text),
                      quantity: _quantityController.text,
                      userId: widget.transaction.userId,
                    );
                    Navigator.of(context).pop(updatedTransaction);
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