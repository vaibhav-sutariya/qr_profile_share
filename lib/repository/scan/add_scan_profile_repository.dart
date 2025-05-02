import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:qr_profile_share/configs/app_url.dart';

class AddScanProfileRepository extends ChangeNotifier {
  Future<Map<String, dynamic>> addContact(dynamic data, String token) async {
    final response = await post(
      Uri.parse(AppUrl.scanAndCreateContactEndPoint),
      headers: {
        "Content-Type": "application/json", // 👈 add this
        'Authorization': 'Bearer $token',
      },
      body: data,
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      log("Add profile Response: $responseData");
      return responseData;
    } else {
      final responseData = jsonDecode(response.body);
      log("Error Response: $responseData");
      return {'error': true, 'message': responseData['message']};
    }
  }
}
