import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/routes/routes_name.dart';
import 'package:qr_profile_share/view_model/controller/profile/user_profile_view_model.dart';

class SettingEditButtonWidget extends StatelessWidget {
  final UserProfileViewModel userProfileViewModel;
  const SettingEditButtonWidget({
    super.key,
    required this.userProfileViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: IconButton(
              icon: Icon(AntDesign.setting),
              color: Colors.white,
              onPressed: () {
                // Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  RoutesName.profileSettingsScreen,
                  arguments: userProfileViewModel,
                );
              },
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: IconButton(
              icon: const Icon(FontAwesome.edit),
              color: Colors.white,
              onPressed: () {
                // Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  RoutesName.editProfileScreen,
                  arguments: userProfileViewModel,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
