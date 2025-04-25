// ScanScreen.dart - View Layer
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:qr_profile_share/configs/components/custom_app_bar.dart';
import 'package:qr_profile_share/configs/responsive.dart';
import 'package:qr_profile_share/view_model/controller/scan/scan_view_model.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    controller?.pauseCamera();
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController ctrl) {
    controller = ctrl;
    final scanViewModel = Provider.of<ScanViewModel>(context, listen: false);

    ctrl.scannedDataStream.listen((scanData) {
      if (scanData.code == null) return;
      scanViewModel.processCameraQrCode(context, scanData.code ?? '');
      controller?.pauseCamera();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: 'Scan QR Code'),
      body: Consumer<ScanViewModel>(
        builder: (context, viewModel, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // QR Scanner View
                  SizedBox(
                    height: getScreenHeight(context) * 0.4,
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                        borderColor: Colors.green,
                        borderRadius: 10,
                        borderLength: 30,
                        borderWidth: 10,
                        cutOutSize: 250,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Gallery Button
                  Center(
                    child:
                        viewModel.isProcessing
                            ? const CircularProgressIndicator()
                            : ElevatedButton.icon(
                              onPressed:
                                  () => viewModel.pickImageAndScan(context),
                              icon: const Icon(Icons.image),
                              label: const Text('Scan from Gallery'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                              ),
                            ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
