import 'dart:developer';

import 'package:flutter/material.dart';

import '../storage/local_storage.dart';

// Singleton Class
class SessionController {
  static final SessionController _session = SessionController._internal();
  factory SessionController() => _session;

  LocalStorage sharedPreferenceClass = LocalStorage();
  bool isLogin = false;

  SessionController._internal(); // Private constructor

  // Saving user data into SharedPreferences
  Future<void> saveUserInPreference(
    dynamic accessToken,
    dynamic refreshToken,
  ) async {
    await sharedPreferenceClass.setValue('accessToken', accessToken);
    await sharedPreferenceClass.setValue('refreshToken', refreshToken);
    await sharedPreferenceClass.setValue(
      'isLogin',
      'true',
    ); // Ensure it's stored as 'true'
    isLogin = true; // Update local variable
  }

  // Getting User Data from SharedPreferences
  Future<void> getUserFromPreference() async {
    try {
      var accessTokenString = await sharedPreferenceClass.readValue(
        'accessToken',
      );
      var refreshTokenString = await sharedPreferenceClass.readValue(
        'refreshToken',
      );
      var isLoginPref =
          await sharedPreferenceClass.readValue('isLogin') ?? 'false';

      log('accessToken: $accessTokenString');
      log('refreshToken: $refreshTokenString');
      log('isLogin: $isLoginPref');

      isLogin = isLoginPref == 'true'; // Convert to boolean
    } catch (e) {
      debugPrint("Error fetching user session: ${e.toString()}");
    }
  }

  Future<void> saveUserData(
    dynamic id,
    dynamic name,
    dynamic email,
    dynamic photo,
    dynamic position,
    dynamic location,
  ) async {
    await sharedPreferenceClass.setValue('id', id);
    await sharedPreferenceClass.setValue('name', name);
    await sharedPreferenceClass.setValue('email', email);
    await sharedPreferenceClass.setValue('photo', photo);
    await sharedPreferenceClass.setValue('position', position);
    await sharedPreferenceClass.setValue('location', location);
  }

  // Future<void> getUserData() async {
  //   try {
  //     var id = await sharedPreferenceClass.readValue('id');
  //     var name = await sharedPreferenceClass.readValue('name');
  //     var email = await sharedPreferenceClass.readValue('email');
  //     var photo = await sharedPreferenceClass.readValue('photo');
  //     var position = await sharedPreferenceClass.readValue('position');
  //     log('id: $id');
  //   } catch (e) {
  //     debugPrint("Error fetching user data: ${e.toString()}");
  //   }
  // }

  // Clear Session
  Future<void> clearSession() async {
    await sharedPreferenceClass.clearValue('accessToken');
    await sharedPreferenceClass.clearValue('refreshToken');
    await sharedPreferenceClass.clearValue('isLogin');
    isLogin = false;
  }
}
