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
    return Row(
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
    );
  }
}
