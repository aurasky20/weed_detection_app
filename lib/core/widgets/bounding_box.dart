import 'package:flutter/material.dart';

class BoundingBox extends StatelessWidget {
  final double x, y, w, h;
  final Color color;

  const BoundingBox({
    required this.x,
    required this.y,
    required this.w,
    required this.h,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      width: w,
      height: h,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 3),
        ),
      ),
    );
  }
}