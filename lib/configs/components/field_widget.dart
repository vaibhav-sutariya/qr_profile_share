import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/components/custom_text_field.dart';

class FieldWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final String text;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  final String? initialValue;
  final int? duration; // Duration for the animation
  const FieldWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.text,
    required this.onChanged,
    required this.keyboardType,
    this.initialValue,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TweenAnimationBuilder<double>(
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

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            const SizedBox(height: 8),
            CustomTextField(
              isBoxShadow: true,
              initialValue: initialValue,
              bgColor: AppColors.whiteColor,
              icon: icon,
              text: text,
              onChanged: onChanged,
              keyboardType: keyboardType,
            ),
          ],
        ),
      ),
    );
  }
}
