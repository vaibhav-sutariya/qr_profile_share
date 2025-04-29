import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/view_model/controller/contact/add_contact_view_model.dart';
import 'package:qr_profile_share/view_model/services/image_helper/image_helper.dart';

class AddPhotoWidget extends StatelessWidget {
  const AddPhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddContactViewModel>(
      builder: (context, viewModel, _) {
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: viewModel.pickImage,
                child: Column(
                  children: [
                    ImageHelper.imageOrPlaceholder(viewModel.profileImage, 100),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.camera_alt,
                          color: AppColors.primaryColor,
                          size: 18,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Add Photo',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
