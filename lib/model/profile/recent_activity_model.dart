import 'package:flutter/material.dart';

class RecentActivity {
  final String title;
  final String due;
  final IconData icon;
  final bool isBold;

  RecentActivity({
    required this.title,
    required this.due,
    required this.icon,
    this.isBold = false,
  });
}
