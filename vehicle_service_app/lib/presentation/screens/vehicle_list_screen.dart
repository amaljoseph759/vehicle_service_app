// vehicle_list_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_service_app/core/database/database_helper.dart';
import 'add_vehicle_screen.dart';

class VehicleListScreen extends StatefulWidget {
  @override
  _VehicleListScreenState createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  List<Map<String, dynamic>> vehicles = [];

  Future<void> _loadVehicles() async {
    final db = await DatabaseHelper().database;
    final data = await db.query('vehicles');
    setState(() => vehicles = data);
  }

  Future<void> _deleteVehicle(int id) async {
    final db = await DatabaseHelper().database;
    await db.delete('vehicles', where: 'id = ?', whereArgs: [id]);
    await _loadVehicles();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Vehicle deleted')),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Vehicles')),
      body: vehicles.isEmpty
          ? Center(child: Text('No vehicles found.'))
          : ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (_, index) {
                final v = vehicles[index];
                return ListTile(
                  leading: Icon(Icons.directions_car),
                  title: Text('${v['brand']} ${v['model']}'),
                  subtitle: Text('Plate: ${v['plate']} | Year: ${v['year']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.grey),
                    onPressed: () => _confirmDelete(v['id']),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Get.to(() => AddVehicleScreen())!.then((_) => _loadVehicles()),
        child: Icon(Icons.add),
      ),
    );
  }

  void _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Delete Vehicle'),
        content: Text('Are you sure you want to delete this vehicle?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteVehicle(id);
            },
            child: Text('Delete ', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
