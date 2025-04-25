import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';

class TappableText extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final Alignment alignmet;
  final FontWeight fontWeight;

  const TappableText({
    super.key,
    required this.text,
    required this.onPress,
    this.alignmet = Alignment.center,
    this.fontWeight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Align(
        alignment: alignmet,
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.primaryColor2,
            fontSize: 14,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
