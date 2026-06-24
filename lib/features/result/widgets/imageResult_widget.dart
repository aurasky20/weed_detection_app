import 'dart:io';
import 'package:flutter/material.dart';

class ResultImage extends StatelessWidget {
  final String imagePath;

  const ResultImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 375,
      color: const Color(0xFF18230F),
      child: Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const _ImagePlaceholder(),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF0FAF4),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.broken_image_rounded,
              color: const Color(0xFF41B06E).withOpacity(0.4),
              size: 48,
            ),
            const SizedBox(height: 8),
            Text(
              "Image not available",
              style: TextStyle(
                color: const Color(0xFF18230F).withOpacity(0.4),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
