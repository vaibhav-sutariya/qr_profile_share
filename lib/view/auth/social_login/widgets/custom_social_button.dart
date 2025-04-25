import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';

class CustomSocialButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String imagePath;

  const CustomSocialButton({
    required this.onPressed,
    required this.text,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.blackColor,
        backgroundColor: AppColors.whiteColor, // Text color
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2, // Subtle shadow
        padding: const EdgeInsets.symmetric(horizontal: 16),
        minimumSize: const Size(double.infinity, 54), // Full-width button
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(imagePath, height: 24, width: 24),
          const SizedBox(width: 20),
          Text(
            text,
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
