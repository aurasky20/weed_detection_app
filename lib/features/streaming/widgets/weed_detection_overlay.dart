import 'package:flutter/material.dart';
import 'package:ultralytics_yolo/models/yolo_result.dart';
import '../controllers/camera_inference_controller.dart';

class WeedDetectionOverlay extends StatelessWidget {
  final List<YOLOResult> detections;

  const WeedDetectionOverlay({super.key, required this.detections});

  @override
  Widget build(BuildContext context) {
    if (detections.isEmpty) return const SizedBox.shrink();
    return CustomPaint(
      painter: _WeedPainter(detections: detections),
      child: const SizedBox.expand(),
    );
  }
}

class _WeedPainter extends CustomPainter {
  final List<YOLOResult> detections;

  const _WeedPainter({required this.detections});

  @override
  void paint(Canvas canvas, Size size) {
    for (final det in detections) {
      // Gunakan normalizedBox (0.0–1.0) lalu scale ke ukuran widget
      final box = det.normalizedBox; // ← pakai ini, bukan boundingBox
      
      final rect = Rect.fromLTRB(
        box.left   * size.width,
        box.top    * size.height,
        box.right  * size.width,
        box.bottom * size.height,
      );

      final color = CameraInferenceController.colorForClass(det.className);
      final label = CameraInferenceController.translateLabel(det.className);
      final confidenceText =
          '$label ${(det.confidence * 100).toStringAsFixed(1)}%';

      // Bounding box
      canvas.drawRect(
        rect,
        Paint()
          ..color = color
          ..strokeWidth = 2.5
          ..style = PaintingStyle.stroke,
      );

      // Label
      final textPainter = TextPainter(
        text: TextSpan(
          text: confidenceText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      const padding = 4.0;
      final labelTop = (rect.top - textPainter.height - padding * 2)
          .clamp(0.0, size.height); // jangan sampai keluar layar atas

      canvas.drawRect(
        Rect.fromLTWH(
          rect.left,
          labelTop,
          textPainter.width + padding * 2,
          textPainter.height + padding * 2,
        ),
        Paint()..color = color.withOpacity(0.85),
      );

      textPainter.paint(
        canvas,
        Offset(rect.left + padding, labelTop + padding),
      );
    }
  }

  @override
  bool shouldRepaint(_WeedPainter old) => old.detections != detections;
}