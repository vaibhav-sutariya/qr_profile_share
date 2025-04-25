import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:qr_profile_share/configs/app_url.dart';
import 'package:qr_profile_share/model/users/user_model.dart';

class GetScanProfileRepository extends ChangeNotifier {
  Future<UserModel> getUserProfile(String id) async {
    try {
      final url = Uri.parse('${AppUrl.getUserDataByIdEndPoint}$id');

      final response = await get(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      log("Response Status Code: '${response.statusCode}'");
      log("Response Body: '${response.body}'");

      if (response.statusCode == 200) {
        final responseData = userModelFromJson(response.body);
        log("Get User Success profile Response: $responseData");
        return responseData;
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(
          "get User profile failed: ${errorData['message'] ?? 'Unknown error'}",
        );
      }
    } catch (e) {
      log("get User profile Error: $e");
      throw Exception(e.toString());
    }
  }
}
