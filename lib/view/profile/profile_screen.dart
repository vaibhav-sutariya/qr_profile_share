import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/components/custom_elevated_button.dart';
import 'package:qr_profile_share/configs/routes/routes_name.dart';
import 'package:qr_profile_share/view/profile/widgets/follow_up_widget.dart';
import 'package:qr_profile_share/view/profile/widgets/profile_action_widget.dart';
import 'package:qr_profile_share/view/profile/widgets/profile_shimmer_widget.dart';
import 'package:qr_profile_share/view/profile/widgets/qr_code_ana_widget.dart';
import 'package:qr_profile_share/view/profile/widgets/recent_activity_widget.dart';
import 'package:qr_profile_share/view/profile/widgets/top_profile_widget.dart';
import 'package:qr_profile_share/view_model/controller/profile/user_profile_view_model.dart';
import 'package:qr_profile_share/view_model/services/bottom_navbar/bottom_navbar_provider.dart';
import 'package:qr_profile_share/view_model/services/session_manager/session_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileViewModel>(
      builder: (context, userProfileViewModel, child) {
        log('User Profile: ${userProfileViewModel.userProfile}');
        return Scaffold(
          body: RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: () async {
              // Triggering a reload of the profile
              await userProfileViewModel.getUserProfile();
            },
            child:
                userProfileViewModel.getuserProfileLoading
                    ? FullProfileShimmer()
                    : SingleChildScrollView(
                      child: Column(
                        children: [
                          TopProfileWidget(
                            userProfileViewModel: userProfileViewModel,
                          ),
                          ProfileActionWidget(),
                          const SizedBox(height: 20),
                          FollowUpWidget(),
                          const SizedBox(height: 20),
                          RecentActivityWidget(),
                          QrCodeAnaWidget(),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Consumer<BottomNavBarProvider>(
                              builder: (context, viewModel, child) {
                                return CustomElevatedButton(
                                  btnColor: AppColors.redColor,
                                  text: 'Logout',
                                  onPress: () {
                                    SessionController().clearSession().then((
                                      value,
                                    ) {
                                      log('Session cleared: ');
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RoutesName.loginScreen,
                                        (route) => false,
                                      );
                                      viewModel.resetIndex();
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
          ),
        );
      },
    );
  }
}
                            // ListTile(
                            //   title: const Text('Logout'),
                            //   onTap: () {
                            //     SessionController().clearSession().then((
                            //       value,
                            //     ) {
                            //       log('Session cleared: ');
                            //       Navigator.pushNamedAndRemoveUntil(
                            //         context,
                            //         RoutesName.loginScreen,
                            //         (route) => false,
                            //       );
                            //     });
                            //   },
                            // ),