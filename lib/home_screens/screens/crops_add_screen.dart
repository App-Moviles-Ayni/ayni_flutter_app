import 'package:flutter/material.dart';

class CropsAddScreen extends StatefulWidget {
  @override
  _CropsAddScreenState createState() => _CropsAddScreenState();
}

class _CropsAddScreenState extends State<CropsAddScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name, description, separationDistance, plantingDepth, weather, groundType, unitPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Crops')), // Center the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Add your crops'), // Add this line
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Name', border: OutlineInputBorder()), // Add border
                  onSaved: (value) => name = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder()), // Add border
                  onSaved: (value) => description = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Separation Distance', border: OutlineInputBorder()), // Add border
                  onSaved: (value) => separationDistance = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Planting Depth', border: OutlineInputBorder()), // Add border
                  onSaved: (value) => plantingDepth = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Weather', border: OutlineInputBorder()), // Add border
                  onSaved: (value) => weather = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Ground Type', border: OutlineInputBorder()), // Add border
                  onSaved: (value) => groundType = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Unit Price', border: OutlineInputBorder()), // Add border
                  onSaved: (value) => unitPrice = value!,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Aquí puedes manejar la lógica para guardar los datos del formulario
                  }
                },
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green, // foreground
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}