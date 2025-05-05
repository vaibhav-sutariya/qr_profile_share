import 'dart:developer';

import 'package:qr_profile_share/view_model/services/session_manager/session_controller.dart';

Future<String> getUserId() async {
  final id = await SessionController().sharedPreferenceClass.readValue('id');
  log('id session: $id');
  return id;
}
