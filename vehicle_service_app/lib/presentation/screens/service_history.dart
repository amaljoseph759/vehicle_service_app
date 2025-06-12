// service_history_screen.dart
import 'package:flutter/material.dart';
import 'package:vehicle_service_app/core/database/database_helper.dart';

class ServiceHistoryScreen extends StatefulWidget {
  @override
  _ServiceHistoryScreenState createState() => _ServiceHistoryScreenState();
}

class _ServiceHistoryScreenState extends State<ServiceHistoryScreen> {
  List<Map<String, dynamic>> history = [];

  Future<void> _loadHistory() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> data = await db.query('services');
    setState(() {
      history = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Service History')),
      body: history.isEmpty
          ? Center(child: Text('No service history available.'))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (_, index) {
                final item = history[index];
                return ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  title: Text(item['service']),
                  subtitle: Text('Completed at ${item['time']}'),
                );
              },
            ),
    );
  }
}
