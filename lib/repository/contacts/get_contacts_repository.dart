import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:qr_profile_share/configs/app_url.dart';
import 'package:qr_profile_share/model/contacts/contacts_model.dart';

class GetContactsRepository extends ChangeNotifier {
  Future<ContactModel> getAllContacts(String token) async {
    try {
      if (token.isEmpty) {
        throw Exception("Token is empty or null");
      }

      final url = Uri.parse(AppUrl.getAllContactsEndPoint);

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
        final responseData = contactModelFromJson(response.body);
        log("Get all contacts Success Response: $responseData");
        return responseData;
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(
          "get all contacts failed: ${errorData['message'] ?? 'Unknown error'}",
        );
      }
    } catch (e) {
      log("get all contacts Error: $e");
      throw Exception(e.toString());
    }
  }
}
