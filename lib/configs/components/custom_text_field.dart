import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Color? bgColor;
  final String? initialValue;
  final bool isBoxShadow;
  final int? duration;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.icon,
    required this.text,
    this.keyboardType,
    this.onChanged,
    this.bgColor,
    this.initialValue,
    this.isBoxShadow = false,
    this.duration,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 100.0, end: 0.0),
      duration: Duration(milliseconds: duration ?? 500),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(value, 0),
          child: Opacity(opacity: 1 - (value / 100), child: child),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: bgColor ?? AppColors.lightColor.withOpacity(0.1),
              boxShadow: [
                isBoxShadow
                    ? BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.2),
                      blurRadius: 2,
                    )
                    : BoxShadow(
                      color: AppColors.whiteColor.withOpacity(0.1),
                      blurRadius: 2,
                    ),
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextFormField(
              initialValue: initialValue,
              keyboardType: keyboardType,
              validator: validator,
              onChanged: onChanged,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                prefixIcon: Icon(icon, color: AppColors.darkColor, size: 20),
                hintText: text,
                hintStyle: TextStyle(color: AppColors.lightColor),
                contentPadding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
