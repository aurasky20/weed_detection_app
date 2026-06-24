import 'package:flutter/material.dart';

/// Top bar bergaya sama dengan TopBar di CameraPage, tanpa flash dan tanpa back opsional
class StreamingTopBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onFlashPressed;
  final bool isFlashOn;

  const StreamingTopBar({
    super.key,
    required this.onBack,
    required this.onFlashPressed,
    required this.isFlashOn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              const SizedBox(width: 48),

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

              IconButton(
                onPressed: onFlashPressed,
                icon: Icon(
                  isFlashOn
                      ? Icons.flash_on
                      : Icons.flash_off,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}