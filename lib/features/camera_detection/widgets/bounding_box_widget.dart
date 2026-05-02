import 'package:flutter/material.dart';
import '../../../core/detection/detection_result.dart';

class BoundingBoxWidget extends StatelessWidget {
  final List<DetectionResult> results;
  final Size screen;

  const BoundingBoxWidget({
    super.key,
    required this.results,
    required this.screen,
  });

  Color getColor(String label) {
    switch (label) {
      case "Daun Lebar":
        return Colors.blue;
      case "Daun Sempit":
        return Colors.purple;
      case "Teki":
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: results.map((res) {
        return Positioned(
          left: res.x * screen.width,
          top: res.y * screen.height,
          width: res.w * screen.width,
          height: res.h * screen.height,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: getColor(res.label),
                width: 3,
              ),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                color: getColor(res.label),
                padding: const EdgeInsets.all(4),
                child: Text(
                  "${res.label} ${(res.confidence * 100).toStringAsFixed(1)}%",
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}