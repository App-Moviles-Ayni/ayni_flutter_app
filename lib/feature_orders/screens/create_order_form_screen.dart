import 'package:ayni_flutter_app/feature_orders/models/sales.dart';
import 'package:ayni_flutter_app/feature_orders/services/sales_service.dart';
import 'package:ayni_flutter_app/feature_orders/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CreateOrderFormScreen extends StatefulWidget {
  const CreateOrderFormScreen({super.key});

  @override
  State<CreateOrderFormScreen> createState() => _CreateOrderFormScreenState();
}

class _CreateOrderFormScreenState extends State<CreateOrderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final SalesService _salesService = SalesService();
  //final OrdersService _ordersService = OrdersService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  final int _userId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('My Orders', textAlign: TextAlign.center),
            SizedBox(height: 8),
          ],
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(children: [
              CustomTextFormField(
                controller: _nameController,
                labelText: 'Name',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomTextFormField(
                controller: _descriptionController,
                labelText: 'Description',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product description';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomTextFormField(
                controller: _unitPriceController,
                labelText: 'Unit Price',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the unit price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomTextFormField(
                controller: _quantityController,
                labelText: 'Quantity',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the unit price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomTextFormField(
                controller: _imageUrlController,
                labelText: 'Image Link',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the image link';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final unitPrice =
                              double.parse(_unitPriceController.text);
                          final quantity = int.parse(_quantityController.text);
                          final newSale = Sales(
                              name: _nameController.text,
                              description: _descriptionController.text,
                              unitPrice: unitPrice,
                              quantity: quantity,
                              imageUrl: _imageUrlController.text,
                              userId: _userId);
                          await _salesService.post(newSale);
                          /*
                    if (saleResponse.id != null) {
                      final newOrder = Orders(
                          description: _descriptionController.text,
                          totalPrice: unitPrice * quantity,
                          quantity: quantity,
                          imageUrl: _imageUrlController.text,
                          saleId: saleResponse.id,
                          orderedBy: _userId,
                          acceptedBy: _userId,
                          orderedDate: DateTime.now().millisecondsSinceEpoch,
                          status: "Pending");

                      await _ordersService.post(newOrder);
                    }
                    */
                          Navigator.pop(context, true);
                        }
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.black),
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.green),
                      ),
                      child: const Text('Finish'),
                    ),
                  )
                ],
              )
            ]),
          )),
    );
  }
}
