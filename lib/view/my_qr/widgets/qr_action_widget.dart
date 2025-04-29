import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/routes/routes_name.dart';
import 'package:qr_profile_share/view_model/controller/my_qr/my_qr_view_model.dart';

class QrActionWidget extends StatelessWidget {
  const QrActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyQrViewModel>(
      builder: (context, qrViewModel, child) {
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

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              actionButton(
                Icons.share_outlined,
                'Share',
                () => qrViewModel.shareQr(),
              ),
              actionButton(
                Icons.save_alt_outlined,
                'Save',
                () => qrViewModel.saveQr(),
              ),
              actionButton(
                Feather.credit_card,
                'Edit',
                () => Navigator.pushNamed(
                  context,
                  RoutesName.profileSettingsScreen,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget actionButton(IconData icon, String label, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Icon(icon, color: AppColors.primaryColor),
        const SizedBox(height: 5),
        Text(label, style: TextStyle(color: AppColors.blackColor)),
      ],
    ),
  );
}
