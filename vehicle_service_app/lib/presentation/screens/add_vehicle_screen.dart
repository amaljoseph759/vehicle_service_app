// add_vehicle_screen.dart
import 'package:flutter/material.dart';

class AddVehicleScreen extends StatelessWidget {
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
      appBar: AppBar(title: Text('Add Vehicle')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: plateController,
                decoration: InputDecoration(labelText: 'Plate Number'),
              ),
              TextFormField(
                controller: vinController,
                decoration: InputDecoration(labelText: 'VIN'),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Brand'),
                value: selectedBrand,
                items: brandModelMap.keys
                    .map((brand) => DropdownMenuItem(
                          value: brand,
                          child: Text(brand),
                        ))
                    .toList(),
                onChanged: (value) {
                  selectedBrand = value;
                  selectedModel = null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Model'),
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
                  selectedModel = value;
                },
              ),
              TextFormField(
                controller: yearController,
                decoration: InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save vehicle logic here (add SQLite later)
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Vehicle added (not yet saved).')),
                    );
                  }
                },
                child: Text('Save Vehicle'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
