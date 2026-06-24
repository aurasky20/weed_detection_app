import 'package:flutter/material.dart';
import 'package:weedcheck/features/tutorial/streaming_tutorial.dart';

/// A widget that displays detection statistics (count and FPS)
class DetectionStatsDisplay extends StatelessWidget {
  const DetectionStatsDisplay({
    super.key,
    required this.detectionCount,
    required this.currentFps,
    required this.detectionKey,
    required this.fpsKey,
  });

  final int detectionCount;
  final double currentFps;
  final GlobalKey detectionKey;
  final GlobalKey fpsKey;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamingTutorial.tutorial(
            key: detectionKey,
            title: "Detection Count",
            description:
                "Shows the total number of weeds currently detected by the model.",
            child: Text(
              'DETECTIONS: $detectionCount',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    offset: Offset(0,0),
                    blurRadius: 8,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          StreamingTutorial.tutorial(
            key: fpsKey,
            title: "FPS",
            description:
                "Displays the processing speed in Frames Per Second. Higher FPS means smoother real-time detection.",
            child: Text(
              'FPS: ${currentFps.toStringAsFixed(1)}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    offset: Offset(0,0),
                    blurRadius: 8,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
