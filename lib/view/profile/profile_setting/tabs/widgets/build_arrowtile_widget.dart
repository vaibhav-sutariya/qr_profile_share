import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';

class BuildArrowtileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const BuildArrowtileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
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
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
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
