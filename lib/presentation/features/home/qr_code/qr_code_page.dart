import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  String? scannedCode;
  bool isScanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: MobileScannerController(
              facing: CameraFacing.back,
              torchEnabled: false,
            ),
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              final Barcode barcode = barcodes.first;
              if (!isScanned && barcode.rawValue != null) {
                setState(() {
                  scannedCode = barcode.rawValue;
                  isScanned = true;
                });
              }
            },
          ),
          if (!isScanned)
            Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 3),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          if (scannedCode != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black87,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
                child: Text(
                  'QR: $scannedCode',
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}