import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:qr_profile_share/configs/app_url.dart';
import 'package:qr_profile_share/model/users/user_model.dart';

class UpdateUserDataRepository extends ChangeNotifier {
  Future<UserModel> updateUserProfile(String token, dynamic data) async {
    try {
      if (token.isEmpty) {
        throw Exception("Token is empty or null");
      }

      final url = Uri.parse(AppUrl.updateUserDataEndPoint);

      final response = await patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );
      log("Response Status Code: '${response.statusCode}'");
      log("Response Body: '${response.body}'");

      if (response.statusCode == 200) {
        final responseData = userModelFromJson(response.body);
        log("Update User profile Success Response: $responseData");
        return responseData;
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(
          "Update User profile failed: ${errorData['message'] ?? 'Unknown error'}",
        );
      }
    } catch (e) {
      log("get User  Error: $e");
      throw Exception(e.toString());
    }
  }
}
