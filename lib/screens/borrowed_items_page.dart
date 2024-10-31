// lib/screens/borrowed_items_page.dart
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class BorrowedItemsPage extends StatelessWidget {
  final PocketBase pb;

  const BorrowedItemsPage({super.key, required this.pb});

  @override
  Widget build(BuildContext context) {
    // Add actual borrowed items implementation here
    return Scaffold(
      appBar: AppBar(title: const Text('Borrowed Items')),
      body: const Center(child: Text('Borrowed Items Content')),
    );
  }
}
