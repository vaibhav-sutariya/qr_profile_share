import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:qr_profile_share/configs/utils/utils.dart';
import 'package:qr_profile_share/model/scan/qr_model.dart';
import 'package:qr_profile_share/repository/scan/add_scan_profile_repository.dart';
import 'package:qr_profile_share/view/scan/widgets/scan_result_dialog.dart';
import 'package:qr_profile_share/view_model/services/get_data/get_access_token.dart';

class ScanViewModel extends ChangeNotifier {
  QrModel? _qrModel;

  QrModel? get qrData => _qrModel;

  void setQrData(BuildContext context, String data) async {
    _qrModel = QrModel(scannedData: data);

    try {
      final Uri uri = Uri.parse(data);
      final String? encodedLink = uri.queryParameters['link'];

      if (encodedLink == null) {
        throw Exception("Invalid QR code data. 'link' parameter missing.");
      }

      final String decodedLink = Uri.decodeFull(encodedLink);

      final response = await http.get(Uri.parse(decodedLink));

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);

        final Map<String, dynamic> userData = result['data']['user'];

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ScanResultDialog(
              data: userData,
              onClose: () {
                Navigator.pop(context);
              },
            );
          },
        );
      } else {
        throw Exception("Failed to fetch profile data");
      }
    } catch (e) {
      print("Error parsing QR code or fetching user data: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }

    notifyListeners();
  }

  void clearData() {
    _qrModel = null;
    notifyListeners();
  }

  bool _isProcessing = false;
  final ImagePicker _picker = ImagePicker();

  bool get isProcessing => _isProcessing;

  // Original method for camera QR scanning
  void processCameraQrCode(BuildContext context, String qrData) {
    log('Scanned Data from Camera: $qrData');
    setQrData(context, qrData);
  }

  // Method to handle scanning from gallery
  Future<void> pickImageAndScan(BuildContext context) async {
    try {
      _setProcessing(true);

      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (pickedFile == null) {
        _setProcessing(false);
        return;
      }

      final File imageFile = File(pickedFile.path);
      await _scanQRFromImage(context, imageFile);
    } catch (e) {
      _setProcessing(false);
      _showErrorDialog(context, "Failed to pick image: $e");
    }
  }

  // Private method to scan QR from image file
  Future<void> _scanQRFromImage(BuildContext context, File file) async {
    try {
      // Create an InputImage from the file
      final InputImage inputImage = InputImage.fromFilePath(file.path);

      // Create a barcode scanner
      final BarcodeScanner barcodeScanner = BarcodeScanner();

      // Process the image
      final barcodes = await barcodeScanner.processImage(inputImage);

      // Close the detector when done
      barcodeScanner.close();

      _setProcessing(false);

      if (barcodes.isNotEmpty) {
        // Get the first barcode found
        final String? qrData = barcodes.first.rawValue;

        if (qrData != null && qrData.isNotEmpty) {
          log('QR Data from Image: $qrData');
          setQrData(context, qrData);
        } else {
          _showErrorDialog(context, "No QR code found in the image");
        }
      } else {
        _showErrorDialog(context, "No QR code found in the image");
      }
    } catch (e) {
      _setProcessing(false);
      _showErrorDialog(context, "Error scanning QR code from image: $e");
    }
  }

  // Update processing state and notify listeners
  void _setProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  // Show error dialog helper
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  bool _addUserProfileLoading = false;
  bool get adduserProfileLoading => _addUserProfileLoading;

  addUserProfileLoading(bool value) {
    _addUserProfileLoading = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> addContact(
    String id,
    BuildContext context,
  ) async {
    try {
      addUserProfileLoading(true);
      final data = {"userId": id};
      log("User ID: $data");

      final token = await getAccessToken();

      final response = await AddScanProfileRepository().addContact(
        jsonEncode(data),
        token,
      );

      log("Response: $response");

      if (response['status'] == 'success') {
        final message = response['message'] ?? 'successfully added';
        Utils.flushBarSuccessMessage(message, context);
        return response;
      }

      if (response['error'] == true) {
        final message = response['message'] ?? 'Something went wrong';
        Utils.flushBarErrorMessage(message, context); // show actual message
        return response;
      }

      Utils.flushBarErrorMessage('Unexpected error occurred', context);
      return {"success": false};
    } catch (e) {
      log("profile add Error: $e");

      try {
        final decodedError = jsonDecode(
          e.toString().replaceFirst('Exception: profile add failed: ', ''),
        );
        final message = decodedError['message'] ?? 'Something went wrong';
        Utils.flushBarErrorMessage(message, context);
      } catch (_) {
        // Fallback error display
        Utils.flushBarErrorMessage('Something went wrong', context);
      }

      return {"success": false, "message": e.toString()};
    } finally {
      addUserProfileLoading(false);
    }
  }
}
