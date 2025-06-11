// home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_service_app/presentation/screens/book_service.dart';
import 'package:vehicle_service_app/presentation/screens/service_history.dart';
import 'package:vehicle_service_app/presentation/screens/vehicle_list_screen.dart';
import 'package:vehicle_service_app/presentation/widgets/home_container.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            BuildTile(
                icon: Icons.directions_car,
                title: 'My Vehicles',
                onTap: () {
                  Get.to(() => VehicleListScreen());
                }),
            BuildTile(
                icon: Icons.build,
                title: 'Book Service',
                onTap: () {
                  Get.to(() => BookServiceScreen());
                }),
            BuildTile(
                icon: Icons.history,
                title: 'Service History',
                onTap: () {
                  Get.to(() => ServiceHistoryScreen());
                }),
          ],
        ),
      ),
    );
  }
}
