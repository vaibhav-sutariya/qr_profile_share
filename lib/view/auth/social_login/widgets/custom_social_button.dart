import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';

class CustomSocialButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String imagePath;
  final int? duration;

  const CustomSocialButton({
    required this.onPressed,
    required this.text,
    required this.imagePath,
    this.duration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 100.0, end: 0.0),
      duration: Duration(milliseconds: duration ?? 500),

      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(value, 0), // X-axis slide
          child: Opacity(
            opacity: 1 - (value / 100), // fade in effect
            child: child,
          ),
        );
      },
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.blackColor,
          backgroundColor: AppColors.whiteColor, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
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
      ),
    );
  }
}
