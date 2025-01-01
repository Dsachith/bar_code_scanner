import 'package:custom_barcode_scanner/bar_code_scanner.dart';
import 'package:custom_barcode_scanner/scanner_overlay.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar:  AppBar(title: Text('Barcode & QR Code Scanner')),
        body: const BarcodeScannerExample(),
      ),
    );
  }
}

class BarcodeScannerExample extends StatelessWidget {
  const BarcodeScannerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarcodeScanner(
      onScan: (String result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Scanned: $result')),
        );
      },
      overlay: const ScannerOverlay(),
    );
  }
}
