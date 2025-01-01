import 'package:custom_barcode_scanner/bar_code_scanner.dart';
import 'package:custom_barcode_scanner/scanner_overlay.dart';
import 'package:flutter/material.dart';


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
      ],
    );
  }
}
