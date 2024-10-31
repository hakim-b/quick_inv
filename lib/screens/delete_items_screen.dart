// lib/screens/delete_item/delete_item_screen.dart
import 'package:flutter/material.dart';
import 'package:quick_inv/screens/success_screen.dart';

class DeleteItemScreen extends StatefulWidget {
  const DeleteItemScreen({super.key});

  @override
  State<DeleteItemScreen> createState() => _DeleteItemScreenState();
}

class _DeleteItemScreenState extends State<DeleteItemScreen> {
  final TextEditingController typeController = TextEditingController();
  String? selectedType;

  final TextEditingController partController = TextEditingController();
  String? selectedPart;

  List<String> entries = ["Resistor", "Capacitor", "Diode", "Other"];
  List<String> cmpNums = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Item'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Delete an Item",
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 15),
            const Text("Choose the type and part number of the component that you wish to delete"),
            const SizedBox(height: 15),
            DropdownMenu<String>(
              initialSelection: "",
              controller: typeController,
              requestFocusOnTap: true,
              label: const Text("Component Type"),
              width: 250,
              onSelected: (String? type) {
                setState(() {
                  selectedType = type;
                });
              },
              dropdownMenuEntries: entries.map<DropdownMenuEntry<String>>((String entry) {
                return DropdownMenuEntry<String>(
                  value: entry,
                  label: entry,
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            DropdownMenu<String>(
              initialSelection: "",
              controller: partController,
              requestFocusOnTap: true,
              label: const Text("Part Number"),
              width: 250,
              onSelected: (String? part) {
                setState(() {
                  selectedPart = part;
                });
              },
              dropdownMenuEntries: cmpNums.map<DropdownMenuEntry<String>>((String entry) {
                return DropdownMenuEntry<String>(
                  value: entry,
                  label: entry,
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => _confirmDelete(context),
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red)),
              child: const Text("Delete item"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteItem();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem() {
    // Implement actual delete logic here
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SuccessScreen(
          succMsg: "The item has successfully been deleted from the inventory.",
        ),
      ),
    );
  }
}
