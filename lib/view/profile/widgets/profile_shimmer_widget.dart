import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FullProfileShimmer extends StatelessWidget {
  const FullProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            // Top Gradient Area
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),

                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              child: Column(
                children: [
                  // Top Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [_circleShimmer(40), _circleShimmer(40)],
                  ),
                  const SizedBox(height: 20),

                  // Avatar
                  _circleShimmer(80),
                  const SizedBox(height: 12),

                  // Name, Role, Company
                  _rectShimmer(width: 140, height: 16),
                  const SizedBox(height: 8),
                  _rectShimmer(width: 100, height: 12),
                  const SizedBox(height: 6),
                  _rectShimmer(width: 130, height: 12),
                  const SizedBox(height: 20),

                  // Buttons (Full Profile, Event Mode, Stealth Mode)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _roundedRectShimmer(90, 30),
                      _roundedRectShimmer(90, 30),
                      _roundedRectShimmer(90, 30),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Sharing text button
                  _roundedRectShimmer(220, 28),
                  const SizedBox(height: 20),

                  Divider(color: Colors.white30),
                  const SizedBox(height: 12),

                  // Stats (Connections, Events, Scans)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      3,
                      (_) => _rectShimmer(width: 50, height: 30),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Profile Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: _rectShimmer(width: 120, height: 20),
              ),
            ),
            const SizedBox(height: 16),

            // Action Icons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  4,
                  (_) => Column(
                    children: [
                      _circleShimmer(50),
                      const SizedBox(height: 8),
                      _rectShimmer(width: 40, height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rectShimmer({required double width, required double height}) {
    return Container(width: width, height: height, color: Colors.white);
  }

  Widget _roundedRectShimmer(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _circleShimmer(double size) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
