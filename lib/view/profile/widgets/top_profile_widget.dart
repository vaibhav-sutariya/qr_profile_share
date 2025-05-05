import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/responsive.dart';
import 'package:qr_profile_share/view/profile/widgets/counts_widget.dart';
import 'package:qr_profile_share/view/profile/widgets/setting_edit_button_widget.dart';
import 'package:qr_profile_share/view/widget/profile_mode_selector_widget.dart';
import 'package:qr_profile_share/view_model/controller/profile/user_profile_view_model.dart';

class TopProfileWidget extends StatelessWidget {
  final UserProfileViewModel userProfileViewModel;

  const TopProfileWidget({super.key, required this.userProfileViewModel});

  @override
  Widget build(BuildContext context) {
    final data = userProfileViewModel.userProfile?.data?.user;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * -50), // Slide from top
            child: child,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: AppColors.gradientColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: getScreenHeight(context) * 0.05),
            SettingEditButtonWidget(userProfileViewModel: userProfileViewModel),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: CachedNetworkImageProvider(
                  data?.photo ??
                      'https://toppng.com/uploads/preview/male-user-filled-icon-man-icon-115533970576b3erfsss1.png',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              data?.name ?? 'User Name',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              data?.userRole ?? 'User Role',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColors.whiteColor,
              ),
            ),
            Text(
              data?.company ?? 'Company Name',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const ProfileModeSelector(),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.whiteColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                'Sharing all contact details',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Divider(color: AppColors.whiteColor.withOpacity(0.5)),
            ),
            const CountsWidget(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
