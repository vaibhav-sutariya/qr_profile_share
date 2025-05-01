import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_profile_share/configs/utils/utils.dart';
import 'package:qr_profile_share/repository/contacts/add_new_contact_repository.dart';
import 'package:qr_profile_share/view_model/services/get_data/get_access_token.dart';
import 'package:qr_profile_share/view_model/services/image_helper/image_helper.dart';

class AddContactViewModel extends ChangeNotifier {
  // Add your properties and methods here for managing the state of adding a contact

  File? _profileImage;
  String _name = '';
  String _email = '';
  String _phoneNumber = '';
  String _location = '';
  String _company = '';
  String _role = '';
  String _website = '';
  String? _uploadedImageUrl;

  File? get profileImage => _profileImage;
  String get name => _name;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get location => _location;
  String get company => _company;
  String get role => _role;
  String get website => _website;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _profileImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void setLocation(String value) {
    _location = value;
    notifyListeners();
  }

  void setCompany(String value) {
    _company = value;
    notifyListeners();
  }

  void setRole(String value) {
    _role = value;
    notifyListeners();
  }

  void setWebsite(String value) {
    _website = value;
    notifyListeners();
  }

  void data() {
    var data = {
      'name': _name,
      'email': _email,
      'phoneNumber': _phoneNumber,
      'location': _location,
      'company': _company,
      'userRole': _role,
      'website': _website,
    };
    log('Data: $data');
  }

  bool _addNewContactLoading = false;
  bool get addNewContactLoading => _addNewContactLoading;

  getAddNewContactLoading(bool value) {
    _addNewContactLoading = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> addNewContact(BuildContext context) async {
    try {
      getAddNewContactLoading(true);
      // Upload image to Cloudinary if present
      _uploadedImageUrl = await ImageHelper().uploadImageToCloudinary(
        _profileImage!,
      );
      log('Image URL: $_uploadedImageUrl');
      var data = {
        'name': _name,
        'email': _email,
        'phoneNumber': _phoneNumber,
        'location': _location,
        'company': _company,
        'userRole': _role,
        'website': _website,
      };
      if (_uploadedImageUrl != null) {
        data["photo"] = _uploadedImageUrl!;
        log('Image URL: $_uploadedImageUrl');
      }
      log("Contact data: $data"); // ✅ Debugging Step
      final token = await getAccessToken(); // Get the token from storage
      final response = await AddNewContactRepository().addNewContact(
        data,
        token,
      );
      if (response['status'] == 'success') {
        log('Contact added successfully: $response'); // ✅ Debugging Step
        Utils.flushBarSuccessMessage(response['message'], context);
      } else {
        log(
          'Failed to add contact: ${response['message']}',
        ); // ✅ Debugging Step
        Utils.flushBarErrorMessage(response['message'], context);
        return response;
      }

      getAddNewContactLoading(false);

      return response;
    } catch (e) {
      log("contact add Error: $e"); // Add this log
      getAddNewContactLoading(false);
      return {"failed": false, "message": e.toString()};
    } finally {
      getAddNewContactLoading(false);
    }
  }

  void clearFields() {
    _profileImage = null;
    _name = '';
    _email = '';
    _phoneNumber = '';
    notifyListeners();
  }
}
