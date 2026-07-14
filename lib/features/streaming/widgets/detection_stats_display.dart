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
            title: "Jumlah Deteksi",
            description:
                "Menampilkan jumlah gulma yang terdeteksi pada layar. Jika Anda tidak dapat melihat label, coba kurangi jumlah maksimum item yang ditampilkan.",
            child: Text(
              'Gulma Terdeteksi: $detectionCount',
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
          const SizedBox(width: 50),
          StreamingTutorial.tutorial(
            key: fpsKey,
            title: "Frame Per Second (FPS)",
            description:
                "Menampilkan kecepatan pemrosesan dalam Frames Per Second. FPS yang lebih tinggi berarti deteksi real-time yang lebih halus.",
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
