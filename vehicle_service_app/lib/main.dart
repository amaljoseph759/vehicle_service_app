// 🚀 Flutter Clean Architecture + GetX + SQLite Starter for Vehicle Service Booking App

// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vehicle_service_app/presentation/screens/auth_screen.dart';
import 'package:vehicle_service_app/presentation/screens/onboarding_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final isFirstTime = box.read('isFirstTime') ?? true;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vehicle Service Booking',
      home: isFirstTime ? OnboardingScreen() : AuthScreen(),
    );
  }
}
