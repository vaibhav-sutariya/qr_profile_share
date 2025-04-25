import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/components/custom_elevated_button.dart';
import 'package:qr_profile_share/configs/components/my_qr_widget.dart';
import 'package:qr_profile_share/view_model/controller/profile/profile_setting_view_model.dart';

class QrDesignTab extends StatelessWidget {
  const QrDesignTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileSettingViewModel>(
      builder: (context, provider, child) {
        List<Color> themeColors = [
          Colors.blue,
          Colors.orange,
          Colors.black,
          Colors.green,
          Colors.red,
          Colors.purple,
        ];

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 12),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'QR Code Customization',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),

                          /// Theme Colors
                          const Text(
                            'Theme Color',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:
                                themeColors.map((color) {
                                  return GestureDetector(
                                    onTap: () => provider.updateQrColor(color),
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: color,
                                      child:
                                          provider.qrColor == color
                                              ? const Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 18,
                                              )
                                              : null,
                                    ),
                                  );
                                }).toList(),
                          ),

                          const SizedBox(height: 20),

                          /// Upload Logo
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => provider.pickQrLogo(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[100],
                                elevation: 0,
                              ),
                              child: Text(
                                'Upload Custom Logo',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          /// Preview
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.center,
                            child: const Text(
                              'Preview',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: MyQrWidget(size: 0.2),
                            ),
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
                    // Call a method from the ViewModel to persist settings if needed
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
