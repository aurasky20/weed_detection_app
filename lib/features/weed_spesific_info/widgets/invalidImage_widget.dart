import 'package:flutter/material.dart';

class HeroPlaceholder extends StatelessWidget {
  const HeroPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF18230F),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.eco_rounded,
              color: const Color(0xFF41B06E).withOpacity(0.5),
              size: 64,
            ),
            const SizedBox(height: 8),
            Text(
              "Gambar tidak tersedia",
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
