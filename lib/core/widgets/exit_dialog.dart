import 'package:flutter/material.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF41B06E).withOpacity(0.18),
              blurRadius: 32,
              offset: const Offset(0, 12),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              child: Column(
                children: [
                  /// Icon badge
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF18230F), Color(0xFF41B06E)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF41B06E).withOpacity(0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.eco_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Title
                  const Text(
                    "Keluar dari WeedCheck",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF18230F),
                      letterSpacing: -0.3,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Subtitle
                  Text(
                    "Apakah Anda yakin ingin keluar dari aplikasi?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: const Color(0xFF18230F).withOpacity(0.55),
                      height: 1.55,
                    ),
                  ),

                  const SizedBox(height: 28),

                  /// Action buttons
                  Row(
                    children: [
                      /// Cancel button
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context, false),
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4FCF0),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFF87D05F).withOpacity(0.4),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Batal",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF41B06E),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      /// Exit button
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context, true),
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFDD34).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFFEF9651).withOpacity(0.5),
                                width: 1.5,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Ya, Keluar",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF18230F),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
