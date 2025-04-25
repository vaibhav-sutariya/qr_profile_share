import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/routes/routes_name.dart';
import 'package:qr_profile_share/configs/utils/utils.dart';
import 'package:qr_profile_share/repository/auth/forgot_password_repository.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  String _email = '';

  String get email => _email;

  void updateEmail(String value) {
    _email = value;
    log("Email updated: $_email");
    notifyListeners();
  }

  bool _forgotPasswordLoading = false;
  bool get forgotPasswordLoading => _forgotPasswordLoading;

  setforgotPasswordLoading(bool value) {
    _forgotPasswordLoading = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> forgotPassword(BuildContext context) async {
    try {
      setforgotPasswordLoading(true);
      log("Current email value: $email");
      final data = {"email": email};
      final response = await ForgotPasswordRepository().forgotPasswordApi(data);
      log("Forgot Password Response: $response");
      log('Forgot Password success');
      setforgotPasswordLoading(false);
      Utils.flushBarSuccessMessage(
        "Password reset link sent Successful",
        context,
      );
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.loginScreen,
        (route) => false,
      );

      return response;
    } catch (e) {
      log("forgot password Error: $e");
      setforgotPasswordLoading(false);
      return {"success": false, "message": e.toString()};
    } finally {
      setforgotPasswordLoading(false);
    }
  }
}
