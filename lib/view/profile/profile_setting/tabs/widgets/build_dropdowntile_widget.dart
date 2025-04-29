import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';

class BuildDropdowntileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  const BuildDropdowntileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.items,
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
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            height: 35,
            decoration: BoxDecoration(
              color: AppColors.darkColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              value: value,
              underline: const SizedBox.shrink(),
              borderRadius: BorderRadius.circular(10),
              onChanged: onChanged,
              items:
                  items
                      .map(
                        (e) =>
                            DropdownMenuItem<String>(value: e, child: Text(e)),
                      )
                      .toList(),
            ),
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
