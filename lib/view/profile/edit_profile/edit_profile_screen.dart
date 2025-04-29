import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/components/custom_app_bar.dart';
import 'package:qr_profile_share/configs/components/custom_elevated_button.dart';
import 'package:qr_profile_share/configs/components/field_widget.dart';
import 'package:qr_profile_share/configs/responsive.dart';
import 'package:qr_profile_share/view/profile/edit_profile/widgets/image_picker_widget.dart';
import 'package:qr_profile_share/view_model/controller/profile/update_profile_view_model.dart';
import 'package:qr_profile_share/view_model/controller/profile/user_profile_view_model.dart';

class EditProfileScreen extends StatelessWidget {
  final UserProfileViewModel userProfileViewModel;
  const EditProfileScreen({super.key, required this.userProfileViewModel});

  @override
  Widget build(BuildContext context) {
    log('Edit Profile Screen: ${userProfileViewModel.userProfile}');
    final data = userProfileViewModel.userProfile?.data?.user;
    return Consumer<UpdateProfileViewModel>(
      builder: (context, viewModel, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          viewModel.setfullName(data?.name ?? '');
          viewModel.setEmail(data?.email ?? '');
          viewModel.setPhone(data?.phoneNumber ?? '');
          viewModel.setLocation(data?.location ?? '');
          viewModel.setCompany(data?.company ?? '');
          viewModel.setRole(data?.userRole ?? '');
          viewModel.setWebsite(data?.website ?? '');
        });
        return RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            await userProfileViewModel.getUserProfile();
          },
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(getScreenHeight(context) * 0.08),
              child: CustomAppBar(
                text: 'Edit Profile',
                isBackButtonVisible: true,
              ),
            ),
            body: SingleChildScrollView(
              child: TweenAnimationBuilder<double>(
                tween: Tween(
                  begin: 100.0,
                  end: 0.0,
                ), // Slide from right to left
                duration: Duration(milliseconds: 600),
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(value, 0), // X-axis slide
                    child: Opacity(
                      opacity: 1 - (value / 100), // fade in effect
                      child: child,
                    ),
                  );
                },
                child: Column(
                  spacing: 20,
                  children: [
                    const SizedBox(height: 20),
                    ProfilePickerWidget(
                      userProfileViewModel: userProfileViewModel,
                    ),
                    FieldWidget(
                      title: 'Full Name',
                      icon: Icons.person_2_outlined,
                      text: 'Enter your name',
                      initialValue: data?.name,
                      onChanged: (value) => viewModel.setfullName(value),
                      keyboardType: TextInputType.name,
                    ),
                    FieldWidget(
                      title: 'Email',
                      icon: Icons.email_outlined,
                      text: 'Enter your name',
                      onChanged: (value) => viewModel.setEmail(value),
                      initialValue: data?.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    FieldWidget(
                      title: 'Phone',
                      icon: Feather.phone,
                      initialValue: data?.phoneNumber,
                      text: 'Enter your name',
                      onChanged: (value) => viewModel.setPhone(value),

                      keyboardType: TextInputType.number,
                    ),
                    FieldWidget(
                      title: 'Location',
                      icon: Icons.location_on_outlined,
                      text: 'Enter your name',
                      initialValue: data?.location,
                      onChanged: (value) => viewModel.setLocation(value),
                      keyboardType: TextInputType.text,
                    ),
                    FieldWidget(
                      title: 'Company',
                      icon: Icons.work_outline_rounded,
                      text: 'Enter your name',
                      initialValue: data?.company,
                      onChanged: (value) => viewModel.setCompany(value),
                      keyboardType: TextInputType.name,
                    ),
                    FieldWidget(
                      title: 'Role',
                      icon: Icons.work_outline_rounded,
                      text: 'Enter your name',
                      initialValue: data?.userRole,
                      onChanged: (value) => viewModel.setRole(value),
                      keyboardType: TextInputType.name,
                    ),
                    FieldWidget(
                      title: 'Website',
                      icon: Feather.link,
                      initialValue: data?.website,
                      text: 'Enter your name',
                      onChanged: (value) => viewModel.setWebsite(value),
                      keyboardType: TextInputType.name,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child:
                          viewModel.updateProfileLoading
                              ? const CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              )
                              : CustomElevatedButton(
                                text: 'Save Changes',
                                onPress: () {
                                  viewModel.updateUserProfile(context);
                                },
                              ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
