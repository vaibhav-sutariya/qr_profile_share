import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/components/tappable_text.dart';

class HaveAccountText extends StatelessWidget {
  final String text;
  final String tappableText;
  final VoidCallback onPress;

  const HaveAccountText({
    super.key,
    required this.text,
    required this.tappableText,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 100.0, end: 0.0),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 7,
        children: [
          Text(
            text,
            style: TextStyle(
              color: AppColors.lightColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          TappableText(
            text: tappableText,
            onPress: onPress,
            alignmet: Alignment.centerLeft,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
