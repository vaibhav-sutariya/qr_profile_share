import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/view/home/widgets/custom_list_tile.dart';
import 'package:qr_profile_share/view_model/controller/profile/user_profile_view_model.dart';

class FollowUpWidget extends StatelessWidget {
  const FollowUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final followUps = context.watch<UserProfileViewModel>().followUps;

    return FadeInRight(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Smart Follow-ups',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...followUps.map(
              (followUp) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomListTile(
                  icon: followUp.icon,
                  title: followUp.title,
                  due: followUp.due,
                  btn: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
