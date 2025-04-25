import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';

class MQrAnalyticsWidget extends StatelessWidget {
  const MQrAnalyticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'QR Code Analytics',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAnalyticsItem('24', 'Scans'),
                _buildAnalyticsItem('18', 'Saved'),
                _buildAnalyticsItem('5', 'Messages'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: AppColors.blackColor.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
