import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:qr_profile_share/configs/app_url.dart';

class SignupRepository with ChangeNotifier {
  Future<Map<String, dynamic>> signUpApi(dynamic data) async {
    final response = await post(
      Uri.parse(AppUrl.signupApiEndPoint),
      headers: {
        "Content-Type": "application/json", // 👈 add this
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      log("Signup Response: $responseData");
      return responseData;
    } else {
      throw Exception("Signup failed: ${response.body}");
    }
  }
}
