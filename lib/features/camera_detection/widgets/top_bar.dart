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
                    "Tap this button whenever you need to view the camera tutorial again.",
                child: IconButton(
                  onPressed: onShowTutorial,
                  icon: const Icon(Icons.info_outline, color: Colors.white),
                ),
              ),

              const Spacer(),

              const Text(
                "Camera",
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
                title: "Flash",
                description:
                    "Turn on the flashlight when the environment is dark to help capture clearer images.",
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
