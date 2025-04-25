import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';

class YourQrWidget extends StatelessWidget {
  const YourQrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your QR Code',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: IconButton(
              icon: Icon(
                Feather.share_2,
                size: 20,
                color: AppColors.primaryColor2,
              ),
              onPressed: () {
                // Handle notification icon press
              },
            ),
          ),
        ),
      ],
    );
  }
}
