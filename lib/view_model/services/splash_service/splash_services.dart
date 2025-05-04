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

  // Future<void> handleDynamicLinks() async {
  //   try {
  //     final PendingDynamicLinkData? initialLink =
  //         await FirebaseDynamicLinks.instance.getInitialLink();

  //     if (initialLink != null) {
  //       final Uri deepLink = initialLink.link;
  //       debugPrint('Dynamic Link (cold start): $deepLink');

  //       if (deepLink.pathSegments.isNotEmpty) {
  //         final userId = deepLink.pathSegments.last;

  //         navigatorKey.currentState?.push(
  //           MaterialPageRoute(
  //             builder: (_) => DynamicProfileScreen(userId: userId),
  //           ),
  //         );
  //       }
  //     }

  //     FirebaseDynamicLinks.instance.onLink
  //         .listen((dynamicLinkData) {
  //           final Uri deepLink = dynamicLinkData.link;
  //           debugPrint('Dynamic Link (foreground): $deepLink');

  //           if (deepLink.pathSegments.isNotEmpty) {
  //             final userId = deepLink.pathSegments.last;

  //             navigatorKey.currentState?.push(
  //               MaterialPageRoute(
  //                 builder: (_) => DynamicProfileScreen(userId: userId),
  //               ),
  //             );
  //           }
  //         })
  //         .onError((e) {
  //           debugPrint('Dynamic link error: $e');
  //         });
  //   } catch (e) {
  //     debugPrint('Error handling dynamic link: $e');
  //   }
  // }
}
