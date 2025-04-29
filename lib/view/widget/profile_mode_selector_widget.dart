import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/view_model/services/mode_toggle/mode_toggle_view_model.dart';

class ProfileModeSelector extends StatelessWidget {
  const ProfileModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final modeViewModel = context.watch<ModeToggleViewModel>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.whiteColor.withOpacity(0.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(modeViewModel.modes.length, (index) {
          final modeName = modeViewModel.modes[index];
          final isSelected = modeViewModel.selectedIndex == index;

          return GestureDetector(
            onTap: () {
              modeViewModel.updateIndex(index);
              // Optionally update the user profile view model here if needed
              // context.read<UserProfileViewModel>().updateMode(...);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? AppColors.primaryColor.withOpacity(0.8)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                modeName,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
