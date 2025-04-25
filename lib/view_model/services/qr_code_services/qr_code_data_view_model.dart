import 'package:flutter/foundation.dart';
import 'package:qr_profile_share/view_model/services/storage/local_storage.dart';

class QrCodeDataViewModel with ChangeNotifier {
  // Singleton pattern to ensure only one instance of the class exists
  QrCodeDataViewModel._privateConstructor() {
    // Fetch data on initialization
    getData();
  }

  static final QrCodeDataViewModel _instance =
      QrCodeDataViewModel._privateConstructor();

  factory QrCodeDataViewModel() {
    return _instance;
  }

  String _id = "Please update the profile";
  String get id => _id;

  setId(String id) {
    _id = id;
    notifyListeners();
  }

  String _name = "Please update the profile";
  String get name => _name;
  setName(String name) {
    _name = name;
    notifyListeners();
  }

  String _email = "Please update the profile";
  String get email => _email;
  setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  String _photo = "Please update the profile";
  String get photo => _photo;
  setPhoto(String photo) {
    _photo = photo;
    notifyListeners();
  }

  String _position = "Please update the profile";
  String get position => _position;
  setPosition(String position) {
    _position = position;
    notifyListeners();
  }

  String _location = "Please update the profile";
  String get location => _location;
  setLocation(String location) {
    _location = location;
    notifyListeners();
  }

  String _qrCodeData = ''; // Default QR code data

  String get qrCodeData => _qrCodeData;

  void clearQrCodeData() {
    _qrCodeData = ''; // Reset to default or empty state
    notifyListeners();
  }

  String getQrCodeData() {
    return _qrCodeData.isNotEmpty
        ? _qrCodeData.toString()
        : "No QR code data available";
  }

  Future<void> getData() async {
    LocalStorage localStorage = LocalStorage();
    localStorage.readValue('id').then((value) {
      setId(value);
    });
    localStorage.readValue('name').then((value) {
      setName(value);
    });
    localStorage.readValue('email').then((value) {
      setEmail(value);
    });
    localStorage.readValue('photo').then((value) {
      setPhoto(value);
    });
    localStorage.readValue('position').then((value) {
      setPosition(value);
    });
    localStorage.readValue('location').then((value) {
      setLocation(value);
    });
  }
}
