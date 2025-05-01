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
    } else if (response.statusCode == 400) {
      final errorResponse = jsonDecode(response.body);
      log("Error Response: $errorResponse");
      return {'error': true, 'message': errorResponse['message']};
    } else {
      log("Error Response: ${response.statusCode}");
      return {'error': true, 'message': 'Something went wrong'};
    }
  }
}
