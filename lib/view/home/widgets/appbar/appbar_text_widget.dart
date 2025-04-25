import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/view_model/services/qr_code_services/qr_code_data_view_model.dart';

class AppbarTextWidget extends StatelessWidget {
  const AppbarTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String getGreeting() {
      final hour = DateTime.now().hour;

      if (hour >= 5 && hour < 12) {
        return 'Good Morning,';
      } else if (hour >= 12 && hour < 17) {
        return 'Good Afternoon,';
      } else if (hour >= 17 && hour < 21) {
        return 'Good Evening,';
      } else {
        return 'Good Night,';
      }
    }

    return SlideInDown(
      child: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getGreeting(),

            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Consumer<QrCodeDataViewModel>(
            builder: (context, ref, child) {
              return Text(
                ref.name.isNotEmpty ? ref.name : 'User Name',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
