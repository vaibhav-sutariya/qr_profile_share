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
  const CustomTextField({
    super.key,
    required this.icon,
    this.keyboardType,
    required this.text,
    this.onChanged,
    this.bgColor,
    this.initialValue,
    this.isBoxShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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

        onEditingComplete: () => FocusScope.of(context).unfocus(),
        onChanged: onChanged,

        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColors.darkColor, size: 20),
          hintText: text,
          hintStyle: TextStyle(color: AppColors.lightColor),
          contentPadding: EdgeInsets.fromLTRB(0, 16, 0, 16),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
          ),
        ),
      ),
    );
  }
}
