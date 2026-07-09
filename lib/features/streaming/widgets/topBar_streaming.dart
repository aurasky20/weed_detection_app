import 'package:flutter/material.dart';
import 'package:weedcheck/features/tutorial/streaming_tutorial.dart';

/// Top bar bergaya sama dengan TopBar di CameraPage, tanpa flash dan tanpa back opsional
class StreamingTopBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onFlashPressed;
  final bool isFlashOn;
  final VoidCallback onShowTutorial;
  final GlobalKey infoKey;
  final GlobalKey flashKey;

  const StreamingTopBar({
    super.key,
    required this.onBack,
    required this.onFlashPressed,
    required this.isFlashOn,
    required this.onShowTutorial,
    required this.infoKey,
    required this.flashKey,
  });

  @override
  Widget build(BuildContext context) {
    print("StreamingTopBar rebuild : $isFlashOn");
    return Container(
      color: Colors.black,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              StreamingTutorial.tutorial(
                key: infoKey,
                title: "Tutorial",
                description:
                    "Tap this button anytime to view the streaming tutorial again.",
                child: IconButton(
                  onPressed: onShowTutorial,
                  icon: const Icon(Icons.info_outline, color: Colors.white),
                ),
              ),

              const Expanded(
                child: Center(
                  child: Text(
                    'Streaming',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              StreamingTutorial.tutorial(
                key: flashKey,
                title: "Flash",
                description:
                    "Turn on the flashlight when the environment is dark to improve object visibility and detection quality.",
                child: IconButton(
                  onPressed: onFlashPressed,
                  icon: Icon(
                    isFlashOn ? Icons.flash_on : Icons.flash_off,
                    color: Colors.white,
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
