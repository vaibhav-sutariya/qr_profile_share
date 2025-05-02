import 'dart:developer';

import 'package:flutter/material.dart';

class DynamicProfileScreen extends StatelessWidget {
  final String userId;

  const DynamicProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    log('User ID: $userId'); // Log the userId for debugging
    // Fetch and display user profile using userId
    return Scaffold(
      appBar: AppBar(title: const Text("User Profile")),
      body: Center(child: Text('Display profile for ID: $userId')),
    );
  }
}
