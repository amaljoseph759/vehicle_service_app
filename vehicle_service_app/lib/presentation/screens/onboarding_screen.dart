// onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'auth_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  final List<String> _titles = [
    'Welcome',
    'Manage Your Vehicles',
    'Book Services Easily'
  ];

  final List<String> _descriptions = [
    'This app helps you manage and book vehicle services.',
    'Add multiple vehicles and keep track of them.',
    'Select a service, time, and confirm — all offline!'
  ];

  void _finishOnboarding() {
    final box = GetStorage();
    box.write('isFirstTime', false);
    Get.offAll(() => AuthScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      body: PageView.builder(
        controller: _controller,
        itemCount: _titles.length,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _titles[index],
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                _descriptions[index],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: index == _titles.length - 1
                    ? _finishOnboarding
                    : () => _controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        ),
                child:
                    Text(index == _titles.length - 1 ? 'Get Started' : 'Next'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
