import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/routes/routes_name.dart';
import 'package:qr_profile_share/configs/utils/utils.dart';
import 'package:qr_profile_share/repository/auth/signup_repository.dart';

class SignupViewModel extends ChangeNotifier {
  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  String get name => _name;
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;

  void updateName(String value) {
    _name = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = value;
    notifyListeners();
  }

  void updateConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  bool get hasMinLength => _password.length >= 8;
  bool get hasUppercase => _password.contains(RegExp(r'[A-Z]'));
  bool get hasLowercase => _password.contains(RegExp(r'[a-z]'));
  bool get hasNumber => _password.contains(RegExp(r'[0-9]'));
  bool get hasSpecialChar =>
      _password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  bool get passwordsMatch => _password == _confirmPassword;

  void clearFields() {
    _name = '';
    _email = '';
    _password = '';
    _confirmPassword = '';
    notifyListeners();
  }

  bool _signupLoading = false;
  bool get signupLoading => _signupLoading;

  setSignupLoading(bool value) {
    _signupLoading = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> signUpUser(BuildContext context) async {
    try {
      setSignupLoading(true);
      final data = {
        "name": name,
        "email": email,
        "password": password,
        "passwordConfirm": confirmPassword,
      };
      final response = await SignupRepository().signUpApi(data);
      // log("Register Response: $response");
      log('SignUp success'); // ✅ Debugging Step
      setSignupLoading(false);
      Utils.flushBarSuccessMessage(
        "SignUp Successful",
        context, // Assuming you have access to the context here
      );
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.loginScreen,
        (route) => false,
      );
      clearFields();
      return response;
    } catch (e) {
      log("SignUp Error: $e"); // Add this log
      setSignupLoading(false);
      return {"success": false, "message": e.toString()};
    } finally {
      setSignupLoading(false);
    }
  }
}
