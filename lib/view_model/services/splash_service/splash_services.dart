import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_profile_share/view_model/services/session_manager/session_controller.dart';

import '../../../configs/routes/routes_name.dart';

class SplashServices with ChangeNotifier {
  Future<void> checkAuthentication(BuildContext context) async {
    try {
      await SessionController()
          .getUserFromPreference(); // Ensure we fetch session data
      // await userProfileViewModel.getUserProfile().then((value) {
      //   log("User profile data fetched successfully in splash screen");
      // }); // Fetch user profile data

      log("Retrieved isLogin value: ${SessionController().isLogin}");

      Timer(const Duration(seconds: 2), () {
        if (SessionController().isLogin) {
          log("User is logged in, navigating to Home");
          // QrCodeDataViewModel qrCodeDataViewModel = QrCodeDataViewModel();

          // qrCodeDataViewModel.getData().then((value) {
          //   log("QR code data fetched successfully in splash screen");
          //   // Fetch QR code data
          // }); //
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.bottomNavBar,
            (route) => false,
          );
        } else {
          log("User is not logged in, navigating to Login");
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.socialLoginScreen,
            (route) => false,
          );
        }
      });
    } catch (error) {
      log("Splash Error: $error");
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.socialLoginScreen,
          (route) => false,
        ),
      );
    }
  }
}
