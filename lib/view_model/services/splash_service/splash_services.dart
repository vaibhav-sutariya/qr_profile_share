import 'dart:async';
import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:qr_profile_share/view/scan/widgets/scanned_result_link_dialogue.dart';
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

  Future<void> handleDynamicLinks(BuildContext context) async {
    try {
      final PendingDynamicLinkData? initialLink =
          await FirebaseDynamicLinks.instance.getInitialLink();
      if (initialLink != null) {
        final Uri deepLink = initialLink.link;
        log('Dynamic Link (cold start): $deepLink');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder:
                (context) =>
                    ScannedResultLinkDialogue(id: deepLink.pathSegments.last),
          );
        });
      }

      FirebaseDynamicLinks.instance.onLink
          .listen((dynamicLinkData) {
            final Uri deepLink = dynamicLinkData.link;
            log('Dynamic Link (foreground): $deepLink');
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder:
                    (context) => ScannedResultLinkDialogue(
                      id: deepLink.pathSegments.last,
                    ),
              );
            });
          })
          .onError((e) {
            log('Dynamic link failed: $e');
          });
    } catch (e) {
      log('Error handling dynamic link: $e');
    }
  }
}
