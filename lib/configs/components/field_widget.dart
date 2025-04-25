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
  const FieldWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.text,
    required this.onChanged,
    required this.keyboardType,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
    );
  }
}
