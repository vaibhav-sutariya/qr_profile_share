import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_profile_share/view_model/services/session_manager/session_controller.dart';

import '../../../configs/routes/routes_name.dart';

class SplashServices with ChangeNotifier {
  Future<void> checkAuthentication(BuildContext context) async {
    try {
      await SessionController().getUserFromPreference();
      // initDynamicLinks(context);
      log("Retrieved isLogin value: ${SessionController().isLogin}");

      Timer(const Duration(seconds: 2), () {
        if (SessionController().isLogin) {
          log("User is logged in, navigating to Home");

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
