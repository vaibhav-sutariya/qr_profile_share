import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:qr_profile_share/configs/app_url.dart';
import 'package:qr_profile_share/model/users/user_model.dart';

class GetUserDataRepository extends ChangeNotifier {
  Future<UserModel> getUserProfile(String token) async {
    try {
      if (token.isEmpty) {
        throw Exception("Token is empty or null");
      }

      final url = Uri.parse(AppUrl.getUserDataEndPoint);

      final response = await get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      log("Response Status Code: '${response.statusCode}'");
      log("Response Body: '${response.body}'");

      if (response.statusCode == 200) {
        final responseData = userModelFromJson(response.body);
        log("Get User Success Response: $responseData");
        return responseData;
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(
          "get User  failed: ${errorData['message'] ?? 'Unknown error'}",
        );
      }
    } catch (e) {
      log("get User  Error: $e");
      throw Exception(e.toString());
    }
  }
}
