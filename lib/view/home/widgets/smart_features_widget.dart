import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/responsive.dart';
import 'package:qr_profile_share/model/home/smart_feature_model.dart';
import 'package:qr_profile_share/view_model/controller/home/home_view_model.dart';

class SmartFeaturesWidget extends StatelessWidget {
  const SmartFeaturesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 100.0, end: 0.0),
          duration: Duration(milliseconds: 700),

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Smart Features',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: getScreenHeight(context) * 0.22,
                child: ListView.separated(
                  padding: const EdgeInsets.all(4),
                  scrollDirection: Axis.horizontal,
                  itemCount: viewModel.features.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final feature = viewModel.features[index];
                    return SmartFeatureCard(
                      feature: feature,
                      onChanged: (_) => viewModel.toggleFeature(index),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SmartFeatureCard extends StatelessWidget {
  final SmartFeatureModel feature;
  final ValueChanged<bool> onChanged;

  const SmartFeatureCard({
    super.key,
    required this.feature,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getScreenWidth(context) * 0.59,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.06),
            blurRadius: 2,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                radius: 18,
                child: Icon(
                  feature.icon,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
              ),
              const Spacer(),
              CupertinoSwitch(
                value: feature.isEnabled,
                onChanged: onChanged,
                activeTrackColor: AppColors.primaryColor, // Blue thumb color
                inactiveTrackColor: Colors.blue.shade100, // Light blue track
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            feature.title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            feature.description,
            style: const TextStyle(fontSize: 12, color: AppColors.blackColor),
          ),
        ],
      ),
    );
  }
}
