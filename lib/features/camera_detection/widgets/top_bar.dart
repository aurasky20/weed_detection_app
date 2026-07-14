import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:weedcheck/features/tutorial/camera_tutorial.dart';
import '../controllers/camera_controller.dart';

class TopBar extends StatelessWidget {
  final VoidCallback onFlashToggle;
  final VoidCallback onShowTutorial;
  final CameraControllerX controller;
  final GlobalKey infoKey;
  final GlobalKey flashKey;

  const TopBar({
    super.key,
    required this.onFlashToggle,
    required this.onShowTutorial,
    required this.controller,
    required this.infoKey,
    required this.flashKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              /// INFO
              CameraTutorial.tutorial(
                key: infoKey,
                title: "Tutorial",
                description:
                    "Tap tombol ini kapan pun Anda ingin melihat tutorial kamera lagi.",
                child: IconButton(
                  onPressed: onShowTutorial,
                  icon: const Icon(Icons.info_outline, color: Colors.white),
                ),
              ),

              const Spacer(),

              const Text(
                "Kamera",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(),

              /// FLASH
              CameraTutorial.tutorial(
                key: flashKey,
                title: "Senter",
                description:
                    "Nyalakan atau matikan senter untuk membantu pencahayaan saat mendeteksi gulma.",
                child: IconButton(
                  onPressed: onFlashToggle,
                  icon: Icon(
                    controller.flashMode == FlashMode.torch
                        ? Icons.flash_on
                        : Icons.flash_off,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
