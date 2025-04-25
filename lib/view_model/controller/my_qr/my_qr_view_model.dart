import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

class MyQrViewModel extends ChangeNotifier {
  bool dynamicQr = true;
  bool nfcSharing = true;

  void toggleDynamicQr(bool value) {
    dynamicQr = value;
    notifyListeners();
  }

  void toggleNFCSharing(bool value) {
    nfcSharing = value;
    notifyListeners();
  }

  GlobalKey qrKey = GlobalKey();

  Future<void> shareQr() async {
    try {
      RenderRepaintBoundary boundary =
          qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final pngBytes = byteData?.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file =
          await File('${tempDir.path}/qr_${const Uuid().v4()}.png').create();
      await file.writeAsBytes(pngBytes!);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Check out my QR!, scan it to view and save my profile.',
        subject: 'QR Profile Share',
        sharePositionOrigin: Rect.zero,
      );
      log('Shared QR code: ${file.path}');
    } catch (e) {
      debugPrint('Error sharing QR: $e');
    }
  }

  Future<void> saveQr() async {
    try {
      RenderRepaintBoundary boundary =
          qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final pngBytes = byteData?.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file =
          await File('${tempDir.path}/qr_${const Uuid().v4()}.png').create();
      await file.writeAsBytes(pngBytes!);

      final result = await SaverGallery.saveImage(
        pngBytes,
        fileName: 'qr_${const Uuid().v4()}.png',
        skipIfExists: false,
      );
      log('Saved to gallery: $result');
    } catch (e) {
      log('Error saving QR: $e');
    }
  }
}
