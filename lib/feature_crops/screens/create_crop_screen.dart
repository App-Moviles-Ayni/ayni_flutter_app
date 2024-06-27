import 'package:flutter/material.dart';
import 'package:ayni_flutter_app/home_screens/models/products.dart';
import 'package:ayni_flutter_app/home_screens/services/crops_service.dart';

class CreateCropScreen extends StatefulWidget {
  const CreateCropScreen({super.key, required this.product});
  final Products product;

  @override
  _CreateCropScreenState createState() => _CreateCropScreenState();
}

class _CreateCropScreenState extends State<CreateCropScreen> {
  final _formKey = GlobalKey<FormState>();
  final CropsService _cropsService = CropsService();

  final _nameController = TextEditingController();
  bool _pickUpWeed = false;
  bool _fertilizeCrop = false;
  bool _oxygenateCrop = false;
  bool _makeCropLine = false;
  bool _makeCropHole = false;
  final _wateringDaysController = TextEditingController();
  final _pestCleanupDaysController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final cropData = {
        "name": _nameController.text,
        "pickUpWeed": _pickUpWeed,
        "fertilizeCrop": _fertilizeCrop,
        "oxygenateCrop": _oxygenateCrop,
        "makeCropLine": _makeCropLine,
        "makeCropHole": _makeCropHole,
        "wateringDays": int.tryParse(_wateringDaysController.text) ?? 0,
        "pestCleanupDays": int.tryParse(_pestCleanupDaysController.text) ?? 0,
        "productId": widget.product.id,
        "userId": widget.product.userId,
      };

      bool success = await _cropsService.createCrop(cropData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(success ? 'Crop created successfully' : 'Failed to create crop')),
      );

      if (success) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Crop Actions',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SwitchListTile(
                  title: const Text('Pick Up Weed'),
                  value: _pickUpWeed,
                  onChanged: (bool value) {
                    setState(() {
                      _pickUpWeed = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Fertilize Crop'),
                  value: _fertilizeCrop,
                  onChanged: (bool value) {
                    setState(() {
                      _fertilizeCrop = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Oxygenate Crop'),
                  value: _oxygenateCrop,
                  onChanged: (bool value) {
                    setState(() {
                      _oxygenateCrop = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Make Crop Line'),
                  value: _makeCropLine,
                  onChanged: (bool value) {
                    setState(() {
                      _makeCropLine = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Make Crop Hole'),
                  value: _makeCropHole,
                  onChanged: (bool value) {
                    setState(() {
                      _makeCropHole = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _wateringDaysController,
                  decoration: const InputDecoration(labelText: 'Watering Days'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of watering days';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _pestCleanupDaysController,
                  decoration: const InputDecoration(labelText: 'Pest Cleanup Days'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of pest cleanup days';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
