import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:qr_profile_share/configs/app_url.dart';

class LoginRepository with ChangeNotifier {
  Future<Map<String, dynamic>> loginApi(dynamic data) async {
    try {
      final url = Uri.parse(AppUrl.loginApiEndPoint);

      final response = await post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      log("Response Status Code: '${response.statusCode}'");
      log("Response Body: '${response.body}'");
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        log("Login Response: $responseData");

        return responseData;
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(
          "Login failed: ${errorData['message'] ?? 'Unknown error'}",
        );
      }
    } catch (e) {
      log("Login Error: $e");
      throw Exception(e.toString());
    }
  }
}
