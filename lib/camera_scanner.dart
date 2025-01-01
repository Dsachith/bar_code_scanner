import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CameraScanner extends StatefulWidget {
  final Function(String) onCodeScanned;
  final bool showFlashButton;
  final bool enableFrontCamera;
  final Widget? overlay;

  const CameraScanner({
    super.key,
    required this.onCodeScanned,
    this.showFlashButton = true,
    this.enableFrontCamera = false,
    this.overlay,
  });

  @override
  _CameraScannerState createState() => _CameraScannerState();
}

class _CameraScannerState extends State<CameraScanner> {
  bool _isFlashlightOn = false;
  bool _isFrontCamera = false;

  MobileScannerController? controller;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
    if (widget.enableFrontCamera) {
      _isFrontCamera = true;
    }
  }

  void _toggleFlashlight() {
    setState(() {
      _isFlashlightOn = !_isFlashlightOn;
    });
    controller?.toggleTorch();
  }

  void _toggleCamera() {
    setState(() {
      _isFrontCamera = !_isFrontCamera;
    });
    controller?.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          controller: controller,
          onDetect: (capture) {
            final barcode = capture.barcodes.first;
            if (barcode.rawValue != null) {
              widget.onCodeScanned(barcode.rawValue!);
            }
          },
        ),
        if (widget.overlay != null) widget.overlay!,
        if (widget.showFlashButton) _buildFlashlightButton(),
        _buildCameraSwitchButton(),
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

  Widget _buildCameraSwitchButton() {
    return Positioned(
      top: 100.0,
      right: 20.0,
      child: IconButton(
        icon: Icon(
          _isFrontCamera ? Icons.camera_rear : Icons.camera_front,
          color: Colors.white,
        ),
        onPressed: _toggleCamera,
      ),
    );
  }
}
