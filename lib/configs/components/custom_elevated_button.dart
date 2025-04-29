import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final Color? btnColor;
  final int? duration;
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPress,
    this.btnColor = AppColors.primaryColor,
    this.duration,
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
          animationDuration: Duration(milliseconds: 200),
          backgroundColor: btnColor,
          minimumSize: Size(double.infinity, 0),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        onPressed: onPress,

        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
