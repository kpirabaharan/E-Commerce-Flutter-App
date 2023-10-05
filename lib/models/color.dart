import 'package:flutter/material.dart';

class CustomColor {
  final String id;
  final String name;
  final Color value;

  const CustomColor({
    required this.id,
    required this.name,
    required this.value,
  });

  factory CustomColor.fromJson(Map<String, dynamic> json) {
    return CustomColor(
      id: json['id'],
      name: json['name'],
      value: Color(int.parse('ff${(json['value']).toString().substring(1)}', radix: 16)),
    );
  }
}
