import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:qr_profile_share/configs/app_url.dart';

class DeleteContactRepository extends ChangeNotifier {
  Future<void> deletContact(String id, String token) async {
    try {
      if (token.isEmpty) {
        throw Exception("Token is empty or null");
      }

      final url = Uri.parse('${AppUrl.deleteContactEndPoint}$id');

      final response = await delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      log("Response Status Code: '${response.statusCode}'");
      log("Response Body: '${response.body}'");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        log("Contact deleted Success Response: $responseData");
        return responseData;
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(
          "contact deletion failed: ${errorData['message'] ?? 'Unknown error'}",
        );
      }
    } catch (e) {
      log("contact delete Error: $e");
      throw Exception(e.toString());
    }
  }
}
