import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vehicle_service_app/core/database/database_helper.dart';
import 'package:vehicle_service_app/presentation/screens/auth_screen.dart';
import 'package:vehicle_service_app/presentation/screens/home_screen.dart';
import 'package:vehicle_service_app/presentation/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DatabaseHelper().database; // Ensures DB is initialized
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final box = GetStorage();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isFirstTime = box.read('isFirstTime') ?? true;
    final isRegistered = box.read('user_name') != null;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vehicle Service Booking',
      home: isFirstTime
          ? OnboardingScreen()
          : isRegistered
              ? HomeScreen()
              : AuthScreen(),
    );
  }
}
