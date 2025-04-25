import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qr_profile_share/configs/routes/routes_name.dart';
import 'package:qr_profile_share/configs/utils/utils.dart';
import 'package:qr_profile_share/repository/auth/social_login_repository.dart';
import 'package:qr_profile_share/view_model/services/session_manager/session_controller.dart';

class SocialLoginViewModel with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile', 'openid'],
    serverClientId: dotenv.env['WEB_CLIENT_ID'],
  );

  bool _googleSignInLoading = false;
  bool get googleSignInLoading => _googleSignInLoading;

  void setGoogleSignInLoading(bool value) {
    _googleSignInLoading = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>?> googleSignIn(BuildContext context) async {
    try {
      setGoogleSignInLoading(true);

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        log("Google Sign-In cancelled.");
        setGoogleSignInLoading(false);
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final String? idToken = googleAuth.idToken;
      if (idToken == null) {
        log("Error: Google ID Token is null.");
        setGoogleSignInLoading(false);
        return null;
      }

      log("Google ID Token: $idToken");

      // Send ID Token to backend
      final response = await SocialLoginRepository().firebaseSocialLogin(
        idToken,
      );
      final accessToken = response['data']['accessToken'];
      final refreshToken = response['data']['refreshToken'];
      await SessionController().saveUserInPreference(accessToken, refreshToken);
      await SessionController().getUserFromPreference();
      setGoogleSignInLoading(false);

      Utils.flushBarSuccessMessage(
        "Login Successful",
        context, // Assuming you have access to the context here
      );
      await Future.delayed(const Duration(seconds: 1));
      if (SessionController().isLogin) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.bottomNavBar,
          (route) => false,
        );
      }

      log("Google Sign-In API Response: $response");

      setGoogleSignInLoading(false);
      return response;
    } catch (e) {
      log("Google Sign-In Error: $e");
      setGoogleSignInLoading(false);
      return null;
    } finally {
      setGoogleSignInLoading(false);
    }
  }
}
