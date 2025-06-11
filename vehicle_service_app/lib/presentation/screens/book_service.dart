// book_service_screen.dart
import 'package:flutter/material.dart';
import 'package:vehicle_service_app/core/database/database_helper.dart';

class BookServiceScreen extends StatefulWidget {
  @override
  _BookServiceScreenState createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends State<BookServiceScreen> {
  final List<String> services = [
    'Oil Change',
    'Tire Rotation',
    'Brake Inspection'
  ];
  final List<String> timeSlots = [
    '09:00 - 10:00 AM',
    '10:00 - 11:00 AM',
    '11:00 - 12:00 PM'
  ];

  String? selectedService;
  String? selectedTime;

  Future<void> _saveBooking(String service, String time) async {
    final db = await DatabaseHelper().database;
    await db.insert('services', {
      'service': service,
      'time': time,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Service')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Select Service'),
              items: services
                  .map((service) => DropdownMenuItem(
                        value: service,
                        child: Text(service),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => selectedService = value),
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Select Time Slot'),
              items: timeSlots
                  .map((slot) => DropdownMenuItem(
                        value: slot,
                        child: Text(slot),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => selectedTime = value),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (selectedService != null && selectedTime != null) {
                  await _saveBooking(selectedService!, selectedTime!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Service booked successfully.')),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Please select service and time slot.')),
                  );
                }
              },
              child: Text('Confirm Booking'),
            )
          ],
        ),
      ),
    );
  }
}
