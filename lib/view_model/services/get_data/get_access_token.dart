import 'dart:developer';

import 'package:qr_profile_share/view_model/services/session_manager/session_controller.dart';

Future<String> getAccessToken() async {
  final token = await SessionController().sharedPreferenceClass.readValue(
    'accessToken',
  );
  log('accessToken: $token');
  return token;
}
