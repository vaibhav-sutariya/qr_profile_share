import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';

class BuildDividerWidget extends StatelessWidget {
  const BuildDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Divider(color: AppColors.lightColor, thickness: 0.2),
    );
  }
}
