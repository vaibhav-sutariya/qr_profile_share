import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';

class CountsWidget extends StatelessWidget {
  const CountsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAnalyticsItem('256', 'Connections'),
              _buildAnalyticsItem('12', 'Events'),
              _buildAnalyticsItem('89', 'Scans'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: AppColors.whiteColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.whiteColor.withOpacity(0.9),
          ),
        ),
      ],
    );
  }
}
