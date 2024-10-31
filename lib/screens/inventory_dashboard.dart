// lib/screens/inventory_dashboard.dart
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class InventoryDashboard extends StatelessWidget {
  final PocketBase pb;

  const InventoryDashboard({super.key, required this.pb});

  @override
  Widget build(BuildContext context) {
    // Add actual dashboard implementation here
    return Scaffold(
      appBar: AppBar(title: const Text('Inventory Dashboard')),
      body: const Center(child: Text('Inventory Dashboard Content')),
    );
  }
}
