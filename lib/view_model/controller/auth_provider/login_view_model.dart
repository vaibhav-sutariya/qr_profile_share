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
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = value;
    notifyListeners();
  }

  void clearFields() {
    _email = '';
    _password = '';
    notifyListeners();
  }

  bool _loginLoading = false;
  bool get loginLoading => _loginLoading;

  setLoginLoading(bool value) {
    _loginLoading = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(BuildContext context) async {
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
        // QrCodeDataViewModel qrCodeDataViewModel = QrCodeDataViewModel();

        // qrCodeDataViewModel.getData().then((value) {
        //   log("QR code data fetched successfully in login screen");
        //   // Fetch QR code data
        // }); //
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.bottomNavBar,

          (route) => false,
        );
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
      setLoginLoading(false);
    }
  }
}
