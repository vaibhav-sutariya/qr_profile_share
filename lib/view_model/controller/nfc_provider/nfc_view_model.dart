import 'package:flutter/foundation.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCViewModel extends ChangeNotifier {
  String _nfcData = 'Tap an NFC tag';
  String get nfcData => _nfcData;

  Future<void> startNFC() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (!isAvailable) {
      _nfcData = "NFC is not available on this device";
      notifyListeners();
      return;
    }

    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        _nfcData = tag.data.toString();
        notifyListeners();
        NfcManager.instance.stopSession();
      },
    );
  }
}
