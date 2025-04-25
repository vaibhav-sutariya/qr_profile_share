import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_profile_share/repository/profile/update_user_data_repository.dart';
import 'package:qr_profile_share/view_model/services/get_data/get_access_token.dart';

class ProfileSettingViewModel extends ChangeNotifier {
  bool autoUpdateContact = true;
  bool nfcSharing = true;
  String industry = 'Tech';
  bool privacyControlledQr = true;
  String qrEpiration = '24 hours';
  bool directMessage = true;

  void toggleAutoUpdateContact(bool value) {
    autoUpdateContact = value;
    notifyListeners();
  }

  void toggleNfcSharing(bool value) {
    nfcSharing = value;
    notifyListeners();
  }

  void setIndustry(String? value) {
    if (value != null) {
      industry = value;
      notifyListeners();
    }
  }

  void setPrivacyControlledQr(bool value) {
    privacyControlledQr = value;
    notifyListeners();
  }

  void setQrExpiration(String? value) {
    if (value != null) {
      qrEpiration = value;
      notifyListeners();
    }
  }

  void directMessageInteraction(bool value) {
    nfcSharing = value;
    notifyListeners();
  }

  void goToNotificationPreferences(BuildContext context) {
    // Example navigation
    Navigator.pushNamed(context, '/notificationPreferences');
  }

  int currentTabIndex = 0;

  void changeTab(int index) {
    currentTabIndex = index;
    notifyListeners();
  }

  String _github = '';
  String _instagram = '';
  String _linkedin = '';
  String _twitter = '';

  String get github => _github;
  String get instagram => _instagram;

  String get linkedin => _linkedin;
  String get twitter => _twitter;

  void updateGithub(String value) {
    _github = value;
  }

  void updateinstagram(String value) {
    _instagram = value;
  }

  void updateLinkedin(String value) {
    _linkedin = value;
  }

  void updateTwitter(String value) {
    _twitter = value;
  }

  Color _qrColor = Colors.blue;
  Color get qrColor => _qrColor;

  File? _qrLogo;
  File? get qrLogo => _qrLogo;

  void updateQrColor(Color color) {
    _qrColor = color;
    notifyListeners();
  }

  Future<void> pickQrLogo() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      _qrLogo = File(picked.path);
      notifyListeners();
    }
  }

  void clearQrLogo() {
    _qrLogo = null;
    notifyListeners();
  }

  bool _updateProfileLoading = false;
  bool get updateProfileLoading => _updateProfileLoading;
  setUpdateProfileLoading(bool value) {
    _updateProfileLoading = value;
    notifyListeners();
  }

  Future<void> updateSocialLinks(BuildContext context) async {
    try {
      setUpdateProfileLoading(true);

      notifyListeners();
      // Ensure you are using the correct variable names (_github, _instagram, etc.)
      final Map<String, dynamic> data = {
        'socialLinks': {
          'github': _github,
          'instagram': _instagram,
          'linkedIn': _linkedin, // Note the key should match the DB schema
          'twitter': _twitter,
        },
      };

      String token = await getAccessToken();

      final userProfile = await UpdateUserDataRepository()
          .updateUserProfile(token, data)
          .then((value) {
            Navigator.pop(context);
          });
      log('User profile updated: $userProfile');
      setUpdateProfileLoading(false);
    } catch (e) {
      setUpdateProfileLoading(false);
      print("Error fetching profile: $e");
    } finally {
      setUpdateProfileLoading(false);
      notifyListeners();
    }
  }
}
