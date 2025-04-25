import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/view_model/controller/profile/update_profile_view_model.dart';
import 'package:qr_profile_share/view_model/controller/profile/user_profile_view_model.dart';

class ProfilePickerWidget extends StatelessWidget {
  final UserProfileViewModel userProfileViewModel;
  const ProfilePickerWidget({super.key, required this.userProfileViewModel});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UpdateProfileViewModel>(context);

    return FadeInRight(
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            // Profile Image
            CircleAvatar(
              radius: 70,
              backgroundImage:
                  userViewModel.profileImage != null
                      ? FileImage(userViewModel.profileImage!)
                      : NetworkImage(
                        userProfileViewModel.userProfile?.data?.user?.photo ??
                            '',
                      ),
            ),

            // Camera Icon Button
            GestureDetector(
              onTap: () async {
                await userViewModel.pickImage();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
