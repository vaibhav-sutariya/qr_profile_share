import 'package:flutter/material.dart';

class SmartFeatureModel {
  final IconData icon;
  final String title;
  final String description;
  bool isEnabled;

  SmartFeatureModel({
    required this.icon,
    required this.title,
    required this.description,
    this.isEnabled = false,
  });
}
