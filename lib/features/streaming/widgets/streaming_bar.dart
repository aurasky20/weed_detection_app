import 'package:flutter/material.dart';
import 'package:weedcheck/features/camera_detection/widgets/bottom_controls.dart';
/// Bottom bar hanya berisi mode switcher, tanpa tombol capture/galeri/flip

class StreamingBottomBar extends StatelessWidget {
  final ValueChanged<CameraMode> onModeChanged;

  const StreamingBottomBar({required this.onModeChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ModeTab(
                label: 'Kamera',
                isActive: false,
                onTap: () => onModeChanged(CameraMode.camera),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '|',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 16,
                  ),
                ),
              ),
              _ModeTab(
                label: 'Streaming',
                isActive: true,
                onTap: () => onModeChanged(CameraMode.streaming),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModeTab extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ModeTab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.white.withOpacity(0.4),
          fontSize: 15,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}