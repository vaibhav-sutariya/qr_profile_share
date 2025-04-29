import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/components/my_qr_widget.dart';
import 'package:qr_profile_share/configs/responsive.dart';
import 'package:qr_profile_share/view/home/widgets/mode_toggle_btn.dart';
import 'package:qr_profile_share/view/home/widgets/your_qr_widget.dart';
import 'package:qr_profile_share/view_model/services/qr_code_services/qr_code_data_view_model.dart';

class TopWidget extends StatelessWidget {
  // final QrCodeDataViewModel qrCodeDataViewModel;
  const TopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QrCodeDataViewModel>(
      builder: (context, qrCodeDataViewModel, child) {
        log("topwidget : ${qrCodeDataViewModel.id} ");
        // var data = userProfileViewModel.userProfile!.data!.user;
        var id = qrCodeDataViewModel.id;
        var name = qrCodeDataViewModel.name;
        var email = qrCodeDataViewModel.email;
        var photo = qrCodeDataViewModel.photo;
        var position = qrCodeDataViewModel.position;
        var location = qrCodeDataViewModel.location;

        log(
          "id : $id, name : $name, email : $email, photo : $photo, position : $position, location : $location",
        );
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 100.0, end: 0.0),
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
          child: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: getScreenHeight(context) * 0.23,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: AppColors.gradientColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 16,
                        right: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          YourQrWidget(),
                          const SizedBox(height: 10),
                          const Text(
                            'Share your profile instantly',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          const ModeToggleButtons(),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.darkColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min, // Wrap content
                              children: [
                                Icon(
                                  Icons.bolt_outlined, // Lightning bolt icon
                                  size: 14,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 2),
                                const Text(
                                  'Dynamic QR',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -40,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: MyQrWidget(size: 0.15),
                    ),
                  ),
                ],
              ),

              SizedBox(height: getScreenHeight(context) * 0.07),
            ],
          ),
        );
      },
    );
  }
}
