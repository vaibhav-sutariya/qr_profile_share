import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_profile_share/model/users/user_model.dart';
import 'package:qr_profile_share/repository/profile/update_user_data_repository.dart';
import 'package:qr_profile_share/view_model/services/get_data/get_access_token.dart';
import 'package:qr_profile_share/view_model/services/image_helper/image_helper.dart';

class UpdateProfileViewModel extends ChangeNotifier {
  UserModel? _userProfile;

  UserModel? get userProfile => _userProfile;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  File? get profileImage => _profileImage;
  bool _updateProfileLoading = false;
  bool get updateProfileLoading => _updateProfileLoading;
  String? _uploadedImageUrl;
  setUpdateProfileLoading(bool value) {
    _updateProfileLoading = value;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _profileImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  // Getter and setter for fullName
  String _fullName = '';
  String get fullName => _fullName;
  setfullName(String fullName) {
    _fullName = fullName;
    log('Full Name: $_fullName');
  }

  // Getter and setter for email
  String _email = '';
  String get email => _email;
  setEmail(String email) {
    _email = email;
    log('Email: $_email');
  }

  // Getter and setter for phone
  String _phone = '';
  String get phone => _phone;
  setPhone(String phone) {
    _phone = phone;
    log('Phone: $_phone');
  }

  String _location = '';
  String get location => _location;
  setLocation(String location) {
    _location = location;
    log('Location: $_location');
  }

  String _company = '';
  String get company => _company;
  setCompany(String company) {
    _company = company;
    log('Company: $_company');
  }

  String _role = '';
  String get role => _role;
  setRole(String role) {
    _role = role;
    log('Role: $_role');
  }

  String _website = '';
  String get website => _website;
  setWebsite(String website) {
    _website = website;
    log('Website: $_website');
  }

  void printData() {
    log('Full Name: $_fullName');
    log('Email: $_email');
    log('Phone: $_phone');
    log('Location: $_location');
    log('Company: $_company');
    log('Role: $_role');
    log('Website: $_website');
    log('Profile Image: ${_profileImage?.path}');
  }

  // Future<String?> _uploadImageToCloudinary(File image) async {
  //   try {
  //     final cloudinary = CloudinaryPublic(
  //       'di5cjvaap',
  //       'davuzp8d',
  //       cache: false,
  //     );
  //     final response = await cloudinary.uploadFile(
  //       CloudinaryFile.fromFile(image.path, folder: 'user_profiles'),
  //     );
  //     return response.secureUrl;
  //   } catch (e) {
  //     log('Cloudinary Upload Error: $e');
  //     return null;
  //   }
  // }

  Future<void> updateUserProfile(BuildContext context) async {
    try {
      setUpdateProfileLoading(true);
      // Upload image to Cloudinary if present
      if (_profileImage != null) {
        _uploadedImageUrl = await ImageHelper().uploadImageToCloudinary(
          _profileImage!,
        );
        log('Image URL: $_uploadedImageUrl');
      }

      notifyListeners();
      var data = {
        "name": _fullName,
        "email": _email,
        "phoneNumber": _phone,
        "location": _location,
        "company": _company,
        "userRole": _role,
        "website": _website,
      };

      if (_uploadedImageUrl != null) {
        data["photo"] = _uploadedImageUrl!;
        log('Image URL: $_uploadedImageUrl');
      }

      String token = await getAccessToken();

      final userProfile = await UpdateUserDataRepository()
          .updateUserProfile(token, data)
          .then((value) {
            Navigator.pop(context);
          });
      _userProfile = userProfile;

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
