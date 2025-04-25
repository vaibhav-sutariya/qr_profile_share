// view_model/onboarding/onboarding_view_model.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_profile_share/configs/assets/icons_assets.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/routes/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingItem {
  final String title;
  final String subtitle;
  final SvgPicture image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Widget background;

  OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
    required this.background,
  });
}

class OnboardingViewModel extends ChangeNotifier {
  int currentPage = 0;

  final List<OnboardingItem> items = [
    OnboardingItem(
      title: "ONE CLICK SHARE",
      subtitle:
          "Instantly share your digital profile with anyone, anywhere. Just scan your QR code — no typing, no hassle.",
      image: SvgPicture.asset(IconsAssets.onboarding1),
      backgroundColor: AppColors.primaryColor,
      titleColor: AppColors.whiteColor,
      subtitleColor: AppColors.whiteColor,
      background: Lottie.network(
        'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json',
      ),
    ),
    OnboardingItem(
      title: "INTUITIVE CONTROL",
      subtitle:
          "Seamlessly manage your digital identity. Edit, update, and personalize your profile with ease.",
      image: SvgPicture.asset(IconsAssets.onboarding2),
      backgroundColor: AppColors.whiteColor,
      titleColor: AppColors.primaryColor,
      subtitleColor: AppColors.primaryColor2,
      background: Lottie.network(
        'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json',
      ),
    ),
    OnboardingItem(
      title: "TRACK YOUR CONTACTS",
      subtitle:
          "Stay connected and organized. Know who scanned your QR and keep a smart list of your connections.",
      image: SvgPicture.asset(IconsAssets.onboarding3),
      backgroundColor: AppColors.primaryColor,
      titleColor: AppColors.whiteColor,
      subtitleColor: AppColors.whiteColor,
      background: Lottie.network(
        'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json',
      ),
    ),
    OnboardingItem(
      title: "SHARE YOUR PROFILE",
      subtitle:
          "Go paperless. Use your personal QR to share your contact info professionally and efficiently.",
      image: SvgPicture.asset(IconsAssets.onboarding4),
      backgroundColor: AppColors.whiteColor,
      titleColor: AppColors.primaryColor,
      subtitleColor: AppColors.primaryColor2,
      background: Lottie.network(
        'https://assets2.lottiefiles.com/packages/lf20_bq485nmk.json',
      ),
    ),
  ];

  void updatePage(int index) {
    currentPage = index;
    notifyListeners();
  }

  Future<void> completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isOnBoardingVisited", true);
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(RoutesName.splash, (route) => false);
  }
}
