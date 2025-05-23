import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/routes/routes_name.dart';
import 'package:qr_profile_share/view/auth/forgot_password/forgot_password_screen.dart';
import 'package:qr_profile_share/view/auth/login/login_screen.dart';
import 'package:qr_profile_share/view/auth/signup/signup_screen.dart';
import 'package:qr_profile_share/view/auth/social_login/social_login_screen.dart';
import 'package:qr_profile_share/view/bottom_navbar.dart';
import 'package:qr_profile_share/view/contacts/add_new_contact/add_new_contact_screen.dart';
import 'package:qr_profile_share/view/dynamic_profile_Screen.dart';
import 'package:qr_profile_share/view/onboarding/onboarding_screen.dart';
import 'package:qr_profile_share/view/profile/edit_profile/edit_profile_screen.dart';
import 'package:qr_profile_share/view/profile/nfc_share/nfc_share_screen.dart';
import 'package:qr_profile_share/view/profile/profile_setting/profile_setting_screen.dart';
import 'package:qr_profile_share/view/scan/widgets/scanned_result_link_dialogue.dart';
import 'package:qr_profile_share/view/splash/splash_screen.dart';
import 'package:qr_profile_share/view_model/controller/profile/user_profile_view_model.dart';

class Routes {
  Routes._();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // PageRouteBuilder slideTransition(Widget page) {
    //   return PageRouteBuilder(
    //     pageBuilder: (context, animation, secondaryAnimation) => page,
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       var begin = const Offset(1.0, 0.0);
    //       var end = Offset.zero;
    //       var curve = Curves.easeInOutQuart;

    //       var tween = Tween(
    //         begin: begin,
    //         end: end,
    //       ).chain(CurveTween(curve: curve));

    //       return SlideTransition(
    //         position: animation.drive(tween),
    //         child: child,
    //       );
    //     },
    //     transitionDuration: const Duration(milliseconds: 300),
    //   );
    // }

    switch (settings.name) {
      case RoutesName.bottomNavBar:
        return MaterialPageRoute(
          builder: (BuildContext context) => const BottomNavBar(),
        );
      case RoutesName.nfcShareScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const NfcShareScreen(),
        );
      case RoutesName.onBoardingScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const OnBoardingScreen(),
        );
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashScreen(),
        );
      case RoutesName.socialLoginScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SocialLoginScreen(),
        );
      case RoutesName.loginScreen:
        return MaterialPageRoute(
          builder:
              (BuildContext context) =>
                  LoginScreen(dynamicLink: settings.arguments as String?),
        );
      case RoutesName.signUpScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SignupScreen(),
        );
      case RoutesName.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ForgotPasswordScreen(),
        );
      case RoutesName.editProfileScreen:
        return MaterialPageRoute(
          builder:
              (BuildContext context) => EditProfileScreen(
                userProfileViewModel:
                    settings.arguments as UserProfileViewModel,
              ),
        );
      case RoutesName.profileSettingsScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ProfileSettingScreen(),
        );
      case RoutesName.addNewContactScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const AddNewContactScreen(),
        );
      case RoutesName.scannedResultLinkDialogue:
        return MaterialPageRoute(
          builder:
              (BuildContext context) =>
                  ScannedResultLinkDialogue(id: settings.arguments as String),
        );
      case RoutesName.dynamicProfileScreen:
        return MaterialPageRoute(
          builder:
              (BuildContext context) =>
                  DynamicProfileScreen(userId: settings.arguments as String),
        );
      // case RoutesName.onBoardingScreen:
      //   return slideTransition(const OnBoardingScreen());
      // case RoutesName.splash:
      //   return slideTransition(const SplashScreen());
      // case RoutesName.socialLoginScreen:
      //   return slideTransition(const SocialLoginScreen());
      // case RoutesName.loginScreen:
      //   return slideTransition(const LoginScreen());
      // case RoutesName.signUpScreen:
      //   return slideTransition(const SignupScreen());
      // case RoutesName.forgotPasswordScreen:
      //   return slideTransition(const ForgotPasswordScreen());
      // case RoutesName.editProfileScreen:
      //   return slideTransition(
      //     EditProfileScreen(
      //       userProfileViewModel: settings.arguments as UserProfileViewModel,
      //     ),
      //   );
      // case RoutesName.profileSettingsScreen:
      //   return slideTransition(ProfileSettingScreen());
      // case RoutesName.addNewContactScreen:
      //   return slideTransition(AddNewContactScreen());
      // case RoutesName.scannedResultLinkDialogue:
      // return slideTransition(
      //   ScannedResultLinkDialogue(id: settings.arguments as String),
      // );
      // case RoutesName.dynamicProfileScreen:
      //   return slideTransition(
      //     DynamicProfileScreen(userId: settings.arguments as String),
      //   );
      // case RoutesName.nfcShareScreen:
      //   return slideTransition(NfcShareScreen());

      // case RoutesName.bottomNavBar:
      //   // Extract the userProfileViewModel from the settings arguments
      //   return slideTransition(BottomNavBar());

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(child: Text('No route defined')),
            );
          },
        );
    }
  }
}
