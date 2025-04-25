import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/components/custom_elevated_button.dart';
import 'package:qr_profile_share/configs/components/custom_text_field.dart';
import 'package:qr_profile_share/view_model/controller/profile/profile_setting_view_model.dart';
import 'package:qr_profile_share/view_model/controller/profile/user_profile_view_model.dart';

class SocialTab extends StatelessWidget {
  const SocialTab({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (_) => UserProfileViewModel()..getUserProfile(),
        // ),
        ChangeNotifierProvider(create: (_) => ProfileSettingViewModel()),
      ],
      child: Consumer2<UserProfileViewModel, ProfileSettingViewModel>(
        builder: (context, userProfileVM, profileSettingVM, child) {
          final data = userProfileVM.userProfile?.data!.user;

          profileSettingVM.updateGithub(data?.socialLinks?.github ?? '');
          profileSettingVM.updateLinkedin(data?.socialLinks?.linkedIn ?? '');
          profileSettingVM.updateinstagram(data?.socialLinks?.instagram ?? '');
          profileSettingVM.updateTwitter(data?.socialLinks?.twitter ?? '');

          if (userProfileVM.getuserProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          return RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: () async {
              await userProfileVM.getUserProfile();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blackColor.withOpacity(0.08),
                              blurRadius: 6,
                              spreadRadius: 1,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12,
                          ),
                          child: Column(
                            spacing: 20,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Social Links',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blackColor,
                                ),
                              ),
                              CustomTextField(
                                initialValue: data?.socialLinks?.github ?? '',
                                icon: FontAwesome.github,
                                text: 'GitHub',
                                onChanged: (value) {
                                  profileSettingVM.updateGithub(value);
                                },
                              ),
                              CustomTextField(
                                initialValue: data?.socialLinks?.linkedIn ?? '',
                                icon: FontAwesome.linkedin,
                                text: 'LinkedIn',
                                onChanged: (value) {
                                  profileSettingVM.updateLinkedin(value);
                                },
                              ),
                              CustomTextField(
                                initialValue:
                                    data?.socialLinks?.instagram ?? '',
                                icon: FontAwesome.instagram,
                                text: 'Instagram',
                                onChanged: (value) {
                                  profileSettingVM.updateinstagram(value);
                                },
                              ),
                              CustomTextField(
                                initialValue: data?.socialLinks?.twitter ?? '',
                                icon: FontAwesome.twitter,
                                text: 'Twitter',
                                onChanged: (value) {
                                  profileSettingVM.updateTwitter(value);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                      text: 'Save Changes',
                      onPress: () {
                        profileSettingVM.updateSocialLinks(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
