import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:qr_profile_share/configs/app_url.dart';

class AddNewContactRepository extends ChangeNotifier {
  Future<Map<String, dynamic>> addNewContact(dynamic data, String token) async {
    final response = await post(
      Uri.parse(AppUrl.addNewContactEndPoint),
      headers: {
        "Content-Type": "application/json", // 👈 add this
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      log("Add contact Response: $responseData");
      return responseData;
    } else {
      throw Exception("add contact failed: ${response.body}");
    }
  }
}
