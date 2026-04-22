import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../controllers/camera_controller.dart';

class TopBar extends StatelessWidget {
  final VoidCallback onBack;
  final CameraControllerX controller;
  final VoidCallback onFlashToggle;

  const TopBar({
    required this.onBack,
    required this.controller,
    required this.onFlashToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Positioned(
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: onBack,
              ),
            ),
            Center(
              child: Text(
                "Camera",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Positioned(
              right: 16,
              child: IconButton(
                icon: Icon(
                  controller.flashMode == FlashMode.torch
                      ? Icons.flash_on
                      : Icons.flash_off,
                  color: Colors.white,
                ),
                onPressed: onFlashToggle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}