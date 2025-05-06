import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/routes/routes_name.dart';

class ProfileActionWidget extends StatelessWidget {
  const ProfileActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 100.0, end: 0.0), // Slide from right to left
      duration: Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(value, 0), // X-axis slide
          child: Opacity(
            opacity: 1 - (value / 100), // fade in effect
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQuickAction(Icons.qr_code_2_outlined, 'My QR Code', () {
                  // Navigate to My QR Code screen
                }),
                _buildQuickAction(
                  Icons.send_to_mobile_outlined,
                  'NFC Share',
                  () {
                    Navigator.pushNamed(context, RoutesName.nfcShareScreen);
                  },
                ),
                _buildQuickAction(Icons.shield_outlined, 'Privacy', () {
                  // Navigate to Privacy settings
                }),
                _buildQuickAction(Feather.share_2, 'Share', () {
                  // Share the profile
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget builder for each action item
  Widget _buildQuickAction(IconData icon, String label, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: Offset(1, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 28,
              color:
                  AppColors.primaryColor, // Matches the blue shade in the image
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.blackColor.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
