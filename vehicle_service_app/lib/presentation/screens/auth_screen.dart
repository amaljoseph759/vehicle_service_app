// auth_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vehicle_service_app/presentation/screens/home_screen.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final box = GetStorage();

  void _submit() {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    if (name.isNotEmpty && phone.isNotEmpty) {
      box.write('user_name', name);
      box.write('user_phone', phone);
      Get.snackbar('Success', 'User data saved locally');
      Get.offAll(() => HomeScreen());
    } else {
      Get.snackbar('Error', 'Please enter all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Register',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              onChanged: (value) {
                if (phoneController.text.length == 10) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
