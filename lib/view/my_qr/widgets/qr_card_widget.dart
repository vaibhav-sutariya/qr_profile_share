import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/components/my_qr_widget.dart';
import 'package:qr_profile_share/configs/responsive.dart';
import 'package:qr_profile_share/view_model/services/mode_toggle/mode_toggle_view_model.dart';

class QrCardWidget extends StatelessWidget {
  const QrCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: Container(
        width: double.infinity,
        height: getScreenHeight(context) * 0.39,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.lightColor.withOpacity(0.2),
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: AppColors.whiteColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Dynamic QR",
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // const SizedBox(height: 25),
            Center(child: MyQrWidget(size: 0.28)),
            const SizedBox(height: 8),
            Consumer<ModeToggleViewModel>(
              builder: (context, value, child) {
                return Text(
                  value.modes[value.selectedIndex],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
