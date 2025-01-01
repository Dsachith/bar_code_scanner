import 'package:bar_code_scanner/camera_scanner.dart';
import 'package:flutter/material.dart';

class BarcodeScanner extends StatefulWidget {
  final Function(String) onScan;
  final Widget? overlay;
  final bool showFlashlightButton;

  const BarcodeScanner({
    super.key,
    required this.onScan,
    this.overlay,
    this.showFlashlightButton = true,
  });

  @override
  _BarcodeScannerState createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
  bool _isFlashlightOn = false;

  void _toggleFlashlight() {
    setState(() {
      _isFlashlightOn = !_isFlashlightOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CameraScanner(
          onCodeScanned: widget.onScan,
         
        ),
        if (widget.overlay != null) widget.overlay!,
        if (widget.showFlashlightButton) _buildFlashlightButton(),
        _buildScanningArea(), 
      ],
    );
  }

  Widget _buildFlashlightButton() {
    return Positioned(
      top: 50.0,
      right: 20.0,
      child: IconButton(
        icon: Icon(
          _isFlashlightOn ? Icons.flash_off : Icons.flash_on,
          color: Colors.white,
        ),
        onPressed: _toggleFlashlight,
      ),
    );
  }

  Widget _buildScanningArea() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.25,
      left: 20.0,
      right: 20.0,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30),
            Text(
              'Scan Here',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
