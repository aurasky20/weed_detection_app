import 'package:flutter/material.dart';
import 'package:weedcheck/features/tutorial/streaming_tutorial.dart';
import '../controllers/camera_inference_controller.dart';
import 'control_button.dart';

/// A widget containing camera control buttons
class CameraControls extends StatelessWidget {
  const CameraControls({
    super.key,
    required this.currentZoomLevel,
    required this.isFrontCamera,
    required this.activeSlider,
    required this.onZoomChanged,
    required this.onSliderToggled,
    required this.onCameraFlipped,
    required this.isLandscape,
    required this.maxItemKey,
    // required this.confidenceKey,
    // required this.iouKey,
    required this.flipKey,
  });

  final double currentZoomLevel;
  final bool isFrontCamera;
  final SliderType activeSlider;
  final ValueChanged<double> onZoomChanged;
  final ValueChanged<SliderType> onSliderToggled;
  final VoidCallback onCameraFlipped;
  final bool isLandscape;
  final GlobalKey maxItemKey;
  // final GlobalKey confidenceKey;
  // final GlobalKey iouKey;
  final GlobalKey flipKey;

  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.of(context).viewPadding;

    return Stack(
      children: [
        Positioned(
          bottom: (isLandscape ? 16 : 32) + viewPadding.bottom,
          right: (isLandscape ? 8 : 16) + (isLandscape ? viewPadding.right : 0),
          child: Column(
            children: [
              StreamingTutorial.tutorial(
                key: maxItemKey,
                title: "Maksimum Gulma Terdeteksi",
                description:
                    "Mengatur jumlah maksimum gulma yang ditampilkan pada layar. Jika Anda tidak dapat melihat label, coba kurangi angka ini.",
                child: ControlButton.icon(
                  icon: Icons.layers,
                  onPressed: () => onSliderToggled(SliderType.numItems),
                ),
              ),
              // SizedBox(height: isLandscape ? 8 : 12),
              // StreamingTutorial.tutorial(
              //   key: confidenceKey,
              //   title: "Confidence Threshold",
              //   description:
              //       "Adjust the confidence threshold to filter out low-confidence detections. Higher values show fewer but more reliable detections.",
              //   child: ControlButton.icon(
              //     icon: Icons.adjust,
              //     onPressed: () => onSliderToggled(SliderType.confidence),
              //   ),
              // ),
              // SizedBox(height: isLandscape ? 8 : 12),
              // StreamingTutorial.tutorial(
              //   key: iouKey,
              //   title: "IoU Threshold",
              //   description:
              //       "Controls how overlapping bounding boxes are filtered. When the threshold is set low, fewer overlapping boxes are displayed. When set high, more overlapping boxes may be shown.",
              //   child: ControlButton.asset(
              //     assetPath: 'assets/iou.png',
              //     onPressed: () => onSliderToggled(SliderType.iou),
              //   ),
              // ),
              SizedBox(height: isLandscape ? 16 : 50),
            ],
          ),
        ),

        StreamingTutorial.tutorial(
          key: flipKey,
          title: "Flip Kamera",
          description:
              "Gunakan tombol ini untuk beralih antara kamera depan dan belakang. Kamera belakang biasanya lebih baik untuk mendeteksi gulma.",
          child: Positioned(
            bottom:
                MediaQuery.of(context).padding.top +
                (isLandscape ? 16 : 50) +
                viewPadding.bottom,
            left:
                (isLandscape ? 32 : 16) + (isLandscape ? viewPadding.left : 0),
            child: CircleAvatar(
              radius: isLandscape ? 20 : 24,
              backgroundColor: Colors.black.withValues(alpha: 0.5),
              child: IconButton(
                icon: const Icon(Icons.flip_camera_ios, color: Colors.white),
                onPressed: onCameraFlipped,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
