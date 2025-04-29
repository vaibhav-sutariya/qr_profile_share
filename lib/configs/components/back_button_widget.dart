import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 100.0, end: 0.0),
      duration: Duration(milliseconds: 550),

      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(-value, 0), // X-axis slide
          child: Opacity(
            opacity: 1 - (value / 100), // fade in effect
            child: child,
          ),
        );
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.whiteColor.withOpacity(0.2),
        ),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
