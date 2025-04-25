import 'package:flutter/material.dart';

class FollowUp {
  final String title;
  final String due;
  final IconData icon;
  final bool isBold;

  FollowUp({
    required this.title,
    required this.due,
    required this.icon,
    this.isBold = false,
  });
}
