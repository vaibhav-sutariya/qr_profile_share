import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:qr_profile_share/configs/app_url.dart';

class GetQrDataRepository with ChangeNotifier {
  Future<Map<String, dynamic>> getQrDataLink(dynamic data) async {
    final response = await http.post(
      Uri.parse(AppUrl.getQrDataEndPoint),
      headers: {
        "Content-Type": "application/json", // 👈 add this
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      log("Get Qr data Response: $responseData");
      return responseData;
    } else if (response.statusCode == 400) {
      final responseData = jsonDecode(response.body);
      log("Error Response: $responseData");
      return {'error': true, 'message': responseData['message']};
    } else if (response.statusCode == 401) {
      final responseData = jsonDecode(response.body);
      log("Error Response: $responseData");
      return {'error': true, 'message': responseData['message']};
    } else if (response.statusCode == 500) {
      final responseData = jsonDecode(response.body);
      log("Error Response: $responseData");
      return {'error': true, 'message': responseData['message']};
    } else {
      log("Error Response: ${response.statusCode}");
      return {'error': true, 'message': 'Something went wrong'};
    }
  }
}
