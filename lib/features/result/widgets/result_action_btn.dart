import 'package:flutter/material.dart';

class ResultActionButtons extends StatelessWidget {
  const ResultActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Primary — Scan Ulang
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF246A40), Color(0xFF41B06E)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF41B06E).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.document_scanner_rounded,
                    color: Color(0xFFFFDD34), size: 18),
                SizedBox(width: 8),
                Text(
                  "Scan Again",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 10),

        /// Secondary — Kembali ke Beranda
        GestureDetector(
          onTap: () => Navigator.popUntil(context, (r) => r.isFirst),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFF41B06E).withOpacity(0.35),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home_rounded,
                    color: Color(0xFF41B06E), size: 18),
                SizedBox(width: 8),
                Text(
                  "Back to Home",
                  style: TextStyle(
                    color: Color(0xFF41B06E),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}