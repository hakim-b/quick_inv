import 'package:flutter/material.dart';

class InventoryItem {
  final String id;
  final String type;
  final String partNumber;
  final String? location;
  final int quantity;
  final String? imageUrl;
  final Map<String, dynamic>? specifications;
  final DateTime dateAdded;
  String? borrowedBy;
  DateTime? borrowedDate;
  DateTime? dueDate;

  InventoryItem({
    required this.id,
    required this.type,
    required this.partNumber,
    this.location,
    required this.quantity,
    this.imageUrl,
    this.specifications,
    required this.dateAdded,
    this.borrowedBy,
    this.borrowedDate,
    this.dueDate,
  });
}

// lib/constants/component_types.dart
class ComponentTypes {
  static const List<String> types = [
    "Resistor",
    "Capacitor",
    "Diode",
    "IC",
    "Transistor",
    "LED",
    "Other"
  ];

  static Map<String, List<String>> specifications = {
    "Resistor": ["Resistance", "Power Rating", "Tolerance"],
    "Capacitor": ["Capacitance", "Voltage Rating", "Type"],
    "Diode": ["Forward Voltage", "Current Rating", "Type"],
    "IC": ["Part Number", "Package", "Description"],
    "Transistor": ["Type", "Current Rating", "Package"],
    "LED": ["Color", "Forward Voltage", "Current Rating"],
    "Other": ["Description", "Specifications"],
  };
}
