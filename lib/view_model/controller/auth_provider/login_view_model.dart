import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/routes/routes_name.dart';
import 'package:qr_profile_share/configs/utils/utils.dart';
import 'package:qr_profile_share/repository/auth/login_repository.dart';
import 'package:qr_profile_share/view_model/services/session_manager/session_controller.dart';

class LoginViewModel extends ChangeNotifier {
  String _email = '';
  String _password = '';

  String get email => _email;
  String get password => _password;

  void updateEmail(String value) {
    _email = value;
    checkLoginButtonEnabled();
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = value;
    checkLoginButtonEnabled();
    notifyListeners();
  }

  void clearFields() {
    _email = '';
    _password = '';
    isLoginButtonEnabled = false;
    checkLoginButtonEnabled();
    notifyListeners();
  }

  bool _loginLoading = false;
  bool get loginLoading => _loginLoading;

  setLoginLoading(bool value) {
    _loginLoading = value;
    notifyListeners();
  }

  bool isLoginButtonEnabled = false;

  void checkLoginButtonEnabled() {
    isLoginButtonEnabled = _email.isNotEmpty && _password.isNotEmpty;
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(
    BuildContext context,
    String dynamicLink,
  ) async {
    try {
      setLoginLoading(true);
      final data = {"email": email, "password": password};
      final response = await LoginRepository().loginApi(data);
      final accessToken = response['data']['accessToken'];
      final refreshToken = response['data']['refreshToken'];
      await SessionController().saveUserInPreference(accessToken, refreshToken);
      await SessionController().getUserFromPreference();
      setLoginLoading(false);
      Utils.flushBarSuccessMessage(
        "Login Successful",
        context, // Assuming you have access to the context here
      );
      await Future.delayed(const Duration(seconds: 1));
      if (SessionController().isLogin) {
        if (dynamicLink.isNotEmpty) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.dynamicProfileScreen,
            (route) => false,
            arguments: dynamicLink,
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.bottomNavBar,
            (route) => false,
          );
        }
      }
      clearFields();
      return response;
    } catch (e) {
      setLoginLoading(false);
      Utils.flushBarErrorMessage(
        "Login failes ${e.toString()}",
        context, // Assuming you have access to the context here
      );
      return {"success": false, "message": e.toString()};
    } finally {
      clearFields();

      setLoginLoading(false);
    }
  }
}
