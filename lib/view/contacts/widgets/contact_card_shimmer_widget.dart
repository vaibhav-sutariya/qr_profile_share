import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ContactCardShimmer extends StatelessWidget {
  const ContactCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            // Avatar and Info
            Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(backgroundColor: Colors.white),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 120, height: 16, color: Colors.white),
                    const SizedBox(height: 6),
                    Container(width: 80, height: 12, color: Colors.white),
                    const SizedBox(height: 4),
                    Container(width: 100, height: 12, color: Colors.white),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
            Divider(color: Colors.grey.shade300, thickness: 1),
            const SizedBox(height: 12),

            // Call, Email, Visit buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(3, (index) {
                return Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(width: 40, height: 10, color: Colors.white),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
