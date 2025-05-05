import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_profile_share/repository/qr_data/get_qr_data_repository.dart';
import 'package:qr_profile_share/view_model/services/get_data/get_user_id.dart';
import 'package:qr_profile_share/view_model/services/storage/local_storage.dart';

class QrCodeDataViewModel with ChangeNotifier {
  // Singleton pattern to ensure only one instance of the class exists
  QrCodeDataViewModel._privateConstructor() {
    // Fetch data on initialization
    getData().then((_) {
      // After fetching data, you can call getQrDataLink() if needed
      getQrDataLink();
    });
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

  String _dynamicLink = ''; // Default dynamic link
  String get dynamicLink => _dynamicLink;

  setDynamicLink(String dynamicLink) {
    _dynamicLink = dynamicLink;
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
      setId(value ?? "Please update the profile");
    });
    localStorage.readValue('name').then((value) {
      setName(value ?? "Please update the profile");
    });
  }

  bool _getQrDataLoading = false;
  bool get getQrDataLoading => _getQrDataLoading;

  getQRDataLoading(bool value) {
    _getQrDataLoading = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> getQrDataLink() async {
    try {
      getQRDataLoading(true);
      String id =
          await getUserId(); // Assuming this function fetches the user ID
      var data = {'id': id};

      log("qr id: $data"); // ✅ Debugging Step
      final response = await GetQrDataRepository().getQrDataLink(data);
      log("qr data response: $response"); // ✅ Debugging Step
      if (response['status'] == 'success') {
        log(
          'Dynamic link generated successfully: $response',
        ); // ✅ Debugging Step
        setDynamicLink(response['link']);
        log('Dynamic link: ${response['link']}'); // ✅ Debugging Step
        log('dynamic link: $dynamicLink'); // ✅ Debugging Step
      } else {
        log(
          'Failed to get qr data: ${response['message']}',
        ); // ✅ Debugging Step
        return response;
      }

      getQRDataLoading(false);

      return response;
    } catch (e) {
      log("contact add Error: $e"); // Add this log
      getQRDataLoading(false);
      return {"failed": false, "message": e.toString()};
    } finally {
      getQRDataLoading(false);
    }
  }
}
