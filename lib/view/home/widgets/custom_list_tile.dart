import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String due;
  final IconData icon;
  final bool btn;
  const CustomListTile({
    super.key,
    required this.title,
    required this.due,
    required this.icon,
    this.btn = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.08),
            blurRadius: 3,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade700),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  due,
                  style: const TextStyle(
                    color: AppColors.mediumColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          btn
              ? Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor2,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: const Text(
                  'Send',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
