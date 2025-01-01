import 'package:flutter/material.dart';
import 'package:bar_code_scanner/bar_code_scanner.dart';
import 'package:bar_code_scanner/scanner_overlay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Barcode & QR Code Scanner')),
        body: const BarcodeScannerExample(),
      ),
    );
  }
}

class BarcodeScannerExample extends StatefulWidget {
  const BarcodeScannerExample({super.key});

  @override
  _BarcodeScannerExampleState createState() => _BarcodeScannerExampleState();
}

class _BarcodeScannerExampleState extends State<BarcodeScannerExample> {
  String scannedCode = '';
  bool isFlashlightOn = false;
  bool isFrontCamera = false;

  void toggleFlashlight() {
    setState(() {
      isFlashlightOn = !isFlashlightOn;
    });
  }

  void toggleCamera() {
    setState(() {
      isFrontCamera = !isFrontCamera;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       
        if (scannedCode.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Scanned Code: $scannedCode',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        
        
        Expanded(
          child: BarcodeScanner(
            onScan: (String result) {
              setState(() {
                scannedCode = result;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Scanned: $result')),
              );
            },
            overlay: const ScannerOverlay(),

          ),
        ),
        
       
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                isFlashlightOn ? Icons.flash_on : Icons.flash_off,
                color: Colors.yellow,
              ),
              onPressed: toggleFlashlight,
              tooltip: 'Toggle Flashlight',
            ),
            IconButton(
              icon: Icon(
                isFrontCamera ? Icons.camera_front : Icons.camera_rear,
                color: Colors.blue,
              ),
              onPressed: toggleCamera,
              tooltip: 'Switch Camera',
            ),
          ],
        ),
      ],
    );
  }
}
