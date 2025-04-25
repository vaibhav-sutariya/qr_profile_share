import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:qr_profile_share/model/profile/follow_up_model.dart';
import 'package:qr_profile_share/model/profile/recent_activity_model.dart';
import 'package:qr_profile_share/model/users/user_model.dart';
import 'package:qr_profile_share/repository/profile/get_user_data_repository.dart';
import 'package:qr_profile_share/view_model/services/get_data/get_access_token.dart';
import 'package:qr_profile_share/view_model/services/session_manager/session_controller.dart';

enum ProfileMode { fullProfile, eventMode, stealthMode }

class UserProfileViewModel extends ChangeNotifier {
  // Singleton pattern to ensure only one instance of the class exists
  UserProfileViewModel._privateConstructor() {
    // Fetch data on initialization
    getUserProfile();
  }

  static final UserProfileViewModel _instance =
      UserProfileViewModel._privateConstructor();

  factory UserProfileViewModel() {
    return _instance;
  }
  UserModel? _userProfile;

  UserModel? get userProfile => _userProfile;

  bool _getuserProfileLoading = false;
  bool get getuserProfileLoading => _getuserProfileLoading;

  setgetuserProfileLoading(bool value) {
    _getuserProfileLoading = value;
    notifyListeners();
  }

  ProfileMode _selectedMode = ProfileMode.fullProfile;

  ProfileMode get selectedMode => _selectedMode;

  void updateMode(ProfileMode mode) {
    _selectedMode = mode;
    notifyListeners();
  }

  final List<FollowUp> _followUps = [
    FollowUp(
      title: 'Follow up with Sarah Wilson',
      due: 'Due today',
      icon: Icons.chat_bubble_outline,
    ),
    FollowUp(
      title: 'Contact Alex from TechConf',
      due: 'Due tomorrow',
      icon: Feather.message_circle,
    ),
  ];

  List<FollowUp> get followUps => _followUps;

  final List<RecentActivity> _recentActivity = [
    RecentActivity(
      title: 'Connected With Sarah Wilson',
      due: '2h ago',
      icon: Feather.users,
    ),
    RecentActivity(
      title: 'Attended Tech Conference',
      due: '1d ago',
      icon: Feather.calendar,
    ),
    RecentActivity(
      title: 'Updated QR Code',
      due: '2d ago',
      icon: Icons.qr_code_2,
    ),
  ];

  List<RecentActivity> get recentActivity => _recentActivity;

  Future<void> getUserProfile() async {
    SessionController sessionController = SessionController();
    try {
      setgetuserProfileLoading(true);
      notifyListeners();

      // Replace with actual user ID and token
      String token = await getAccessToken();

      final userProfile = await GetUserDataRepository().getUserProfile(token);
      _userProfile = userProfile;

      setgetuserProfileLoading(false);
      final data = userProfile.data!.user;
      await sessionController
          .saveUserData(
            data!.sId,
            data.name,
            data.email,
            data.photo,
            data.userRole,
            data.location,
          )
          .then((value) {
            log("User data saved successfully in session controller");
          });
    } catch (e) {
      setgetuserProfileLoading(false);
      print("Error fetching profile: $e");
    } finally {
      setgetuserProfileLoading(false);
      notifyListeners();
    }
  }
}
