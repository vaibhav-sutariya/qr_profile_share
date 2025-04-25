import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/components/custom_elevated_button.dart';
import 'package:qr_profile_share/view/profile/profile_setting/tabs/widgets/build_divider_widget.dart';
import 'package:qr_profile_share/view/profile/profile_setting/tabs/widgets/build_dropdowntile_widget.dart';
import 'package:qr_profile_share/view/profile/profile_setting/tabs/widgets/build_switchtile_widget.dart';
import 'package:qr_profile_share/view_model/controller/profile/profile_setting_view_model.dart';

class PrivacySettingTab extends StatelessWidget {
  const PrivacySettingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileSettingViewModel>(
      builder: (context, provider, child) {
        return Padding(
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
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Privacy & Security',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackColor,
                          ),
                        ),
                        const SizedBox(height: 16),

                        /// Smart Auto-Update Contact
                        BuildSwitchtileWidget(
                          icon: Icons.shield_outlined,
                          title: 'Privacy-Controlled QR Codes',
                          value: provider.privacyControlledQr,
                          onChanged:
                              (val) => provider.setPrivacyControlledQr(val),
                        ),

                        BuildDividerWidget(),

                        BuildDropdowntileWidget(
                          icon: Icons.access_time,
                          title: 'QR Code Expiration',
                          value: provider.qrEpiration,
                          onChanged: provider.setQrExpiration,
                          items: const [
                            '24 hours',
                            '12 hours',
                            '6 hours',
                            '3 hours',
                            '2 hours',
                            '1 hour',
                          ],
                        ),
                        BuildDividerWidget(),

                        /// NFC Contact Sharing
                        BuildSwitchtileWidget(
                          icon: Icons.message_outlined,
                          title: 'Direct Messaging Integration',
                          value: provider.directMessage,
                          onChanged:
                              (val) => provider.directMessageInteraction(val),
                        ),

                        BuildDividerWidget(),

                        /// Industry Template
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(text: 'Save Changes', onPress: () {}),
            ],
          ),
        );
      },
    );
  }
}
