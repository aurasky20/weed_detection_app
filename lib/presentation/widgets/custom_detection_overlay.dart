import 'package:flutter/material.dart';
import 'package:ultralytics_yolo/models/yolo_result.dart';

class CustomDetectionOverlay extends StatelessWidget {
  final List<YOLOResult> detections;

  const CustomDetectionOverlay({
    super.key,
    required this.detections,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DetectionPainter(detections),
      size: Size.infinite,
    );
  }
}

class DetectionPainter extends CustomPainter {
  final List<YOLOResult> detections;

  DetectionPainter(this.detections);

  @override
  void paint(Canvas canvas, Size size) {
    final boxPaint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    for (final detection in detections) {
      final rect = Rect.fromLTWH(
        detection.boundingBox.left * size.width,
        detection.boundingBox.top * size.height,
        detection.boundingBox.width * size.width,
        detection.boundingBox.height * size.height,
      );

      /// CLAMP supaya tidak keluar layar
      final clampedRect = Rect.fromLTRB(
        rect.left.clamp(0, size.width),
        rect.top.clamp(0, size.height),
        rect.right.clamp(0, size.width),
        rect.bottom.clamp(0, size.height),
      );

      canvas.drawRect(clampedRect, boxPaint);

      final textPainter = TextPainter(
        text: TextSpan(
          text:
              '${detection.className} ${(detection.confidence * 100).toStringAsFixed(0)}%',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            backgroundColor: Colors.purple,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      /// LABEL DI DALAM BOX
      final labelX = clampedRect.left + 4;
      final labelY = clampedRect.top + 4;

      textPainter.paint(canvas, Offset(labelX, labelY));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}