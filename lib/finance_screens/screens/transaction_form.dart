import 'package:flutter/material.dart';
import 'package:ayni_flutter_app/finance_screens/models/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _costName;
  String? _description;
  String? _date;
  String? _transactionType;
  double? _price;
  String? _quantity;
  int? _userId;

  final List<String> transactionTypes = ['Cost', 'Profits'];
  String? _selectedTransactionType;

  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _userId = sharedPreferences.getInt('userId');
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _date = DateFormat('yyyy-MM-dd').format(picked);
        _dateController.text = _date!;
      });
    }
  }

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Add Transaction'),  
        backgroundColor: Colors.green,  
        foregroundColor: Colors.white,  
        centerTitle: true,  
      ),  
      body: Container(  
        decoration: BoxDecoration(  
          color: Colors.grey[100],  
        ),  
        child: Padding(  
          padding: const EdgeInsets.all(24.0),  
          child: Card(  
            elevation: 8.0,  
            child: Padding(  
              padding: const EdgeInsets.all(16.0),  
              child: Form(  
                key: _formKey,  
                child: ListView(  
                  children: [  
                    _buildTextField(  
                      labelText: 'Transaction Name',  
                      validator: (value) {  
                        if (value == null || value.isEmpty) {  
                          return 'Please enter cost name';  
                        }  
                        _costName = value;  
                        return null;  
                      },  
                    ),  
                    const SizedBox(height: 16.0),  
                    _buildTextField(  
                      labelText: 'Description',  
                      validator: (value) {  
                        if (value == null || value.isEmpty) {  
                          return 'Please enter description';  
                        }  
                        _description = value;  
                        return null;  
                      },  
                    ),  
                    const SizedBox(height: 16.0),  
                    TextFormField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 2.0,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter date';
                        }
                        _date = value;
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),  
                    DropdownButtonFormField(  
                      decoration: const InputDecoration(labelText: 'Transaction Type'),  
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
                          _transactionType = value;  
                        });  
                      },  
                      validator: (value) {  
                        if (value == null || value.isEmpty) {  
                          return 'Please select transaction type';  
                        }  
                        return null;  
                      },  
                    ),  
                    const SizedBox(height: 16.0),  
                    _buildTextField(  
                      labelText: 'Price',  
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
                    const SizedBox(height: 16.0),  
                    _buildTextField(  
                      labelText: 'Quantity',  
                      validator: (value) {  
                        if (value == null || value.isEmpty) {  
                          return 'Please enter quantity';  
                        }  
                        _quantity = value;  
                        return null;  
                      },  
                    ),  
                    const SizedBox(height: 24.0),  
                    ElevatedButton(  
                      onPressed: () async {  
                        if (_formKey.currentState!.validate()) {  
                          final transaction = Transaction(  
                            id: 0,  
                            costName: _costName!,  
                            description: _description!,  
                            date: _date!,  
                            transactionType: _transactionType!,  
                            price: _price!,  
                            quantity: _quantity!,  
                            userId: _userId!,  
                          );  
                          //await _transactionService.createTransaction(transaction);  
                          Navigator.pop(context, transaction);  
                        }  
                      },  
                      style: ButtonStyle(  
                        backgroundColor: MaterialStateProperty.all(Colors.green),  
                        foregroundColor: MaterialStateProperty.all(Colors.white),  
                        elevation: MaterialStateProperty.all(4.0),  
                        shape: MaterialStateProperty.all(  
                          RoundedRectangleBorder(  
                            borderRadius: BorderRadius.circular(10.0),  
                          ),  
                        ),  
                      ),  
                      child: const Text('Finish'),  
                    ),  
                  ],  
                ),  
              ),  
            ),  
          ),  
        ),  
      ),  
    );  
  }  
  
  Widget _buildTextField({  
    required String labelText,  
    required String? Function(String?)? validator,  
    TextInputType? keyboardType,  
  }) {  
    return TextFormField(  
      decoration: InputDecoration(  
        labelText: labelText,  
        border: OutlineInputBorder(  
          borderRadius: BorderRadius.circular(10.0),  
        ),  
        focusedBorder: OutlineInputBorder(  
          borderRadius: BorderRadius.circular(10.0),  
          borderSide: const BorderSide(  
            color: Colors.green,  
            width: 2.0,  
          ),  
        ),  
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),  
      ),  
      validator: validator,  
      keyboardType: keyboardType,  
    );  
  }  
}  
