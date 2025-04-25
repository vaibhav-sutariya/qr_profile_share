import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/view_model/services/mode_toggle/mode_toggle_view_model.dart';

class ModeToggleButtons extends StatelessWidget {
  const ModeToggleButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ModeToggleViewModel>(context);
    final selectedIndex = viewModel.selectedIndex;
    final modes = viewModel.modes2;

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(modes.length, (index) {
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () => viewModel.updateIndex(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? AppColors.whiteColor
                        : AppColors.whiteColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Text(
                modes[index],
                style: TextStyle(
                  fontSize: 12,
                  color:
                      isSelected
                          ? AppColors.primaryColor
                          : AppColors.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
