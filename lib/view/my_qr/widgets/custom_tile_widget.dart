import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';

class CustomTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isSwitchEnabled;
  const CustomTileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.value,
    required this.onChanged,
    this.isSwitchEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      delay: const Duration(milliseconds: 300),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.lightColor.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: AppColors.lightColor, size: 30),
          trailing:
              isSwitchEnabled
                  ? Switch(
                    value: value,
                    onChanged: onChanged,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: AppColors.primaryColor,
                    activeTrackColor: AppColors.primaryColor.withOpacity(0.3),
                    inactiveThumbColor: AppColors.primaryColor,
                    inactiveTrackColor: AppColors.primaryColor.withOpacity(0.3),
                  )
                  : SizedBox.shrink(),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.lightColor,
            ),
          ),
          subtitle: Text(
            subTitle,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
