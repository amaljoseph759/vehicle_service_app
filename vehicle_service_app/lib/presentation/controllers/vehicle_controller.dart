// vehicle_controller.dart
import 'package:get/get.dart';
import 'package:vehicle_service_app/core/database/database_helper.dart';

class VehicleController extends GetxController {
  var vehicles = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    loadVehicles();
    super.onInit();
  }

  Future<void> loadVehicles() async {
    final db = await DatabaseHelper().database;
    final data = await db.query('vehicles');
    vehicles.value = data;
  }

  Future<void> deleteVehicle(int id) async {
    final db = await DatabaseHelper().database;
    await db.delete('vehicles', where: 'id = ?', whereArgs: [id]);
    await loadVehicles();
    Get.snackbar('Deleted', 'Vehicle has been removed');
  }
}
