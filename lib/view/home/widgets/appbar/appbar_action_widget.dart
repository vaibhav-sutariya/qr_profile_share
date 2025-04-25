import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class AppbarActionWidget extends StatelessWidget {
  const AppbarActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideInDown(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 2,
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Feather.bell),
              onPressed: () {
                // Handle notification icon press
              },
            ),
          ),
          Positioned(
            top: 12,
            right: 32,
            child: Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
