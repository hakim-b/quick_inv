// lib/screens/add_items_screen.dart

import 'package:flutter/material.dart';
import 'package:quick_inv/constants/component_types.dart';
import 'package:quick_inv/screens/success_screen.dart';
import 'package:quick_inv/services/pocketbase.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Item")),
      body: const Center(child: Text("Add Items Screen")),
    );
  }
  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  final typeController = TextEditingController();
  final partNumberController = TextEditingController();
  final locationController = TextEditingController();
  final quantityController = TextEditingController();
  Map<String, TextEditingController> specControllers = {};

  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Item')),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: currentStep,
          onStepContinue: () {
            if (currentStep < 2) {
              setState(() {
                currentStep++;
              });
            } else {
              _submitForm();
            }
          },
          onStepCancel: () {
            if (currentStep > 0) {
              setState(() {
                currentStep--;
              });
            }
          },
          steps: [
            Step(
              title: const Text('Basic Information'),
              content: _buildBasicInfoStep(),
              isActive: currentStep >= 0,
            ),
            Step(
              title: const Text('Specifications'),
              content: _buildSpecificationsStep(),
              isActive: currentStep >= 1,
            ),
            Step(
              title: const Text('Finish'),
              content: _buildImageStep(),
              isActive: currentStep >= 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoStep() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: selectedType,
          decoration: const InputDecoration(labelText: 'Component Type'),
          items: ComponentTypes.types.map((String type) {
            return DropdownMenuItem(value: type, child: Text(type));
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              selectedType = value;
              _initializeSpecControllers();
            });
          },
          validator: (value) => value == null ? 'Select component type' : null,
        ),
        TextFormField(
          controller: partNumberController,
          decoration: const InputDecoration(labelText: 'Part Number'),
          validator: (value) => value?.isEmpty ?? true ? 'Enter part number' : null,
        ),
        TextFormField(
          controller: locationController,
          decoration: const InputDecoration(labelText: 'Location'),
        ),
        TextFormField(
          controller: quantityController,
          decoration: const InputDecoration(labelText: 'Quantity'),
          keyboardType: TextInputType.number,
          validator: (value) => int.tryParse(value ?? '') == null ? 'Enter valid quantity' : null,
        ),
      ],
    );
  }

  Widget _buildSpecificationsStep() {
    if (selectedType == null) return const Text('Select component type first');

    List<String> specs = ComponentTypes.specifications[selectedType!] ?? [];
    return Column(
      children: specs.map((spec) {
        return TextFormField(
          controller: specControllers[spec],
          decoration: InputDecoration(labelText: spec),
        );
      }).toList(),
    );
  }

  Widget _buildImageStep() {
    return Column(children: [/* Add image upload code if needed */]);
  }

  void _initializeSpecControllers() {
    specControllers.clear();
    for (var spec in ComponentTypes.specifications[selectedType!] ?? []) {
      specControllers[spec] = TextEditingController();
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Example submission logic
      final itemData = {
        'type': selectedType,
        'partNumber': partNumberController.text,
        'location': locationController.text,
        'quantity': int.parse(quantityController.text),
        'specs': specControllers.map((key, value) => MapEntry(key, value.text)),
      };
      // Call PocketBaseService to submit data (Replace 'parts' with your collection name)
      // PocketBaseService.addItem('parts', itemData);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SuccessScreen(succMsg: 'Item added!'),
        ),
      );
    }
  }
}
