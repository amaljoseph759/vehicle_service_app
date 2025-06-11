// vehicle_list_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_service_app/presentation/controllers/vehicle_controller.dart';
import 'add_vehicle_screen.dart';

class VehicleListScreen extends StatelessWidget {
  final VehicleController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Vehicles')),
      body: Obx(() {
        if (controller.vehicles.isEmpty) {
          return const Center(child: Text('No vehicles found.'));
        }
        return ListView.builder(
          itemCount: controller.vehicles.length,
          itemBuilder: (_, index) {
            final vehicle = controller.vehicles[index];
            return ListTile(
              leading: const Icon(Icons.directions_car),
              title: Text('${vehicle['brand']} ${vehicle['model']}'),
              subtitle:
                  Text('Plate: ${vehicle['plate']} | Year: ${vehicle['year']}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _confirmDelete(context, vehicle['id']),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddVehicleScreen())!
            .then((_) => controller.loadVehicles()),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _confirmDelete(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Vehicle'),
        content: const Text('Are you sure you want to delete this vehicle?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              controller.deleteVehicle(id);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
