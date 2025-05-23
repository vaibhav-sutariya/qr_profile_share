import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';

class BuildSwitchtileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  const BuildSwitchtileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 100.0, end: 0.0),
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOut,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _iconCircle(icon),
              const SizedBox(width: 15),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: AppColors.primaryColor,
            activeTrackColor: AppColors.primaryColor.withOpacity(0.3),
            inactiveThumbColor: AppColors.primaryColor,
            inactiveTrackColor: AppColors.primaryColor.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _iconCircle(IconData icon) {
    return CircleAvatar(
      backgroundColor: AppColors.primaryColor.withOpacity(0.1),
      radius: 16,
      child: Icon(icon, color: AppColors.primaryColor, size: 18),
    );
  }
}
