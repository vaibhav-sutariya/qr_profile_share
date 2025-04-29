import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/components/custom_app_bar.dart';
import 'package:qr_profile_share/configs/responsive.dart';
import 'package:qr_profile_share/view/profile/profile_setting/tabs/QR_design_tab.dart';
import 'package:qr_profile_share/view/profile/profile_setting/tabs/general_settings_tab.dart';
import 'package:qr_profile_share/view/profile/profile_setting/tabs/privacy_setting_tab.dart';
import 'package:qr_profile_share/view/profile/profile_setting/tabs/social_tab.dart';
import 'package:qr_profile_share/view_model/controller/profile/profile_setting_view_model.dart';

class ProfileSettingScreen extends StatelessWidget {
  const ProfileSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileSettingViewModel>(context);
    final tabs = [
      const GeneralSettingsTab(),
      const PrivacySettingTab(),
      SocialTab(),
      const QrDesignTab(),
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getScreenHeight(context) * 0.08),
        child: CustomAppBar(
          isBackButtonVisible: true,
          text: 'Profile Settings',
          isActionButtonVisible: false,
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 100.0, end: 0.0), // Slide from right to left
            duration: Duration(milliseconds: 500),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(value, 0), // X-axis slide
                child: Opacity(
                  opacity: 1 - (value / 100), // fade in effect
                  child: child,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (int i = 0; i < 4; i++)
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: ChoiceChip(
                          backgroundColor: AppColors.darkColor.withOpacity(
                            0.05,
                          ),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: Text(
                            ['General', 'Privacy', 'Social', 'QR Design'][i],
                          ),
                          selected: provider.currentTabIndex == i,
                          onSelected: (_) => provider.changeTab(i),
                          selectedColor: AppColors.primaryColor,
                          showCheckmark: false,

                          labelStyle: TextStyle(
                            color:
                                provider.currentTabIndex == i
                                    ? AppColors.whiteColor
                                    : AppColors.lightColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          TweenAnimationBuilder<double>(
            tween: Tween(begin: 100.0, end: 0.0),
            duration: Duration(milliseconds: 700),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(value, 0), // X-axis slide
                child: Opacity(
                  opacity: 1 - (value / 100), // fade in effect
                  child: child,
                ),
              );
            },
            child: Expanded(child: tabs[provider.currentTabIndex]),
          ),
        ],
      ),
    );
  }
}
