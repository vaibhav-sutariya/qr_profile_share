import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:qr_profile_share/configs/app_url.dart';

class SocialLoginRepository with ChangeNotifier {
  Future<Map<String, dynamic>> firebaseSocialLogin(String idToken) async {
    final response = await post(
      Uri.parse(AppUrl.firebaseSocialLoginApiEndPoint),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"token": idToken}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      log("Google Signin Response: $responseData");
      return responseData;
    } else {
      throw Exception("Google Signin failed: ${response.body}");
    }
  }
}
