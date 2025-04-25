import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/view/my_qr/widgets/appbar/qr_mode_toggle.dart';

class QrAppbarWidget extends StatelessWidget {
  const QrAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideInDown(
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My QR Code',
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Share your professional profile',
            style: TextStyle(color: AppColors.whiteColor, fontSize: 16),
          ),
          const SizedBox(height: 10),
          QrModeToggle(),
        ],
      ),
    );
  }
}
