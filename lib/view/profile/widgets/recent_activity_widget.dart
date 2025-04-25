import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/view/home/widgets/custom_list_tile.dart';
import 'package:qr_profile_share/view_model/controller/profile/user_profile_view_model.dart';

class RecentActivityWidget extends StatelessWidget {
  const RecentActivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final activity = context.watch<UserProfileViewModel>().recentActivity;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Activity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...activity.map(
            (activity) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CustomListTile(
                icon: activity.icon,
                title: activity.title,
                due: activity.due,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
