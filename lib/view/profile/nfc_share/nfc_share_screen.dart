import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/components/custom_app_bar.dart';
import 'package:qr_profile_share/view_model/controller/nfc_provider/nfc_view_model.dart';

class NfcShareScreen extends StatelessWidget {
  const NfcShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nfcViewModel = Provider.of<NFCViewModel>(context);

    return Scaffold(
      appBar: CustomAppBar(text: "NFC Share", isBackButtonVisible: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              nfcViewModel.nfcData,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: nfcViewModel.startNFC,
              child: const Text("Scan NFC Tag"),
            ),
          ],
        ),
      ),
    );
  }
}
