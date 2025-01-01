import 'package:flutter/material.dart';

class ScannerOverlay extends StatelessWidget {
  final double boxWidth;
  final double boxHeight;
  final Color boxBorderColor;
  final double borderRadius;

  const ScannerOverlay({
    super.key,
    this.boxWidth = 200,
    this.boxHeight = 200,
    this.boxBorderColor = Colors.green,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
       
        Container(
          color: Colors.black.withOpacity(0.5),
        ),
        Center(
          child: Container(
            width: boxWidth,
            height: boxHeight,
            decoration: BoxDecoration(
              border: Border.all(color: boxBorderColor, width: 2),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Center(
                child: _buildScanningAnimation(), 
              ),
            ),
          ),
        ),
      ],
    );
  }

 
  Widget _buildScanningAnimation() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      width: 20,
      height: 20,
      decoration: const BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
      ),
      margin: EdgeInsets.only(top: 10),
      child: _buildScanningCircle(),
    );
  }

  Widget _buildScanningCircle() {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: Icon(
        Icons.arrow_drop_down,
        key: ValueKey<int>(DateTime.now().millisecondsSinceEpoch),
        size: 30,
        color: Colors.white,
      ),
    );
  }
}
