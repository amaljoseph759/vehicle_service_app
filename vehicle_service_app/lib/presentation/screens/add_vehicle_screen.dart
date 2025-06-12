// add_vehicle_screen.dart
import 'package:flutter/material.dart';
import 'package:vehicle_service_app/core/database/database_helper.dart';

class AddVehicleScreen extends StatefulWidget {
  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();

  final plateController = TextEditingController();
  final vinController = TextEditingController();
  final yearController = TextEditingController();

  String? selectedBrand;
  String? selectedModel;

  final Map<String, List<String>> brandModelMap = {
    'Toyota': ['Corolla', 'Camry'],
    'Ford': ['Focus', 'Mustang'],
    'Honda': ['Civic', 'Accord'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Vehicle')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: plateController,
                decoration: const InputDecoration(labelText: 'Plate Number'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Plate Number is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: vinController,
                decoration: const InputDecoration(labelText: 'VIN'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'VIN is required';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Brand'),
                value: selectedBrand,
                items: brandModelMap.keys
                    .map((brand) => DropdownMenuItem(
                          value: brand,
                          child: Text(brand),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBrand = value;
                    selectedModel = null;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a brand';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Model'),
                value: selectedModel,
                items: selectedBrand == null
                    ? []
                    : brandModelMap[selectedBrand]!
                        .map((model) => DropdownMenuItem(
                              value: model,
                              child: Text(model),
                            ))
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedModel = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a model';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: yearController,
                decoration: const InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Year is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final db = await DatabaseHelper().database;
                    await db.insert('vehicles', {
                      'plate': plateController.text.trim(),
                      'vin': vinController.text.trim(),
                      'brand': selectedBrand,
                      'model': selectedModel,
                      'year': yearController.text.trim(),
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Vehicle saved successfully.')),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Please fill all required fields')),
                    );
                  }
                },
                child: const Text('Save Vehicle'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
